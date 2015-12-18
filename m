From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 02/19] ASoC: Intel: bytcr_rt5640: set SSP to
	I2S mode 2ch
Date: Thu, 17 Dec 2015 20:35:39 -0600
Message-ID: <1450406156-22246-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DD85C26155D
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:07 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bardliao@realtek.com, broonie@kernel.org, Sebastien Guiriec <sebastien.guiriec@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Sebastien Guiriec <sebastien.guiriec@intel.com>

Using the hw_fixup function in order to overwrite the default SSP
setting for Audio DSP port connected to the codec. Instead of
TDM 4ch use I2S 2ch 24 bits.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7a5c9a3..66d37b0 100644
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
1.9.1
