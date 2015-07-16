From: kernelpatch_update <kernelpatch_update@163.com>
Subject: [PATCH] ALSA: hda: fix kstrdup return value
Date: Thu, 16 Jul 2015 09:04:10 +0800
Message-ID: <1437008650-23478-1-git-send-email-kernelpatch_update@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, kailang@realtek.com, hui.wang@canonical.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernelpatch_update <kernelpatch_update@163.com>
List-Id: alsa-devel@alsa-project.org

In kstrdup we should return -ENOMEM when it reports an 
memory allocation failure, while the -ENODEV is referred
to a failure in finding the cpu node in the device tree.

Signed-off-by: kernelpatch_update <kernelpatch_update@163.com>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5de3c5d..d78fa71 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -975,7 +975,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (codec->bus->modelname) {
 		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
 		if (!codec->modelname) {
-			err = -ENODEV;
+			err = -ENOMEM;
 			goto error;
 		}
 	}
-- 
1.9.1
