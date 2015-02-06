From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: fix machine driver warnings
Date: Thu,  5 Feb 2015 16:19:16 -0800
Message-ID: <1423181956-108810-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC7D26053E
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 01:19:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, kevin.strasser@intel.com, vinod.koul@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

this patch will fix below sparse warnings

warning: incorrect type in argument 2 (different base types)
expected unsigned int [unsigned] val
got restricted snd_pcm_format_t [usertype] <noident>

sound/soc/intel/haswell.c:61:37
sound/soc/intel/broadwell.c:115:37:
sound/soc/intel/bytcr_dpcm_rt5640.c:118:37:
sound/soc/intel/cht_bsw_rt5672.c:183:37:
sound/soc/intel/cht_bsw_rt5645.c:208:37:

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/broadwell.c         |    2 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c |    2 +-
 sound/soc/intel/cht_bsw_rt5645.c    |    2 +-
 sound/soc/intel/cht_bsw_rt5672.c    |    2 +-
 sound/soc/intel/haswell.c           |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 9cf7d01..0ca4015 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -112,7 +112,7 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP0 to 16 bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+				    (__force int)SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/bytcr_dpcm_rt5640.c b/sound/soc/intel/bytcr_dpcm_rt5640.c
index 5930862..b171443 100644
--- a/sound/soc/intel/bytcr_dpcm_rt5640.c
+++ b/sound/soc/intel/bytcr_dpcm_rt5640.c
@@ -115,7 +115,7 @@ static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP2 to 24-bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+				    (__force int)SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/cht_bsw_rt5645.c
index b6f8377..7781fbe 100644
--- a/sound/soc/intel/cht_bsw_rt5645.c
+++ b/sound/soc/intel/cht_bsw_rt5645.c
@@ -205,7 +205,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP2 to 24-bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+				    (__force int)SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index ff01662..b1842fa 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -180,7 +180,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP2 to 24-bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+				    (__force int)SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 35edf51..b19f1ce 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -58,7 +58,7 @@ static int haswell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP0 to 16 bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+				    (__force int)SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
-- 
1.7.9.5
