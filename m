From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: set SSP to I2S
	mode 2ch" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:35 +0000
Message-ID: <E1aAG2x-0004h7-Iq@debutante>
References: <1450406156-22246-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2067E260597
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:41 +0100 (CET)
In-Reply-To: <1450406156-22246-3-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: set SSP to I2S mode 2ch

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3f27dedda463347e98d406fc97ff6767ac59ea05 Mon Sep 17 00:00:00 2001
From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Date: Thu, 17 Dec 2015 20:35:39 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: set SSP to I2S mode 2ch

Using the hw_fixup function in order to overwrite the default SSP
setting for Audio DSP port connected to the codec. Instead of
TDM 4ch use I2S 2ch 24 bits.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7a5c9a36c1db..66d37b0e64d1 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -107,6 +107,7 @@ static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
+	int ret;
 
 	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
 	rate->min = rate->max = 48000;
@@ -114,6 +115,28 @@ static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP2 to 24-bit */
 	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot, override config
+	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+	 * dai_set_tdm_slot() since there is no other API exposed
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+				  SND_SOC_DAIFMT_I2S     |
+				  SND_SOC_DAIFMT_NB_IF   |
+				  SND_SOC_DAIFMT_CBS_CFS
+				  );
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.6.2
