From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 5/9] ASoC: Intel: bytcht_es8316: remove
	useless code
Date: Thu, 12 Oct 2017 18:38:01 -0500
Message-ID: <20171012233805.30055-6-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A96266F1C
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:19 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

get_codec_dai() is not used, remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 52635462dac6..9ed4400c13b8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -37,20 +37,6 @@ struct byt_cht_es8316_private {
 	struct clk *mclk;
 };
 
-#define CODEC_DAI1	"ES8316 HiFi"
-
-static inline struct snd_soc_dai *get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CODEC_DAI1,
-			     strlen(CODEC_DAI1)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
-- 
2.11.0
