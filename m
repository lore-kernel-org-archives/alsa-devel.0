From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht-bsw-rt5645: fix DAI formats"
	to the asoc tree
Date: Tue, 31 Jan 2017 21:17:29 +0000
Message-ID: <E1cYfnt-0000uR-LQ@debutante>
References: <1485461385-14544-18-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89AB52673E7
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:39 +0100 (CET)
In-Reply-To: <1485461385-14544-18-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht-bsw-rt5645: fix DAI formats

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

>From 7bde09dfcf600e7a5c76a5325c6c3dfa60d08295 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:45 -0600
Subject: [PATCH] ASoC: Intel: cht-bsw-rt5645: fix DAI formats

Remove default and set I2S mode correctly both on codec and
cpu sides

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 39 ++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index a97eef6860ff..b972b6526176 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -304,13 +304,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
-	if (ret < 0) {
-		dev_err(runtime->dev, "can't set codec TDM slot %d\n", ret);
-		return ret;
-	}
-
 	if (ctx->acpi_card->codec_type == CODEC_TYPE_RT5650)
 		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
@@ -377,7 +370,17 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		 */
 		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
 					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_IF   |
+					SND_SOC_DAIFMT_NB_NF   |
+					SND_SOC_DAIFMT_CBS_CFS
+			);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_fmt(rtd->codec_dai,
+					SND_SOC_DAIFMT_I2S     |
+					SND_SOC_DAIFMT_NB_NF   |
 					SND_SOC_DAIFMT_CBS_CFS
 			);
 		if (ret < 0) {
@@ -396,6 +399,24 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		/* set SSP2 to 24-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 
+		/*
+		 * Default mode for SSP configuration is TDM 4 slot
+		 */
+		ret = snd_soc_dai_set_fmt(rtd->codec_dai,
+					SND_SOC_DAIFMT_DSP_B |
+					SND_SOC_DAIFMT_IB_NF |
+					SND_SOC_DAIFMT_CBS_CFS);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set format to TDM %d\n", ret);
+			return ret;
+		}
+
+		/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
+		ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0xF, 0xF, 4, 24);
+		if (ret < 0) {
+			dev_err(rtd->dev, "can't set codec TDM slot %d\n", ret);
+			return ret;
+		}
 	}
 	return 0;
 }
@@ -458,8 +479,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.no_pcm = 1,
 		.codec_dai_name = "rt5645-aif1",
 		.codec_name = "i2c-10EC5645:00",
-		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
-					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
 		.be_hw_params_fixup = cht_codec_fixup,
 		.nonatomic = true,
-- 
2.11.0
