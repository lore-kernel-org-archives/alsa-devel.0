From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht-bsw-rt5672: allow for
	topology-defined codec-dai setup" to the asoc tree
Date: Tue,  1 May 2018 22:08:55 +0100 (BST)
Message-ID: <20180501210855.C1AA144007A@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8405F267650
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 23:09:00 +0200 (CEST)
In-Reply-To: 
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
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht-bsw-rt5672: allow for topology-defined codec-dai setup

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

>From bf14adcc4ddd101088237179bee6daa19bac1669 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 27 Apr 2018 16:36:00 -0500
Subject: [PATCH] ASoC: Intel: cht-bsw-rt5672: allow for topology-defined
 codec-dai setup

Hard-coded setups conflict with topology defined ones. Move this code to
codec_fixup so that SOF can override codec dai settings, e.g. to only use
2 channels.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index e68ec32720a4..e5aa13058dd7 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -189,13 +189,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	if (devm_acpi_dev_add_driver_gpios(component->dev, cht_rt5672_gpios))
 		dev_warn(runtime->dev, "Unable to add GPIO mapping table\n");
 
-	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
-	if (ret < 0) {
-		dev_err(runtime->dev, "can't set codec TDM slot %d\n", ret);
-		return ret;
-	}
-
 	/* Select codec ASRC clock source to track I2S1 clock, because codec
 	 * is in slave mode and 100fs I2S format (BCLK = 100 * LRCLK) cannot
 	 * be supported by RT5672. Otherwise, ASRC will be disabled and cause
@@ -252,6 +245,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
+	int ret;
 
 	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
 	rate->min = rate->max = 48000;
@@ -259,6 +253,26 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP2 to 24-bit */
 	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->codec_dai,
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_IB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to TDM %d\n", ret);
+		return ret;
+	}
+
+	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
+	ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0xF, 0xF, 4, 24);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec TDM slot %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -315,8 +329,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.nonatomic = true,
 		.codec_dai_name = "rt5670-aif1",
 		.codec_name = "i2c-10EC5670:00",
-		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
-					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
 		.be_hw_params_fixup = cht_codec_fixup,
 		.dpcm_playback = 1,
-- 
2.17.0
