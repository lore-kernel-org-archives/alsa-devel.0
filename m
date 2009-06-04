From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] hda_intel: fix build error when !PM
Date: Thu,  4 Jun 2009 13:46:16 +0400
Message-ID: <1244108776-20937-1-git-send-email-a.beregalov@gmail.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-next@vger.kernel.org, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix this build error when CONFIG_PM is not set:
ound/pci/hda/hda_intel.c: In function 'azx_bus_reset':
sound/pci/hda/hda_intel.c:1270: error: implicit declaration of function 'snd_pcm_suspend_all'
sound/pci/hda/hda_intel.c:1271: error: implicit declaration of function 'snd_hda_suspend'
sound/pci/hda/hda_intel.c:1272: error: implicit declaration of function 'snd_hda_resume'

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 sound/pci/hda/hda_intel.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9f44645..4e9ea70 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1260,17 +1260,20 @@ static void azx_stop_chip(struct azx *chip);
 static void azx_bus_reset(struct hda_bus *bus)
 {
 	struct azx *chip = bus->private_data;
-	int i;
 
 	bus->in_reset = 1;
 	azx_stop_chip(chip);
 	azx_init_chip(chip);
+#ifdef CONFIG_PM
 	if (chip->initialized) {
+		int i;
+
 		for (i = 0; i < AZX_MAX_PCMS; i++)
 			snd_pcm_suspend_all(chip->pcm[i]);
 		snd_hda_suspend(chip->bus);
 		snd_hda_resume(chip->bus);
 	}
+#endif
 	bus->in_reset = 0;
 }
 
-- 
1.6.3.1
