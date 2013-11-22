From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/5] ASoC: wm8990: Mark the register map as dirty when powering down
Date: Fri, 22 Nov 2013 14:39:48 +0000
Message-ID: <1385131192-28693-1-git-send-email-broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensouce.wolfsonmicro.com, Mark Brown <broonie@linaro.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Otherwise we'll skip sync on resume.

Signed-off-by: Mark Brown <broonie@linaro.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8990.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 253c88bb7a4c..4f05fb88bddf 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1259,6 +1259,8 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
 		snd_soc_write(codec, WM8990_ANTIPOP2, 0x0);
+
+		codec->cache_sync = 1;
 		break;
 	}
 
-- 
1.8.4.4
