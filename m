From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm_adsp: factor out freeing of alg regions
Date: Wed, 27 Apr 2016 14:58:29 +0100
Message-ID: <1461765509-9431-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add a function to delete and free the contents of the alg_regions list.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c350a52..b14ce52 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1661,6 +1661,19 @@ static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
 	return alg_region;
 }
 
+static void wm_adsp_free_alg_regions(struct wm_adsp *dsp)
+{
+	struct wm_adsp_alg_region *alg_region;
+
+	while (!list_empty(&dsp->alg_regions)) {
+		alg_region = list_first_entry(&dsp->alg_regions,
+					      struct wm_adsp_alg_region,
+					      list);
+		list_del(&alg_region->list);
+		kfree(alg_region);
+	}
+}
+
 static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -2091,7 +2104,6 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 	unsigned int val;
@@ -2171,13 +2183,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
 
-		while (!list_empty(&dsp->alg_regions)) {
-			alg_region = list_first_entry(&dsp->alg_regions,
-						      struct wm_adsp_alg_region,
-						      list);
-			list_del(&alg_region->list);
-			kfree(alg_region);
-		}
+
+		wm_adsp_free_alg_regions(dsp);
 		break;
 
 	default:
@@ -2319,7 +2326,6 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
@@ -2370,13 +2376,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
 
-		while (!list_empty(&dsp->alg_regions)) {
-			alg_region = list_first_entry(&dsp->alg_regions,
-						      struct wm_adsp_alg_region,
-						      list);
-			list_del(&alg_region->list);
-			kfree(alg_region);
-		}
+		wm_adsp_free_alg_regions(dsp);
 
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			wm_adsp_buffer_free(dsp);
-- 
1.9.1
