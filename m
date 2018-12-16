From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 9/9] ASoC: Intel: boards: use
	snd_mask_set_format in all machine drivers
Date: Sun, 16 Dec 2018 16:49:10 -0600
Message-ID: <20181216224910.16198-10-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B41267ABD
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:27 +0100 (CET)
In-Reply-To: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Fix Sparse warnings with two machine drivers which weren't updated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c74c4f17316f..0739e3a75083 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -164,7 +164,7 @@ static int geminilake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 723a4935ed76..6dd5c69671b3 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -221,7 +221,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	}
 
 	/*
@@ -229,7 +229,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
-- 
2.17.1
