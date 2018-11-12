From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Call pci_iounmap() instead
	of iounmap()
Date: Mon, 12 Nov 2018 12:31:21 +0100
Message-ID: <20181112113121.1821-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2604326751A
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 12:31:23 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6BA6EB06C
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 11:31:23 +0000 (UTC)
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

We need to call pci_iounmap() instead of iounmap() for the regions
obtained via pci_iomap() call for some archs that need special
treatment.

Fixes: aa31704fd81c ("ALSA: hda/ca0132: Add PCI region2 iomap for SBZ")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0a24037184c3..bdbbc51e8d18 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8413,7 +8413,7 @@ static void ca0132_free(struct hda_codec *codec)
 
 	snd_hda_power_down(codec);
 	if (spec->mem_base)
-		iounmap(spec->mem_base);
+		pci_iounmap(codec->bus->pci, spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
-- 
2.19.1
