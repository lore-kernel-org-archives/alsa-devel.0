From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Add button press support" to
	the asoc tree
Date: Fri, 11 May 2018 03:50:24 +0100 (BST)
Message-ID: <20180511025024.10C3144007A@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A34B9267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:50:32 +0200 (CEST)
In-Reply-To: <20180508153604.23711-8-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Add button press support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b16188a20f62b4d2f2bc7ede2ca3b15253184352 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:52 +0200
Subject: [PATCH] ASoC: rt5640: Add button press support

Enable button press detection for headsets by using the ovcd IRQ to get
notified of button presses.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 157 ++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5640.h |   9 ++-
 2 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 8e306f509601..8bf8d360c25f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2119,6 +2119,24 @@ static void rt5640_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	snd_soc_dapm_mutex_unlock(dapm);
 }
 
+static void rt5640_enable_micbias1_ovcd_irq(struct snd_soc_component *component)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
+		RT5640_IRQ_MB1_OC_MASK, RT5640_IRQ_MB1_OC_NOR);
+	rt5640->ovcd_irq_enabled = true;
+}
+
+static void rt5640_disable_micbias1_ovcd_irq(struct snd_soc_component *component)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
+		RT5640_IRQ_MB1_OC_MASK, RT5640_IRQ_MB1_OC_BP);
+	rt5640->ovcd_irq_enabled = false;
+}
+
 static void rt5640_clear_micbias1_ovcd(struct snd_soc_component *component)
 {
 	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
@@ -2149,10 +2167,80 @@ static bool rt5640_jack_inserted(struct snd_soc_component *component)
 		return (val & RT5640_JD_STATUS);
 }
 
-/* Jack detect timings */
+/* Jack detect and button-press timings */
 #define JACK_SETTLE_TIME	100 /* milli seconds */
 #define JACK_DETECT_COUNT	5
 #define JACK_DETECT_MAXCOUNT	20  /* Aprox. 2 seconds worth of tries */
+#define JACK_UNPLUG_TIME	80  /* milli seconds */
+#define BP_POLL_TIME		10  /* milli seconds */
+#define BP_POLL_MAXCOUNT	200 /* assume something is wrong after this */
+#define BP_THRESHOLD		3
+
+static void rt5640_start_button_press_work(struct snd_soc_component *component)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+
+	rt5640->poll_count = 0;
+	rt5640->press_count = 0;
+	rt5640->release_count = 0;
+	rt5640->pressed = false;
+	rt5640->press_reported = false;
+	rt5640_clear_micbias1_ovcd(component);
+	schedule_delayed_work(&rt5640->bp_work, msecs_to_jiffies(BP_POLL_TIME));
+}
+
+static void rt5640_button_press_work(struct work_struct *work)
+{
+	struct rt5640_priv *rt5640 =
+		container_of(work, struct rt5640_priv, bp_work.work);
+	struct snd_soc_component *component = rt5640->component;
+
+	/* Check the jack was not removed underneath us */
+	if (!rt5640_jack_inserted(component))
+		return;
+
+	if (rt5640_micbias1_ovcd(component)) {
+		rt5640->release_count = 0;
+		rt5640->press_count++;
+		/* Remember till after JACK_UNPLUG_TIME wait */
+		if (rt5640->press_count >= BP_THRESHOLD)
+			rt5640->pressed = true;
+		rt5640_clear_micbias1_ovcd(component);
+	} else {
+		rt5640->press_count = 0;
+		rt5640->release_count++;
+	}
+
+	/*
+	 * The pins get temporarily shorted on jack unplug, so we poll for
+	 * at least JACK_UNPLUG_TIME milli-seconds before reporting a press.
+	 */
+	rt5640->poll_count++;
+	if (rt5640->poll_count < (JACK_UNPLUG_TIME / BP_POLL_TIME)) {
+		schedule_delayed_work(&rt5640->bp_work,
+				      msecs_to_jiffies(BP_POLL_TIME));
+		return;
+	}
+
+	if (rt5640->pressed && !rt5640->press_reported) {
+		dev_dbg(component->dev, "headset button press\n");
+		snd_soc_jack_report(rt5640->jack, SND_JACK_BTN_0,
+				    SND_JACK_BTN_0);
+		rt5640->press_reported = true;
+	}
+
+	if (rt5640->release_count >= BP_THRESHOLD) {
+		if (rt5640->press_reported) {
+			dev_dbg(component->dev, "headset button release\n");
+			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
+		}
+		/* Re-enable OVCD IRQ to detect next press */
+		rt5640_enable_micbias1_ovcd_irq(component);
+		return; /* Stop polling */
+	}
+
+	schedule_delayed_work(&rt5640->bp_work, msecs_to_jiffies(BP_POLL_TIME));
+}
 
 static int rt5640_detect_headset(struct snd_soc_component *component)
 {
@@ -2209,17 +2297,51 @@ static void rt5640_jack_work(struct work_struct *work)
 	if (!rt5640_jack_inserted(component)) {
 		/* Jack removed, or spurious IRQ? */
 		if (rt5640->jack->status & SND_JACK_HEADPHONE) {
-			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_HEADSET);
+			if (rt5640->jack->status & SND_JACK_MICROPHONE) {
+				cancel_delayed_work_sync(&rt5640->bp_work);
+				rt5640_disable_micbias1_ovcd_irq(component);
+				rt5640_disable_micbias1_for_ovcd(component);
+			}
+			snd_soc_jack_report(rt5640->jack, 0,
+					    SND_JACK_HEADSET | SND_JACK_BTN_0);
 			dev_dbg(component->dev, "jack unplugged\n");
 		}
 	} else if (!(rt5640->jack->status & SND_JACK_HEADPHONE)) {
 		/* Jack inserted */
+		WARN_ON(rt5640->ovcd_irq_enabled);
 		rt5640_enable_micbias1_for_ovcd(component);
 		status = rt5640_detect_headset(component);
-		rt5640_disable_micbias1_for_ovcd(component);
-
+		if (status == SND_JACK_HEADSET) {
+			/* Enable ovcd IRQ for button press detect. */
+			rt5640_enable_micbias1_ovcd_irq(component);
+		} else {
+			/* No more need for overcurrent detect. */
+			rt5640_disable_micbias1_for_ovcd(component);
+		}
 		dev_dbg(component->dev, "detect status %#02x\n", status);
 		snd_soc_jack_report(rt5640->jack, status, SND_JACK_HEADSET);
+	} else if (rt5640->ovcd_irq_enabled && rt5640_micbias1_ovcd(component)) {
+		dev_dbg(component->dev, "OVCD IRQ\n");
+
+		/*
+		 * The ovcd IRQ keeps firing while the button is pressed, so
+		 * we disable it and start polling the button until released.
+		 *
+		 * The disable will make the IRQ pin 0 again and since we get
+		 * IRQs on both edges (so as to detect both jack plugin and
+		 * unplug) this means we will immediately get another IRQ.
+		 * The ovcd_irq_enabled check above makes the 2ND IRQ a NOP.
+		 */
+		rt5640_disable_micbias1_ovcd_irq(component);
+		rt5640_start_button_press_work(component);
+
+		/*
+		 * If the jack-detect IRQ flag goes high (unplug) after our
+		 * above rt5640_jack_inserted() check and before we have
+		 * disabled the OVCD IRQ, the IRQ pin will stay high and as
+		 * we react to edges, we miss the unplug event -> recheck.
+		 */
+		queue_work(system_long_wq, &rt5640->jack_work);
 	}
 }
 
