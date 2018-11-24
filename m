From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Sat, 24 Nov 2018 22:05:42 +0200
Message-ID: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AA24267947
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 21:05:45 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id t3so15171314wrr.3
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 12:05:45 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Clicks and pops of various volumes can be produced while the device is
opened, closed, put into and taken out of standby, or reconfigured.
Fix this, by implementing the digital_mute interface, so that the
output is muted during such operations.

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
---

Notes:
    Although the datasheet isn't very specific about it,
    PCM512x_ANALOG_MUTE_DET is only updated once ramp-down to digital mute
    is complete (followed by analog mute, assuming
    PCM512x_ANALOG_MUTE_CTRL is left with the default value, as is now the
    case).  I've measured the time it takes for the polling to finish and
    it seems consistent with that assumption, including properly tracking
    changes in the ramp-down parameters.  Thus, polling the register
    ensures that the device has been completely muted before returning.
    
    When unmuting, the time required for PCM512x_ANALOG_MUTE_DET to
    reflect the change, doesn't depend on the ramp-up parameters (as might
    be expected, since analog mute is likely lifted first).  Nevertheless
    the value is consistently substantially larger than zero, so that it
    seemingly reflects a particular stage in the unmuting process.  It
    also does no harm and seems to help minimize clicks, so I've kept the
    delay.
    
    I've tested this patch both in my day-to-day use of my DAC for more
    than a month, as well as by running a script that opens the device,
    performs several sample rate and format changes and closes it, every
    one second.  Without the patch, several different kinds of clicks and
    pops are produced.  After the patch, I've run the script for several
    hours with the DAC being consistently virtually silent.

 sound/soc/codecs/pcm512x.c | 121 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/pcm512x.h |   2 +
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index f0f2d4fd3769..6cb1653be804 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -53,6 +53,8 @@ struct pcm512x_priv {
 	unsigned long overclock_pll;
 	unsigned long overclock_dac;
 	unsigned long overclock_dsp;
+	int mute;
+	struct mutex mutex;
 };
 
 /*
@@ -384,6 +386,61 @@ static const struct soc_enum pcm512x_veds =
 	SOC_ENUM_SINGLE(PCM512x_DIGITAL_MUTE_2, PCM512x_VEDS_SHIFT, 4,
 			pcm512x_ramp_step_text);
 
+static int pcm512x_update_mute(struct pcm512x_priv *pcm512x)
+{
+	return regmap_update_bits(
+		pcm512x->regmap, PCM512x_MUTE, PCM512x_RQML | PCM512x_RQMR,
+		(!!(pcm512x->mute & 0x5) << PCM512x_RQML_SHIFT)
+		| (!!(pcm512x->mute & 0x3) << PCM512x_RQMR_SHIFT));
+}
+
+static int pcm512x_digital_playback_switch_get(struct snd_kcontrol *kcontrol,
+					       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&pcm512x->mutex);
+	ucontrol->value.integer.value[0] = !(pcm512x->mute & 0x4);
+	ucontrol->value.integer.value[1] = !(pcm512x->mute & 0x2);
+	mutex_unlock(&pcm512x->mutex);
+
+	return 0;
+}
+
+static int pcm512x_digital_playback_switch_put(struct snd_kcontrol *kcontrol,
+					       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	int ret, changed = 0;
+
+	mutex_lock(&pcm512x->mutex);
+
+	if ((pcm512x->mute & 0x4) == (ucontrol->value.integer.value[0] << 2)) {
+		pcm512x->mute ^= 0x4;
+		changed = 1;
+	}
+	if ((pcm512x->mute & 0x2) == (ucontrol->value.integer.value[1] << 1)) {
+		pcm512x->mute ^= 0x2;
+		changed = 1;
+	}
+
+	if (changed) {
+		ret = pcm512x_update_mute(pcm512x);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to update digital mute: %d\n", ret);
+			mutex_unlock(&pcm512x->mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&pcm512x->mutex);
+
+	return changed;
+}
+
 static const struct snd_kcontrol_new pcm512x_controls[] = {
 SOC_DOUBLE_R_TLV("Digital Playback Volume", PCM512x_DIGITAL_VOLUME_2,
 		 PCM512x_DIGITAL_VOLUME_3, 0, 255, 1, digital_tlv),
@@ -391,8 +448,15 @@ SOC_DOUBLE_TLV("Analogue Playback Volume", PCM512x_ANALOG_GAIN_CTRL,
 	       PCM512x_LAGN_SHIFT, PCM512x_RAGN_SHIFT, 1, 1, analog_tlv),
 SOC_DOUBLE_TLV("Analogue Playback Boost Volume", PCM512x_ANALOG_GAIN_BOOST,
 	       PCM512x_AGBL_SHIFT, PCM512x_AGBR_SHIFT, 1, 0, boost_tlv),
-SOC_DOUBLE("Digital Playback Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
-	   PCM512x_RQMR_SHIFT, 1, 1),
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Digital Playback Switch",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = snd_ctl_boolean_stereo_info,
+	.get = pcm512x_digital_playback_switch_get,
+	.put = pcm512x_digital_playback_switch_put
+},
 
 SOC_SINGLE("Deemphasis Switch", PCM512x_DSP, PCM512x_DEMP_SHIFT, 1, 1),
 SOC_ENUM("DSP Program", pcm512x_dsp_program),
@@ -1319,10 +1383,61 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int pcm512x_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	int ret;
+	unsigned int mute_det;
+
+	mutex_lock(&pcm512x->mutex);
+
+	if (mute) {
+		pcm512x->mute |= 0x1;
+		ret = regmap_update_bits(pcm512x->regmap, PCM512x_MUTE,
+					 PCM512x_RQML | PCM512x_RQMR,
+					 PCM512x_RQML | PCM512x_RQMR);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to set digital mute: %d\n", ret);
+			mutex_unlock(&pcm512x->mutex);
+			return ret;
+		}
+
+		regmap_read_poll_timeout(pcm512x->regmap,
+					 PCM512x_ANALOG_MUTE_DET,
+					 mute_det, (mute_det & 0x3) == 0,
+					 200, 10000);
+
+		mutex_unlock(&pcm512x->mutex);
+	} else {
+		pcm512x->mute &= ~0x1;
+		ret = pcm512x_update_mute(pcm512x);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to update digital mute: %d\n", ret);
+			mutex_unlock(&pcm512x->mutex);
+			return ret;
+		}
+
+		regmap_read_poll_timeout(pcm512x->regmap,
+					 PCM512x_ANALOG_MUTE_DET,
+					 mute_det,
+					 (mute_det & 0x3)
+					 == ((~pcm512x->mute >> 1) & 0x3),
+					 200, 10000);
+	}
+
+	mutex_unlock(&pcm512x->mutex);
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops pcm512x_dai_ops = {
 	.startup = pcm512x_dai_startup,
 	.hw_params = pcm512x_hw_params,
 	.set_fmt = pcm512x_set_fmt,
+	.digital_mute = pcm512x_digital_mute,
 };
 
 static struct snd_soc_dai_driver pcm512x_dai = {
@@ -1388,6 +1503,8 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
 	if (!pcm512x)
 		return -ENOMEM;
 
+	mutex_init(&pcm512x->mutex);
+
 	dev_set_drvdata(dev, pcm512x);
 	pcm512x->regmap = regmap;
 
diff --git a/sound/soc/codecs/pcm512x.h b/sound/soc/codecs/pcm512x.h
index d70d9c0c2088..9dda8693498e 100644
--- a/sound/soc/codecs/pcm512x.h
+++ b/sound/soc/codecs/pcm512x.h
@@ -112,7 +112,9 @@
 #define PCM512x_RQST_SHIFT 4
 
 /* Page 0, Register 3 - mute */
+#define PCM512x_RQMR (1 << 0)
 #define PCM512x_RQMR_SHIFT 0
+#define PCM512x_RQML (1 << 4)
 #define PCM512x_RQML_SHIFT 4
 
 /* Page 0, Register 4 - PLL */
-- 
2.11.0
