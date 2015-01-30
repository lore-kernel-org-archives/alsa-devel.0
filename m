From: Filip Brozovic <fbrozovic@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Use shift mask when setting codec mode
Date: Fri, 30 Jan 2015 12:58:24 +0100
Message-ID: <1422619104-6266-1-git-send-email-fbrozovic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Filip Brozovic <fbrozovic@gmail.com>
List-Id: alsa-devel@alsa-project.org

Shift the I2S mode value by the necessary amount before writing the
registers. This makes Right Justified and PCM mode work in addition to
the default Left Justified mode.

Signed-off-by: Filip Brozovic <fbrozovic@gmail.com>
---
 sound/soc/codecs/sgtl5000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 29cf7ce..7665016 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -483,21 +483,21 @@ static int sgtl5000_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* setting i2s data format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
-		i2sctl |= SGTL5000_I2S_MODE_PCM;
+		i2sctl |= SGTL5000_I2S_MODE_PCM << SGTL5000_I2S_MODE_SHIFT;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		i2sctl |= SGTL5000_I2S_MODE_PCM;
+		i2sctl |= SGTL5000_I2S_MODE_PCM << SGTL5000_I2S_MODE_SHIFT;
 		i2sctl |= SGTL5000_I2S_LRALIGN;
 		break;
 	case SND_SOC_DAIFMT_I2S:
-		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
+		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ << SGTL5000_I2S_MODE_SHIFT;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		i2sctl |= SGTL5000_I2S_MODE_RJ;
+		i2sctl |= SGTL5000_I2S_MODE_RJ << SGTL5000_I2S_MODE_SHIFT;
 		i2sctl |= SGTL5000_I2S_LRPOL;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
+		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ << SGTL5000_I2S_MODE_SHIFT;
 		i2sctl |= SGTL5000_I2S_LRALIGN;
 		break;
 	default:
-- 
2.1.4
