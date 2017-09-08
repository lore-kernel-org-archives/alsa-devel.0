From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/7] ASoC: Intel: cht_bsw_max98090: Fix I2S
	config + unused code
Date: Fri,  8 Sep 2017 00:13:04 -0500
Message-ID: <20170908051309.19028-3-pierre-louis.bossart@linux.intel.com>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 830A82674E4
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 07:13:26 +0200 (CEST)
In-Reply-To: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This driver probably never worked, the slots are configured
for 2ch 16 bit and the SSP2 as 24 bits, the cpu_dai configured as
LEFT_J and the codec_dai as I2S.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 20755ec..455a55a 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -160,7 +160,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		return ret;
 	}
 
-	fmt = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBS_CFS;
 
 	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
@@ -173,8 +173,8 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
-	/* set SSP2 to 24-bit */
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+	/* set SSP2 to 16-bit */
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
-- 
2.9.3
