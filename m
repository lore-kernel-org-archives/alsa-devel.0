From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add button press support" to
	the asoc tree
Date: Tue, 10 Jul 2018 19:16:34 +0100
Message-ID: <E1fcxBi-0001hP-BO@debutante>
References: <20180704225935.7902-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE2D267714
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 20:16:42 +0200 (CEST)
In-Reply-To: <20180704225935.7902-3-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add button press support

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

>From df1569f2006b157caa944367d0d431eb4ea08624 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 5 Jul 2018 00:59:33 +0200
Subject: [PATCH] ASoC: rt5651: Add button press support

Enable button press detection for headsets by using the ovcd IRQ to get
notified of button presses.

This is modelled after (almost exactly copied from) the button press code
for the rt5640 which has identical ovcd hardware.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 158 ++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5651.h |   8 ++
 2 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 40bd1e70fee7..0462049e739c 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1581,6 +1581,24 @@ static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	snd_soc_dapm_mutex_unlock(dapm);
 }
 
+static void rt5651_enable_micbias1_ovcd_irq(struct snd_soc_component *component)
+{
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_IRQ_MB1_OC_MASK, RT5651_IRQ_MB1_OC_NOR);
+	rt5651->ovcd_irq_enabled = true;
+}
+
+static void rt5651_disable_micbias1_ovcd_irq(struct snd_soc_component *component)
+{
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_IRQ_MB1_OC_MASK, RT5651_IRQ_MB1_OC_BP);
+	rt5651->ovcd_irq_enabled = false;
+}
+
 static void rt5651_clear_micbias1_ovcd(struct snd_soc_component *component)
 {
 	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
@@ -1622,10 +1640,80 @@ static bool rt5651_jack_inserted(struct snd_soc_component *component)
 	return val == 0;
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
+static void rt5651_start_button_press_work(struct snd_soc_component *component)
+{
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+
+	rt5651->poll_count = 0;
+	rt5651->press_count = 0;
+	rt5651->release_count = 0;
+	rt5651->pressed = false;
+	rt5651->press_reported = false;
+	rt5651_clear_micbias1_ovcd(component);
+	schedule_delayed_work(&rt5651->bp_work, msecs_to_jiffies(BP_POLL_TIME));
+}
+
+static void rt5651_button_press_work(struct work_struct *work)
+{
+	struct rt5651_priv *rt5651 =
+		container_of(work, struct rt5651_priv, bp_work.work);
+	struct snd_soc_component *component = rt5651->component;
+
+	/* Check the jack was not removed underneath us */
+	if (!rt5651_jack_inserted(component))
+		return;
+
+	if (rt5651_micbias1_ovcd(component)) {
+		rt5651->release_count = 0;
+		rt5651->press_count++;
+		/* Remember till after JACK_UNPLUG_TIME wait */
+		if (rt5651->press_count >= BP_THRESHOLD)
+			rt5651->pressed = true;
+		rt5651_clear_micbias1_ovcd(component);
+	} else {
+		rt5651->press_count = 0;
+		rt5651->release_count++;
+	}
+
+	/*
+	 * The pins get temporarily shorted on jack unplug, so we poll for
+	 * at least JACK_UNPLUG_TIME milli-seconds before reporting a press.
+	 */
+	rt5651->poll_count++;
+	if (rt5651->poll_count < (JACK_UNPLUG_TIME / BP_POLL_TIME)) {
+		schedule_delayed_work(&rt5651->bp_work,
+				      msecs_to_jiffies(BP_POLL_TIME));
+		return;
+	}
+
+	if (rt5651->pressed && !rt5651->press_reported) {
+		dev_dbg(component->dev, "headset button press\n");
+		snd_soc_jack_report(rt5651->hp_jack, SND_JACK_BTN_0,
+				    SND_JACK_BTN_0);
+		rt5651->press_reported = true;
+	}
+
+	if (rt5651->release_count >= BP_THRESHOLD) {
+		if (rt5651->press_reported) {
+			dev_dbg(component->dev, "headset button release\n");
+			snd_soc_jack_report(rt5651->hp_jack, 0, SND_JACK_BTN_0);
+		}
+		/* Re-enable OVCD IRQ to detect next press */
+		rt5651_enable_micbias1_ovcd_irq(component);
+		return; /* Stop polling */
+	}
+
+	schedule_delayed_work(&rt5651->bp_work, msecs_to_jiffies(BP_POLL_TIME));
+}
 
 static int rt5651_detect_headset(struct snd_soc_component *component)
 {
@@ -1676,15 +1764,58 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 {
 	struct rt5651_priv *rt5651 =
 		container_of(work, struct rt5651_priv, jack_detect_work);
+	struct snd_soc_component *component = rt5651->component;
 	int report = 0;
 
-	if (rt5651_jack_inserted(rt5651->component)) {
-		rt5651_enable_micbias1_for_ovcd(rt5651->component);
-		report = rt5651_detect_headset(rt5651->component);
-		rt5651_disable_micbias1_for_ovcd(rt5651->component);
+	if (!rt5651_jack_inserted(component)) {
+		/* Jack removed, or spurious IRQ? */
+		if (rt5651->hp_jack->status & SND_JACK_HEADPHONE) {
+			if (rt5651->hp_jack->status & SND_JACK_MICROPHONE) {
+				cancel_delayed_work_sync(&rt5651->bp_work);
+				rt5651_disable_micbias1_ovcd_irq(component);
+				rt5651_disable_micbias1_for_ovcd(component);
+			}
+			snd_soc_jack_report(rt5651->hp_jack, 0,
+					    SND_JACK_HEADSET | SND_JACK_BTN_0);
+			dev_dbg(component->dev, "jack unplugged\n");
+		}
+	} else if (!(rt5651->hp_jack->status & SND_JACK_HEADPHONE)) {
+		/* Jack inserted */
+		WARN_ON(rt5651->ovcd_irq_enabled);
+		rt5651_enable_micbias1_for_ovcd(component);
+		report = rt5651_detect_headset(component);
+		if (report == SND_JACK_HEADSET) {
+			/* Enable ovcd IRQ for button press detect. */
+			rt5651_enable_micbias1_ovcd_irq(component);
+		} else {
+			/* No more need for overcurrent detect. */
+			rt5651_disable_micbias1_for_ovcd(component);
+		}
+		dev_dbg(component->dev, "detect report %#02x\n", report);
+		snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
+	} else if (rt5651->ovcd_irq_enabled && rt5651_micbias1_ovcd(component)) {
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
+		rt5651_disable_micbias1_ovcd_irq(component);
+		rt5651_start_button_press_work(component);
+
+		/*
+		 * If the jack-detect IRQ flag goes high (unplug) after our
+		 * above rt5651_jack_inserted() check and before we have
+		 * disabled the OVCD IRQ, the IRQ pin will stay high and as
+		 * we react to edges, we miss the unplug event -> recheck.
+		 */
+		queue_work(system_long_wq, &rt5651->jack_detect_work);
 	}
-
-	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 }
 
 static irqreturn_t rt5651_irq(int irq, void *data)
@@ -1701,6 +1832,7 @@ static void rt5651_cancel_work(void *data)
 	struct rt5651_priv *rt5651 = data;
 
 	cancel_work_sync(&rt5651->jack_detect_work);
+	cancel_delayed_work_sync(&rt5651->bp_work);
 }
 
 static void rt5651_enable_jack_detect(struct snd_soc_component *component,
@@ -1770,6 +1902,11 @@ static void rt5651_enable_jack_detect(struct snd_soc_component *component,
 		RT5651_MB1_OC_STKY_MASK, RT5651_MB1_OC_STKY_EN);
 
 	rt5651->hp_jack = hp_jack;
+	if (rt5651->hp_jack->status & SND_JACK_MICROPHONE) {
+		rt5651_enable_micbias1_for_ovcd(component);
+		rt5651_enable_micbias1_ovcd_irq(component);
+	}
+
 	enable_irq(rt5651->irq);
 	/* sync initial jack state */
 	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
@@ -1782,6 +1919,12 @@ static void rt5651_disable_jack_detect(struct snd_soc_component *component)
 	disable_irq(rt5651->irq);
 	rt5651_cancel_work(rt5651);
 
+	if (rt5651->hp_jack->status & SND_JACK_MICROPHONE) {
+		rt5651_disable_micbias1_ovcd_irq(component);
+		rt5651_disable_micbias1_for_ovcd(component);
+		snd_soc_jack_report(rt5651->hp_jack, 0, SND_JACK_BTN_0);
+	}
+
 	rt5651->hp_jack = NULL;
 }
 
@@ -2046,6 +2189,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
 
+	INIT_DELAYED_WORK(&rt5651->bp_work, rt5651_button_press_work);
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
 	/* Make sure work is stopped on probe-error / remove */
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 3a0968c53fde..ac6de6fb5414 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2071,8 +2071,16 @@ struct rt5651_pll_code {
 struct rt5651_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
+	/* Jack and button detect data */
 	struct snd_soc_jack *hp_jack;
 	struct work_struct jack_detect_work;
+	struct delayed_work bp_work;
+	bool ovcd_irq_enabled;
+	bool pressed;
+	bool press_reported;
+	int press_count;
+	int release_count;
+	int poll_count;
 	unsigned int jd_src;
 	unsigned int ovcd_th;
 	unsigned int ovcd_sf;
-- 
2.18.0.rc2
