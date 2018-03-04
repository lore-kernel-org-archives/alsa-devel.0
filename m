From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 06/22] ASoC: rt5651: Enable sticky mode for
	OVCD
Date: Sun,  4 Mar 2018 15:35:54 +0100
Message-ID: <20180304143610.21125-7-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 541F9267338
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:22 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
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

When the mic-gnd contacts are short-circuited by a headphones plug, the
hardware periodically retries if it can apply the bias-current leading to
the OVCD status flip-flopping 1-0-1 with it being 0 about 10% of the time.
This commit enables the sticky bit for the OVCD status to deal with this.

This commit also introduces 2 helper functions to deal with the OVCD
status bit, this may seem a bit overkill now, but these will also be
used in future patches.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 4f78694adf70..3a439c121b0c 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1578,6 +1578,22 @@ static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	snd_soc_dapm_mutex_unlock(dapm);
 }
 
+static void rt5651_clear_micbias1_ovcd(struct snd_soc_component *component)
+{
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_MB1_OC_CLR, 0);
+}
+
+static bool rt5651_micbias1_ovcd(struct snd_soc_component *component)
+{
+	int val;
+
+	val = snd_soc_component_read32(component, RT5651_IRQ_CTRL2);
+	dev_dbg(component->dev, "irq ctrl2 %#04x\n", val);
+
+	return (val & RT5651_MB1_OC_CLR);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1646,6 +1662,18 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 				      RT5651_PWR_MB_PU |
 				      RT5651_PWR_CLK12M_PU);
 
+	/*
+	 * The over-current-detect is only reliable in detecting the absence
+	 * of over-current, when the mic-contact in the jack is short-circuited,
+	 * the hardware periodically retries if it can apply the bias-current
+	 * leading to the ovcd status flip-flopping 1-0-1 with it being 0 about
+	 * 10% of the time, as we poll the ovcd status bit we might hit that
+	 * 10%, so we enable sticky mode and when checking OVCD we clear the
+	 * status, msleep() a bit and then check to get a reliable reading.
+	 */
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_MB1_OC_STKY_MASK, RT5651_MB1_OC_STKY_EN);
+
 	rt5651->hp_jack = hp_jack;
 
 	ret = devm_request_threaded_irq(component->dev, rt5651->irq, NULL,
@@ -1879,13 +1907,12 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
+		rt5651_clear_micbias1_ovcd(component);
 		msleep(100);
-		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
+		if (rt5651_micbias1_ovcd(component))
 			jack_type = SND_JACK_HEADPHONE;
 		else
 			jack_type = SND_JACK_HEADSET;
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
-				    RT5651_MB1_OC_CLR, 0);
 		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
-- 
2.14.3
