From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 01/10] ASoC: wm8510: remove invalid free of devm_ allocated data
Date: Thu, 22 Nov 2012 09:38:33 +0530
Message-ID: <1353557322-25353-2-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Fixes following warning.
sound/soc/codecs/wm8510.c:614:1-6: WARNING: invalid free of devm_ allocated data

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/wm8510.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index c12a54e..923e7e1 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -608,10 +608,7 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 /* power down chip */
 static int wm8510_remove(struct snd_soc_codec *codec)
 {
-	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
-
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	kfree(wm8510);
 	return 0;
 }
 
-- 
1.7.4.1
