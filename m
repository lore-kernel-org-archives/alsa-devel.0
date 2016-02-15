From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Cancel probe work instead of flush
	at remove
Date: Mon, 15 Feb 2016 16:54:57 +0100
Message-ID: <1455551697-5881-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A8A260664
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 16:55:00 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 67EB1AAB4
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:55:00 +0000 (UTC)
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

The commit [991f86d7ae4e: ALSA: hda - Flush the pending probe work at
remove] introduced the sync of async probe work at remove for fixing
the race.  However, this may lead to another hangup when the module
removal is performed quickly before starting the probe work, because
it issues flush_work() and it's blocked forever.

The workaround is to use cancel_work_sync() instead of flush_work()
there.

Fixes: 991f86d7ae4e ('ALSA: hda - Flush the pending probe work at remove')
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4045dca3d699..ce6b97f31390 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2168,10 +2168,10 @@ static void azx_remove(struct pci_dev *pci)
 	struct hda_intel *hda;
 
 	if (card) {
-		/* flush the pending probing work */
+		/* cancel the pending probing work */
 		chip = card->private_data;
 		hda = container_of(chip, struct hda_intel, chip);
-		flush_work(&hda->probe_work);
+		cancel_work_sync(&hda->probe_work);
 
 		snd_card_free(card);
 	}
-- 
2.7.1
