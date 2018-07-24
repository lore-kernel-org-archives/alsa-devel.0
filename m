From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/6] ASoC: Intel: boards: cleanup snd_mask_set
	usage
Date: Tue, 24 Jul 2018 16:12:43 -0500
Message-ID: <20180724211248.29427-2-pierre-louis.bossart@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 893F026770A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:12:58 +0200 (CEST)
In-Reply-To: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse reports a ton of warnings when snd_mask_set is used (see
e.g. below). Fix by adding the right typecast with the __force
attribute. The code is less readable but with fewer warnings it's
easier to track the real issues and improve the rest of the code.

 CHECK   sound/soc/intel/boards/skl_nau88l25_max98357a.c
sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27: warning: incorrect type in argument 2 (different base types)
sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27:    expected unsigned int [unsigned] val
sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27:    got restricted snd_pcm_format_t [usertype] <noident>

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c                 | 2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/bxt_rt298.c                  | 2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c       | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 6 ++++--
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 6 ++++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       | 2 +-
 sound/soc/intel/boards/skl_rt286.c                  | 2 +-
 10 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 6ea360f33575..17037892c16b 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -156,7 +156,7 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	/* set SSP0 to 16 bit */
 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+				(__force unsigned int)SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3aba5bcf806a..726412599b7a 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -160,7 +160,7 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index b68c289558a8..0bef1922bdce 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -221,7 +221,7 @@ static int broxton_ssp5_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP5 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c4b94e2617c5..fc4eb2fa773f 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -164,7 +164,7 @@ static int geminilake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 7961f1fd18bd..0f315b0e9724 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -152,7 +152,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 3a61252fe450..8c7a81fef220 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -434,14 +434,16 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set(fmt,
+			     (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 	}
 	/*
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set(fmt,
+			     (__force unsigned int)SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 92f5fb2ae0a3..155e0dc00401 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -307,7 +307,8 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set(fmt,
+			     (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
 		if (params_channels(params) == 2 ||
 				DMIC_CH(dmic_constraints) == 2)
@@ -320,7 +321,8 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set(fmt,
+			     (__force unsigned int)SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 3ff6646cfa21..2558e494231b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -157,7 +157,7 @@ static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index b0610bba3cfa..3e59437784d8 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -346,7 +346,7 @@ static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 38a1495c29cf..807ab0c57c14 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -229,7 +229,7 @@ static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set(fmt, (__force unsigned int)SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
-- 
2.14.1
