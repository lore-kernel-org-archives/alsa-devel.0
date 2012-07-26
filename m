From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Ensure we get a notification on
	startup for jackdet
Date: Thu, 26 Jul 2012 14:19:39 +0100
Message-ID: <1343308779-22531-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78911264EFB
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 15:19:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since jackdet only reports deltas it won't generate an interrupt on startup
when a jack is not present. This doesn't make a difference to userspace
but does mean we don't generate a notification via the internal notifier
chains. Fix that by scheduling a work to poll the chip after the clock is
enabled. Use an extremely large timeout since there's no urgency and we
don't want to report a false negative.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   37 ++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8994.h |    2 ++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1237c11..7bb0c2c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -789,11 +789,27 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		return configure_clock(codec);
 
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 * JACKDET won't run until we start the clock and it
+		 * only reports deltas, make sure we notify the state
+		 * up the stack on startup.  Use a *very* generous
+		 * timeout for paranoia, there's no urgency and we
+		 * don't want false reports.
+		 */
+		if (wm8994->jackdet && !wm8994->clk_has_run) {
+			schedule_delayed_work(&wm8994->jackdet_bootstrap,
+					      msecs_to_jiffies(1000));
+			wm8994->clk_has_run = true;
+		}
+		break;
+
 	case SND_SOC_DAPM_POST_PMD:
 		configure_clock(codec);
 		break;
@@ -1632,7 +1648,8 @@ SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, vmid_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_SUPPLY("CLK_SYS", SND_SOC_NOPM, 0, 0, clk_sys_event,
-		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		    SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_SUPPLY("DSP1CLK", SND_SOC_NOPM, 3, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("DSP2CLK", SND_SOC_NOPM, 2, 0, NULL, 0),
@@ -3508,10 +3525,22 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
 				    wm8994->btn_mask);
 
+	/* Since we only report deltas force an update, ensures we
+	 * avoid bootstrapping issues with the core. */
+	snd_soc_jack_report(wm8994->micdet[0].jack, 0, 0);
+
 	pm_runtime_put(codec->dev);
 	return IRQ_HANDLED;
 }
 
+static void wm1811_jackdet_bootstrap(struct work_struct *work)
+{
+	struct wm8994_priv *wm8994 = container_of(work,
+						struct wm8994_priv,
+						jackdet_bootstrap.work);
+	wm1811_jackdet_irq(0, wm8994);
+}
+
 /**
  * wm8958_mic_detect - Enable microphone detection via the WM8958 IRQ
  *
@@ -3582,6 +3611,10 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		 * otherwise jump straight to microphone detection.
 		 */
 		if (wm8994->jackdet) {
+			/* Disable debounce for the initial detect */
+			snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+					    WM1811_JACKDET_DB, 0);
+
 			snd_soc_update_bits(codec, WM8958_MICBIAS2,
 					    WM8958_MICB2_DISCH,
 					    WM8958_MICB2_DISCH);
@@ -3706,6 +3739,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->mic_work, wm8994_mic_work);
+	INIT_DELAYED_WORK(&wm8994->jackdet_bootstrap,
+			  wm1811_jackdet_bootstrap);
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		init_completion(&wm8994->fll_locked[i]);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index e6d8209..f142ec1 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -81,6 +81,7 @@ struct wm8994_priv {
 	struct completion fll_locked[2];
 	bool fll_locked_irq;
 	bool fll_byp;
+	bool clk_has_run;
 
 	int vmid_refcount;
 	int active_refcount;
@@ -134,6 +135,7 @@ struct wm8994_priv {
 	int btn_mask;
 	bool jackdet;
 	int jackdet_mode;
+	struct delayed_work jackdet_bootstrap;
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-- 
1.7.10.4
