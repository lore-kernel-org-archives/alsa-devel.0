From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: factor out freeing of alg regions" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:54 +0100
Message-ID: <E1avSQQ-0004NV-HT@debutante>
References: <1461765509-9431-3-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765509-9431-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: factor out freeing of alg regions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 56574d541f93cf8c9449f9ecadc83d97323cfcec Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 27 Apr 2016 14:58:29 +0100
Subject: [PATCH] ASoC: wm_adsp: factor out freeing of alg regions

Add a function to delete and free the contents of the alg_regions list.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5f8727af912b..8cde7bb4c52b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1571,6 +1571,19 @@ static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
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
@@ -2001,7 +2014,6 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 	unsigned int val;
@@ -2081,13 +2093,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
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
@@ -2229,7 +2236,6 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
@@ -2276,13 +2282,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
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
2.8.0.rc3
