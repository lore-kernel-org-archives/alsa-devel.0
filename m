From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Allow preloader to do the
	final shutdown of the DSP" to the asoc tree
Date: Mon, 26 Sep 2016 09:15:36 -0700
Message-ID: <E1boYZ6-0005Nj-Hs@finisterre>
References: <1474881325-9466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 296722606F7
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:15:50 +0200 (CEST)
In-Reply-To: <1474881325-9466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Allow preloader to do the final shutdown of the DSP

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

>From 57a60cc3616c8f5447d914b646a1d6df2ba9cc9d Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 26 Sep 2016 10:15:24 +0100
Subject: [PATCH] ASoC: wm_adsp: Allow preloader to do the final shutdown of
 the DSP

The booting process for the DSP is clearly separated into two parts, the
preloader brings up the core and downloads code, then the main widget
starts the code actually executing. However the shutdown sequence is all
handled with the main widget.

To allow the preloading to be run independently of the main audio bring
up it makes sense, and is generally just cleaner, for the preloader
widget to shutdown those things it initialised. This patch moves the
appropriate parts of the shutdown process into the preloader widget.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 36 +++++++++++++++++++++---------------
 sound/soc/codecs/wm_adsp.h |  2 +-
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 446f0297733f..b943dde8dbe5 100644
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
index 228b1f9e9a68..362dd7ce60d8 100644
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
2.9.3
