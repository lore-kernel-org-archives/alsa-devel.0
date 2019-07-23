From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] ALSA: ac97: Fix double free of ac97_codec_device
Date: Tue, 23 Jul 2019 15:44:41 +0800
Message-ID: <1563867881-2554-1-git-send-email-dingxiang@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

put_device will call ac97_codec_release to free
ac97_codec_device and other resources, so remove the kfree
and other redundant code.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 sound/ac97/bus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7b977b7..7985dd8 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -122,17 +122,12 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 						      vendor_id);
 
 	ret = device_add(&codec->dev);
-	if (ret)
-		goto err_free_codec;
+	if (ret) {
+		put_device(&codec->dev);
+		return ret;
+	}
 
 	return 0;
-err_free_codec:
-	of_node_put(codec->dev.of_node);
-	put_device(&codec->dev);
-	kfree(codec);
-	ac97_ctrl->codecs[idx] = NULL;
-
-	return ret;
 }
 
 unsigned int snd_ac97_bus_scan_one(struct ac97_controller *adrv,
-- 
1.9.1
