From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm_adsp: free memory when unloaded or closed
Date: Wed, 27 Apr 2016 14:58:27 +0100
Message-ID: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch adds a wm_adsp2_remove() function to ensure that memory
is freed when the driver is unloaded or shut down.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 20 ++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b6470de..c350a52 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1039,6 +1039,13 @@ static void wm_adsp_ctl_work(struct work_struct *work)
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
@@ -2434,6 +2441,19 @@ int wm_adsp2_init(struct wm_adsp *dsp)
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
index b61cb57..feb61e2 100644
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
1.9.1