@@ -2238,6 +2360,7 @@ static void rt5640_cancel_work(void *data)
 	struct rt5640_priv *rt5640 = data;
 
 	cancel_work_sync(&rt5640->jack_work);
+	cancel_delayed_work_sync(&rt5640->bp_work);
 }
 
 static void rt5640_enable_jack_detect(struct snd_soc_component *component,
@@ -2282,10 +2405,25 @@ static void rt5640_enable_jack_detect(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
 		RT5640_MB1_OC_STKY_MASK, RT5640_MB1_OC_STKY_EN);
 
-	snd_soc_component_write(component, RT5640_IRQ_CTRL1,
-				RT5640_IRQ_JD_NOR);
+	/*
+	 * All IRQs get or-ed together, so we need the jack IRQ to report 0
+	 * when a jack is inserted so that the OVCD IRQ then toggles the IRQ
+	 * pin 0/1 instead of it being stuck to 1. So we invert the JD polarity
+	 * on systems where the hardware does not already do this.
+	 */
+	if (rt5640->jd_inverted)
+		snd_soc_component_write(component, RT5640_IRQ_CTRL1,
+					RT5640_IRQ_JD_NOR);
+	else
+		snd_soc_component_write(component, RT5640_IRQ_CTRL1,
+					RT5640_IRQ_JD_NOR | RT5640_JD_P_INV);
 
 	rt5640->jack = jack;
+	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
+		rt5640_enable_micbias1_for_ovcd(component);
+		rt5640_enable_micbias1_ovcd_irq(component);
+	}
+
 	enable_irq(rt5640->irq);
 	/* sync initial jack state */
 	queue_work(system_long_wq, &rt5640->jack_work);
@@ -2298,6 +2436,12 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 	disable_irq(rt5640->irq);
 	rt5640_cancel_work(rt5640);
 
+	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
+		rt5640_disable_micbias1_ovcd_irq(component);
+		rt5640_disable_micbias1_for_ovcd(component);
+		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
+	}
+
 	rt5640->jack = NULL;
 }
 
@@ -2677,6 +2821,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 
 	rt5640->hp_mute = 1;
 	rt5640->irq = i2c->irq;
+	INIT_DELAYED_WORK(&rt5640->bp_work, rt5640_button_press_work);
 	INIT_WORK(&rt5640->jack_work, rt5640_jack_work);
 
 	/* Make sure work is stopped on probe-error / remove */
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 9d08471734b3..e29e3e7d61b0 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2139,7 +2139,14 @@ struct rt5640_priv {
 	bool hp_mute;
 	bool asrc_en;
 
-	/* Jack detect data */
+	/* Jack and button detect data */
+	bool ovcd_irq_enabled;
+	bool pressed;
+	bool press_reported;
+	int press_count;
+	int release_count;
+	int poll_count;
+	struct delayed_work bp_work;
 	struct work_struct jack_work;
 	struct snd_soc_jack *jack;
 	unsigned int jd_src;
-- 
2.17.0
