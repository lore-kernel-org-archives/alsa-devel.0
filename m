From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/17] ASoC: Intel: atom: fix frame polarity
Date: Thu, 26 Jan 2017 14:09:29 -0600
Message-ID: <1485461385-14544-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2599A267774
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:20 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The current frame sync polarity definitions are inconsistent in the
Atom/DPCM driver, fix to align with regular ASoC definitions and
update code in platform and machine drivers for RT5640 and RT5651.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 6 ++----
 sound/soc/intel/boards/bytcr_rt5640.c    | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c    | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index c7b3cbf..df4430b 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -801,13 +801,11 @@ static int sst_get_frame_sync_polarity(struct snd_soc_dai *dai,
 
 	switch (format) {
 	case SND_SOC_DAIFMT_NB_NF:
-		return SSP_FS_ACTIVE_LOW;
-	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
 		return SSP_FS_ACTIVE_HIGH;
+	case SND_SOC_DAIFMT_NB_IF:
 	case SND_SOC_DAIFMT_IB_IF:
 		return SSP_FS_ACTIVE_LOW;
-	case SND_SOC_DAIFMT_IB_NF:
-		return SSP_FS_ACTIVE_HIGH;
 	default:
 		dev_err(dai->dev, "Invalid frame sync polarity %d\n", format);
 	}
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 1bd985f..cae441a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -556,7 +556,7 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		 */
 		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
 					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_IF   |
+					SND_SOC_DAIFMT_NB_NF   |
 					SND_SOC_DAIFMT_CBS_CFS
 			);
 		if (ret < 0) {
@@ -582,7 +582,7 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		 */
 		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
 					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_IF   |
+					SND_SOC_DAIFMT_NB_NF   |
 					SND_SOC_DAIFMT_CBS_CFS
 			);
 		if (ret < 0) {
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 2d24dc0..403dbfb 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -185,7 +185,7 @@ static int byt_rt5651_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	 */
 	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
 				  SND_SOC_DAIFMT_I2S     |
-				  SND_SOC_DAIFMT_NB_IF   |
+				  SND_SOC_DAIFMT_NB_NF   |
 				  SND_SOC_DAIFMT_CBS_CFS
 				  );
 
-- 
2.7.4
