From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/4] ASoC: wm_adsp: Allow preloader to do
	the final shutdown of the DSP
Date: Mon, 26 Sep 2016 10:15:24 +0100
Message-ID: <1474881325-9466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDCD265338
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 11:15:18 +0200 (CEST)
In-Reply-To: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The booting process for the DSP is clearly separated into two parts, the
preloader brings up the core and downloads code, then the main widget
starts the code actually executing. However the shutdown sequence is all
handled with the main widget.

To allow the preloading to be run independently of the main audio bring
up it makes sense, and is generally just cleaner, for the preloader
widget to shutdown those things it initialised. This patch moves the
appropriate parts of the shutdown process into the preloader widget.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Minor tweak to the debug messages

 sound/soc/codecs/wm_adsp.c | 36 +++++++++++++++++++++---------------
 sound/soc/codecs/wm_adsp.h |  2 +-
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 446f029..b943dde 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2323,6 +2323,7 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
+	struct wm_coeff_ctl *ctl;
 
 	dsp->card = codec->component.card;
 
@@ -2331,6 +2332,24 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 		wm_adsp2_set_dspclk(dsp, freq);
 		queue_work(system_unbound_wq, &dsp->boot_work);
 		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		wm_adsp_debugfs_clear(dsp);
+
+		dsp->fw_id = 0;
+		dsp->fw_id_version = 0;
+
+		dsp->booted = false;
+
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				   ADSP2_MEM_ENA, 0);
+
+		list_for_each_entry(ctl, &dsp->ctl_list, list)
+			ctl->enabled = 0;
+
+		wm_adsp_free_alg_regions(dsp);
+
+		adsp_dbg(dsp, "Shutdown complete\n");
+		break;
 	default:
 		break;
 	}
@@ -2345,7 +2364,6 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_coeff_ctl *ctl;
 	int ret;
 
 	switch (event) {
@@ -2388,17 +2406,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		mutex_lock(&dsp->pwr_lock);
 
-		wm_adsp_debugfs_clear(dsp);
-
-		dsp->fw_id = 0;
-		dsp->fw_id_version = 0;
-
 		dsp->running = false;
-		dsp->booted = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_MEM_ENA | ADSP2_CORE_ENA | ADSP2_START,
-				   0);
+				   ADSP2_CORE_ENA | ADSP2_START, 0);
 
 		/* Make sure DMAs are quiesced */
 		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
@@ -2408,17 +2419,12 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				   ADSP2_SYS_ENA, 0);
 
-		list_for_each_entry(ctl, &dsp->ctl_list, list)
-			ctl->enabled = 0;
-
-		wm_adsp_free_alg_regions(dsp);
-
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			wm_adsp_buffer_free(dsp);
 
 		mutex_unlock(&dsp->pwr_lock);
 
-		adsp_dbg(dsp, "Shutdown complete\n");
+		adsp_dbg(dsp, "Execution stopped\n");
 		break;
 
 	default:
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 228b1f9..362dd7c 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -89,7 +89,7 @@ struct wm_adsp {
 #define WM_ADSP2(wname, num, event_fn) \
 {	.id = snd_soc_dapm_supply, .name = wname " Preloader", \
 	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
-	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD, \
 	.subseq = 100, /* Ensure we run after SYSCLK supply widget */ }, \
 {	.id = snd_soc_dapm_out_drv, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
-- 
2.1.4
