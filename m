From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm512x: Implement the digital_mute
	interface" to the asoc tree
Date: Thu, 13 Dec 2018 18:10:59 +0000 (GMT)
Message-ID: <20181213181059.581F111254D1@debutante.sirena.org.uk>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF10626789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:11:01 +0100 (CET)
In-Reply-To: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm512x: Implement the digital_mute interface

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

>From 3500f1c589e92e0b6b1f8d31b4084fbde08d49cb Mon Sep 17 00:00:00 2001
From: Dimitris Papavasiliou <dpapavas@gmail.com>
Date: Sat, 24 Nov 2018 22:05:42 +0200
Subject: [PATCH] ASoC: pcm512x: Implement the digital_mute interface

Clicks and pops of various volumes can be produced while the device is
opened, closed, put into and taken out of standby, or reconfigured.
Fix this, by implementing the digital_mute interface, so that the
output is muted during such operations.

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 121 ++++++++++++++++++++++++++++++++++++-
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
2.19.0.rc2
