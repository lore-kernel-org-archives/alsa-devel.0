From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/14] ASoC: Intel: bytcr-rt5651: fix capture
	routes
Date: Tue, 22 Aug 2017 15:32:32 -0500
Message-ID: <20170822203239.19891-8-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CD60266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:13 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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

There is only one dmic path and the routes were not added.
Probably a copy-paste mistake when initially creating the
file

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4a3516b..441f735 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -54,12 +54,9 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Speaker", NULL, "LOUTR"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] = {
-	{"DMIC1", NULL, "Internal Mic"},
-};
-
-static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic2_map[] = {
-	{"DMIC2", NULL, "Internal Mic"},
+static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
+	{"DMIC L1", NULL, "Internal Mic"},
+	{"DMIC R1", NULL, "Internal Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
@@ -133,14 +130,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
-	case BYT_RT5651_DMIC2_MAP:
-		custom_map = byt_rt5651_intmic_dmic2_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic2_map);
-		break;
 	default:
-		custom_map = byt_rt5651_intmic_dmic1_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic1_map);
+		custom_map = byt_rt5651_intmic_dmic_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
 	}
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
 
 	ret = snd_soc_add_card_controls(card, byt_rt5651_controls,
 					ARRAY_SIZE(byt_rt5651_controls));
-- 
2.9.3
