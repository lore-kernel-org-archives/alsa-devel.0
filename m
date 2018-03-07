From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Rewrite jack-type detection" to
	the asoc tree
Date: Wed, 07 Mar 2018 14:13:40 +0000
Message-ID: <E1etZp6-0001M8-MW@debutante>
References: <20180304143610.21125-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B485F267255
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:13:46 +0100 (CET)
In-Reply-To: <20180304143610.21125-10-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Rewrite jack-type detection

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

>From ee68096826fa16bca2f7bb555b3e0cbbe798d330 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:57 +0100
Subject: [PATCH] ASoC: rt5651: Rewrite jack-type detection

We get the insertion event before the jack is fully inserted at which point
the second ring on a TRRS connector may short the 2nd ring and sleeve
contacts. Testing has shown that this short-circuit may happen as late
as 500ms after the insertion event, but it never lasts longer then 300ms.

This commit changes the detection algorithm to require 5 identical OVCD
values in a row at 100 ms intervals to fix the jack-type sometimes getting
mis-detected.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 110 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/rt5651.h |   2 +-
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 41fc574dbc3d..3b9f5384fe7d 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1622,12 +1622,76 @@ static bool rt5651_jack_inserted(struct snd_soc_component *component)
 	return val == 0;
 }
 
+/* Jack detect timings */
+#define JACK_SETTLE_TIME	100 /* milli seconds */
+#define JACK_DETECT_COUNT	5
+#define JACK_DETECT_MAXCOUNT	20  /* Aprox. 2 seconds worth of tries */
+
+static int rt5651_detect_headset(struct snd_soc_component *component)
+{
+	int i, headset_count = 0, headphone_count = 0;
+
+	/*
+	 * We get the insertion event before the jack is fully inserted at which
+	 * point the second ring on a TRRS connector may short the 2nd ring and
+	 * sleeve contacts, also the overcurrent detection is not entirely
+	 * reliable. So we try several times with a wait in between until we
+	 * detect the same type JACK_DETECT_COUNT times in a row.
+	 */
+	for (i = 0; i < JACK_DETECT_MAXCOUNT; i++) {
+		/* Clear any previous over-current status flag */
+		rt5651_clear_micbias1_ovcd(component);
+
+		msleep(JACK_SETTLE_TIME);
+
+		/* Check the jack is still connected before checking ovcd */
+		if (!rt5651_jack_inserted(component))
+			return 0;
+
+		if (rt5651_micbias1_ovcd(component)) {
+			/*
+			 * Over current detected, there is a short between the
+			 * 2nd ring contact and the ground, so a TRS connector
+			 * without a mic contact and thus plain headphones.
+			 */
+			dev_dbg(component->dev, "mic-gnd shorted\n");
+			headset_count = 0;
+			headphone_count++;
+			if (headphone_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADPHONE;
+		} else {
+			dev_dbg(component->dev, "mic-gnd open\n");
+			headphone_count = 0;
+			headset_count++;
+			if (headset_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADSET;
+		}
+	}
+
+	dev_err(component->dev, "Error detecting headset vs headphones, bad contact?, assuming headphones\n");
+	return SND_JACK_HEADPHONE;
+}
+
+static void rt5651_jack_detect_work(struct work_struct *work)
+{
+	struct rt5651_priv *rt5651 =
+		container_of(work, struct rt5651_priv, jack_detect_work);
+	int report = 0;
+
+	if (rt5651_jack_inserted(rt5651->component)) {
+		rt5651_enable_micbias1_for_ovcd(rt5651->component);
+		report = rt5651_detect_headset(rt5651->component);
+		rt5651_disable_micbias1_for_ovcd(rt5651->component);
+	}
+
+	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
 
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
+	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
 
 	return IRQ_HANDLED;
 }
@@ -1715,8 +1779,7 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	}
 
 	/* sync initial jack state */
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, 0);
+	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
 
 	return 0;
 }
@@ -1928,41 +1991,6 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
-static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
-{
-	int jack_type;
-
-	if (jack_insert) {
-		rt5651_enable_micbias1_for_ovcd(component);
-		rt5651_clear_micbias1_ovcd(component);
-		msleep(100);
-		if (rt5651_micbias1_ovcd(component))
-			jack_type = SND_JACK_HEADPHONE;
-		else
-			jack_type = SND_JACK_HEADSET;
-		rt5651_disable_micbias1_for_ovcd(component);
-	} else { /* jack out */
-		jack_type = 0;
-	}
-
-	return jack_type;
-}
-
-static void rt5651_jack_detect_work(struct work_struct *work)
-{
-	struct rt5651_priv *rt5651 =
-		container_of(work, struct rt5651_priv, jack_detect_work.work);
-	int report, jack_inserted;
-
-	if (!rt5651->component)
-		return;
-
-	jack_inserted = rt5651_jack_inserted(rt5651->component);
-	report = rt5651_jack_detect(rt5651->component, jack_inserted);
-
-	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
-}
-
 /*
  * Note this function MUST not look at device-properties, see the comment
  * above rt5651_apply_properties().
@@ -2005,7 +2033,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
 
-	INIT_DELAYED_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
+	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
@@ -2018,7 +2046,7 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 {
 	struct rt5651_priv *rt5651 = i2c_get_clientdata(i2c);
 
-	cancel_delayed_work_sync(&rt5651->jack_detect_work);
+	cancel_work_sync(&rt5651->jack_detect_work);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 71738ab93fb9..f20c9be94fb2 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2072,7 +2072,7 @@ struct rt5651_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct snd_soc_jack *hp_jack;
-	struct delayed_work jack_detect_work;
+	struct work_struct jack_detect_work;
 	enum rt5651_jd_src jd_src;
 	unsigned int ovcd_th;
 	unsigned int ovcd_sf;
-- 
2.16.2
