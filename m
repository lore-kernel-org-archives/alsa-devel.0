From: yang.a.fang@intel.com
Subject: [PATCH v3 2/2] ASoC: Intel: fix machine driver warnings
Date: Mon,  9 Feb 2015 00:18:12 -0800
Message-ID: <1423469892-48667-2-git-send-email-yang.a.fang@intel.com>
References: <1423440097-95191-1-git-send-email-yang.a.fang@intel.com>
 <1423469892-48667-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8B22605CD
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:18:34 +0100 (CET)
In-Reply-To: <1423469892-48667-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, kevin.strasser@intel.com, vinod.koul@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, tiwai@suse.de, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

this patch will fix below sparse warnings

warning: incorrect type in argument 2 (different base types) expected
unsigned int [unsigned] val got restricted snd_pcm_format_t [usertype]
<noident>

sound/soc/intel/haswell.c:61:37
sound/soc/intel/broadwell.c:115:37:
sound/soc/intel/bytcr_dpcm_rt5640.c:118:37:
sound/soc/intel/cht_bsw_rt5672.c:183:37:
sound/soc/intel/cht_bsw_rt5645.c:208:37:

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/broadwell.c         |    4 +---
 sound/soc/intel/bytcr_dpcm_rt5640.c |    4 +---
 sound/soc/intel/cht_bsw_rt5645.c    |    4 +---
 sound/soc/intel/cht_bsw_rt5672.c    |    4 +---
 sound/soc/intel/haswell.c           |    4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 9cf7d01..fba2ef5 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -110,9 +110,7 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP0 to 16 bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/bytcr_dpcm_rt5640.c b/sound/soc/intel/bytcr_dpcm_rt5640.c
index 5930862..3b262d0 100644
--- a/sound/soc/intel/bytcr_dpcm_rt5640.c
+++ b/sound/soc/intel/bytcr_dpcm_rt5640.c
@@ -113,9 +113,7 @@ static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP2 to 24-bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/cht_bsw_rt5645.c
index b6f8377..0fc5db7 100644
--- a/sound/soc/intel/cht_bsw_rt5645.c
+++ b/sound/soc/intel/cht_bsw_rt5645.c
@@ -203,9 +203,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP2 to 24-bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index ff01662..c56f9df 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -178,9 +178,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP2 to 24-bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 35edf51..00fddd3 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -56,9 +56,7 @@ static int haswell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP0 to 16 bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
-- 
1.7.9.5
