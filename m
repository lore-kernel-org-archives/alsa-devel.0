From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: free memory when unloaded or closed" to the asoc tree
Date: Wed, 27 Apr 2016 17:35:00 +0100
Message-ID: <E1avSQW-0004P7-Dg@debutante>
References: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: free memory when unloaded or closed

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

>From 66225e98b985047ef214632413cc404a6341c960 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 27 Apr 2016 14:58:27 +0100
Subject: [PATCH] ASoC: wm_adsp: free memory when unloaded or closed

The patch adds a wm_adsp2_remove() function to ensure that memory
is freed when the driver is unloaded or shut down.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 20 ++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d3b1cb15e7f0..5f8727af912b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -944,6 +944,13 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 	kfree(ctl_work);
 }
 
+static void wm_adsp_free_ctl_blk(struct wm_coeff_ctl *ctl)
+{
+	kfree(ctl->cache);
+	kfree(ctl->name);
+	kfree(ctl);
+}
+
 static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
@@ -2340,6 +2347,19 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
 
+void wm_adsp2_remove(struct wm_adsp *dsp)
+{
+	struct wm_coeff_ctl *ctl;
+
+	while (!list_empty(&dsp->ctl_list)) {
+		ctl = list_first_entry(&dsp->ctl_list, struct wm_coeff_ctl,
+					list);
+		list_del(&ctl->list);
+		wm_adsp_free_ctl_blk(ctl);
+	}
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_remove);
+
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
 	struct wm_adsp_compr *compr;
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index b61cb57e600f..feb61e2c4bb4 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -92,6 +92,7 @@ extern const struct snd_kcontrol_new wm_adsp_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
+void wm_adsp2_remove(struct wm_adsp *dsp);
 int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec);
 int wm_adsp2_codec_remove(struct wm_adsp *dsp, struct snd_soc_codec *codec);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
-- 
2.8.0.rc3
