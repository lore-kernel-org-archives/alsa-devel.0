From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: add support for DSP modes" to
	the asoc tree
Date: Thu, 09 Nov 2017 17:43:45 +0000
Message-ID: <E1eCqrh-0006gb-2B@debutante>
References: <20171108224231.30564-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B4E58267877
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:43:50 +0100 (CET)
In-Reply-To: <20171108224231.30564-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: add support for DSP modes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e0d746cc0155a51cc24eb56286cd21a2c5aa4985 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 8 Nov 2017 16:42:31 -0600
Subject: [PATCH] ASoC: da7213: add support for DSP modes

DSP modes are documented in the data sheet but not enabled in the driver.
The work-around already implemented for DA7218/9 is also required to
make sure the bit clock handling in DSP modes follows ASoC conventions.

Tested with ARD-AUDIO-DA7212 and Minnowmax Turbot boards

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 58 +++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index cc0b2d2eaf15..41d9b1da27c2 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1220,6 +1220,7 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
 	u8 dai_clk_mode = 0, dai_ctrl = 0;
+	u8 dai_offset = 0;
 
 	/* Set master/slave mode */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1234,17 +1235,46 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	}
 
 	/* Set clock normal/inverted */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV |
+					DA7213_DAI_CLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		dai_clk_mode |= DA7213_DAI_WCLK_POL_INV | DA7213_DAI_CLK_POL_INV;
+	case SND_SOC_DAI_FORMAT_DSP_A:
+	case SND_SOC_DAI_FORMAT_DSP_B:
+		/* The bclk is inverted wrt ASoC conventions */
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV |
+					DA7213_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -1261,6 +1291,13 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_RIGHT_J:
 		dai_ctrl |= DA7213_DAI_FORMAT_RIGHT_J;
 		break;
+	case SND_SOC_DAI_FORMAT_DSP_A: /* L data MSB after FRM LRC */
+		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
+		dai_offset = 1;
+		break;
+	case SND_SOC_DAI_FORMAT_DSP_B: /* L data MSB during FRM LRC */
+		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1271,6 +1308,7 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	snd_soc_write(codec, DA7213_DAI_CLK_MODE, dai_clk_mode);
 	snd_soc_update_bits(codec, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
 			    dai_ctrl);
+	snd_soc_write(codec, DA7213_DAI_OFFSET, dai_offset);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 16ef56f77cd4..5a78dba1dcb5 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -188,6 +188,7 @@
 #define DA7213_DAI_FORMAT_I2S_MODE				(0x0 << 0)
 #define DA7213_DAI_FORMAT_LEFT_J				(0x1 << 0)
 #define DA7213_DAI_FORMAT_RIGHT_J				(0x2 << 0)
+#define DA7213_DAI_FORMAT_DSP					(0x3 << 0)
 #define DA7213_DAI_FORMAT_MASK					(0x3 << 0)
 #define DA7213_DAI_WORD_LENGTH_S16_LE				(0x0 << 2)
 #define DA7213_DAI_WORD_LENGTH_S20_LE				(0x1 << 2)
-- 
2.15.0
