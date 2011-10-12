From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH 5/9] ASoC: da7210: Add support for other DAI
 word lengths, format and mode
Date: Wed, 12 Oct 2011 20:33:21 +0530
Message-ID: <1318431801.12107.416.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B823103815
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 16:52:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patchs adds support for following,
(1) DAI 20 and 32 bit word sizes
(2) DAI left and right justified formats
(3) DAI slave mode

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 1b4554a..60f403b 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -120,12 +120,17 @@
 
 /* DAI_CFG1 bit fields */
 #define DA7210_DAI_WORD_S16_LE		(0 << 0)
+#define DA7210_DAI_WORD_S20_3LE		(1 << 0)
 #define DA7210_DAI_WORD_S24_LE		(2 << 0)
+#define DA7210_DAI_WORD_S32_LE		(3 << 0)
 #define DA7210_DAI_FLEN_64BIT		(1 << 2)
+#define DA7210_DAI_MODE_SLAVE		(0 << 7)
 #define DA7210_DAI_MODE_MASTER		(1 << 7)
 
 /* DAI_CFG3 bit fields */
 #define DA7210_DAI_FORMAT_I2SMODE	(0 << 0)
+#define DA7210_DAI_FORMAT_LEFT_J	(1 << 0)
+#define DA7210_DAI_FORMAT_RIGHT_J	(2 << 0)
 #define DA7210_DAI_OE			(1 << 3)
 #define DA7210_DAI_EN			(1 << 7)
 
@@ -401,9 +406,15 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dai_cfg1 |= DA7210_DAI_WORD_S16_LE;
 		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		dai_cfg1 |= DA7210_DAI_WORD_S20_3LE;
+		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		dai_cfg1 |= DA7210_DAI_WORD_S24_LE;
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dai_cfg1 |= DA7210_DAI_WORD_S32_LE;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -508,6 +519,9 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 	case SND_SOC_DAIFMT_CBM_CFM:
 		dai_cfg1 |= DA7210_DAI_MODE_MASTER;
 		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		dai_cfg1 |= DA7210_DAI_MODE_SLAVE;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -520,6 +534,12 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 	case SND_SOC_DAIFMT_I2S:
 		dai_cfg3 |= DA7210_DAI_FORMAT_I2SMODE;
 		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		dai_cfg3 |= DA7210_DAI_FORMAT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		dai_cfg3 |= DA7210_DAI_FORMAT_RIGHT_J;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -536,7 +556,8 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 	return 0;
 }
 
-#define DA7210_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define DA7210_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 /* DAI operations */
 static struct snd_soc_dai_ops da7210_dai_ops = {
-- 
1.7.1
