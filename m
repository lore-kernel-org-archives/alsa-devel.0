From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 7/12] wm8940: fix resource reclaim in wm8940_register error
	path
Date: Thu, 15 Jul 2010 11:01:33 +0800
Message-ID: <1279162893.29294.20.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From 44c93254e5158e3086c4707148d24746067f6b14 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 15 Jul 2010 10:13:34 +0800
Subject: [PATCH] wm8940: fix resource reclaim in wm8940_register error path

This patch fixes the error path in wm8940_register to properly free resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8940.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index e3c4bbf..9673e6f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -766,7 +766,8 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 	u16 reg;
 	if (wm8940_codec) {
 		dev_err(codec->dev, "Another WM8940 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -785,7 +786,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	memcpy(codec->reg_cache, wm8940_reg_defaults,
@@ -794,7 +795,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 	ret = wm8940_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
+		goto err;
 	}
 
 	wm8940_dai.dev = codec->dev;
@@ -803,7 +804,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 
 	ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	if (!pdata)
 		dev_warn(codec->dev, "No platform data supplied\n");
@@ -811,7 +812,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 		reg = snd_soc_read(codec, WM8940_OUTPUTCTL);
 		ret = snd_soc_write(codec, WM8940_OUTPUTCTL, reg | pdata->vroi);
 		if (ret < 0)
-			return ret;
+			goto err;
 	}
 
 
@@ -820,17 +821,22 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 	ret = snd_soc_register_codec(codec);
 	if (ret) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	ret = snd_soc_register_dai(&wm8940_dai);
 	if (ret) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
+		goto err_codec;
 	}
 
 	return 0;
+
+err_codec:
+	snd_soc_unregister_codec(codec);
+err:
+	kfree(wm8940);
+	return ret;
 }
 
 static void wm8940_unregister(struct wm8940_priv *wm8940)
-- 
1.5.4.3
