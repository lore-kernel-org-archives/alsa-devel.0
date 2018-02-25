From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 14/32] ASoC: rt5651: Enable LDO and micbias1
	supplies for jack-type detection
Date: Sun, 25 Feb 2018 11:46:55 +0100
Message-ID: <20180225104713.4745-15-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEC12673F5
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:38 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

To determine if a plugged in jack is a headset (speakers + mic) or
headphones (mic contact shorted to ground) we use the micbias1 OVer Current
Detect (OVCD) functionality.

For this to work we need to have a micbias current to actually cause an
overcurrent condition when headphones are plugged in, so jack-type
detection requires both the LDO and micbias1 supplies to be on.

Before this commit there were 2 issues with the handling of this:
1) The LDO supply was force-enabled twice and never disabled again even
though it only needs to be forced on when doing jack-type detection
2) micbias1 was not force-enabled, and thus may be off when doing jack-type
detection

This commit fixes both by force-enabling the LDO and micbias1 supplies
before checking for an overcurrent condition and disabling them afterwards.

Note that both supplies will still get turned on normally (and OVCD will
protect against overcurrent) when the micbias1 is enabled normally because
the user has activated a sound stream recording from the mic.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index bfacf8ea6069..2e23e126ff54 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1556,6 +1556,28 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static void rt5651_enable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1569,7 +1591,6 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	int ret;
 	u32 val;
@@ -1616,9 +1637,6 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
 		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
 
-	snd_soc_dapm_force_enable_pin(dapm, "LDO");
-	snd_soc_dapm_sync(dapm);
-
 	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
 
 	rt5651->hp_jack = hp_jack;
@@ -1802,13 +1820,10 @@ MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
 static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int jack_type;
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(dapm, "LDO");
-		snd_soc_dapm_sync(dapm);
-
+		rt5651_enable_micbias1_for_ovcd(component);
 		snd_soc_component_update_bits(component, RT5651_MICBIAS,
 				    RT5651_MIC1_OVCD_MASK |
 				    RT5651_MIC1_OVTH_MASK |
@@ -1825,6 +1840,7 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 			jack_type = SND_JACK_HEADSET;
 		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
 				    RT5651_MB1_OC_CLR, 0);
+		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
 
-- 
2.14.3
