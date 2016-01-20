From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Flush the pending probe work at
	remove
Date: Wed, 20 Jan 2016 17:29:47 +0100
Message-ID: <1453307387-10858-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 753C9260447
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 17:29:49 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 47D55AC67
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 16:29:48 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As HD-audio driver does deferred probe internally via workqueue, the
driver might go into the mixed state doing both probe and remove when
the module gets unloaded during the probe work.  This eventually
triggers an Oops, unsurprisingly.

For avoiding this race, we just need to flush the pending probe work
explicitly before actually starting the resource release.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=960710
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 86bbc6307c4f..256e6cda218f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2151,9 +2151,17 @@ i915_power_fail:
 static void azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
+	struct azx *chip;
+	struct hda_intel *hda;
+
+	if (card) {
+		/* flush the pending probing work */
+		chip = card->private_data;
+		hda = container_of(chip, struct hda_intel, chip);
+		flush_work(&hda->probe_work);
 
-	if (card)
 		snd_card_free(card);
+	}
 }
 
 static void azx_shutdown(struct pci_dev *pci)
-- 
2.7.0
