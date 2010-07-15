From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 6/12] wm8904: fix resource reclaim in wm8904_register error
	path
Date: Thu, 15 Jul 2010 10:59:28 +0800
Message-ID: <1279162768.29294.17.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch includes below fixes:
1. wm8904 need to be kfreed in wm8904_register() error path before return.
2. fix the error path for snd_soc_register_codec() fail and
   snd_soc_register_dai() fail to properly free resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8904.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 87f14f8..f7dcabf 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2433,7 +2433,8 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 
 	if (wm8904_codec) {
 		dev_err(codec->dev, "Another WM8904 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	mutex_init(&codec->mutex);
@@ -2462,7 +2463,8 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 	default:
 		dev_err(codec->dev, "Unknown device type %d\n",
 			wm8904->devtype);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	memcpy(codec->reg_cache, wm8904_reg, sizeof(wm8904_reg));
@@ -2566,18 +2568,19 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = snd_soc_register_dai(&wm8904_dai);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
+		goto err_codec;
 	}
 
 	return 0;
 
+err_codec:
+	snd_soc_unregister_codec(codec);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 err_get:
-- 
1.5.4.3
