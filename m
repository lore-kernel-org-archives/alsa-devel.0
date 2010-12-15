From: Margarita Olaya <magi.oc@gmail.com>
Subject: [PATCH v4] ASoC: twl6040: Add ramp up/down volume for
	HS and HF
Date: Wed, 15 Dec 2010 17:20:45 -0600
Message-ID: <AANLkTikkc_bTbEtW=_NUL6OLRR5ev0DcR3xKf-GdZ4z=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64f4b04ca770604977b2fde
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 00D761037EA
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 00:20:47 +0100 (CET)
Received: by wwi18 with SMTP id 18so161399wwi.2
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 15:20:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0016e64f4b04ca770604977b2fde
Content-Type: text/plain; charset=ISO-8859-1

From: Margarita Olaya Cabrera <magi.olaya@ti.com>

Add ramp functions for the headset and handsfree outputs
in order to reduce the pops during power on/off sequences.

In order to give more control to volume ramp, step size and delay
between steps can be specified.

The patches are based on wm8350 implementation from Liam
Girdwood.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |  533 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 521 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b252cf8..5a6f264 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -40,7 +40,35 @@
 #include "twl6040.h"

 #define TWL6040_RATES		SNDRV_PCM_RATE_8000_96000
-#define TWL6040_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
+#define TWL6040_FORMATS	(SNDRV_PCM_FMTBIT_S32_LE)
+
+#define TWL6040_OUTHS_0dB 0x00
+#define TWL6040_OUTHS_M30dB 0x0F
+#define TWL6040_OUTHF_0dB 0x03
+#define TWL6040_OUTHF_M52dB 0x1D
+
+#define TWL6040_RAMP_NONE	0
+#define TWL6040_RAMP_UP		1
+#define TWL6040_RAMP_DOWN	2
+
+#define TWL6040_HSL_VOL_MASK	0x0F
+#define TWL6040_HSL_VOL_SHIFT	0
+#define TWL6040_HSR_VOL_MASK	0xF0
+#define TWL6040_HSR_VOL_SHIFT	4
+#define TWL6040_HF_VOL_MASK	0x1F
+#define TWL6040_HF_VOL_SHIFT	0
+
+struct twl6040_output {
+	u16 active;
+	u16 left_vol;
+	u16 right_vol;
+	u16 left_step;
+	u16 right_step;
+	unsigned int step_delay;
+	u16 ramp;
+	u16 mute;
+	struct completion ramp_done;
+};

 struct twl6040_jack_data {
 	struct snd_soc_jack *jack;
@@ -62,6 +90,12 @@ struct twl6040_data {
 	struct workqueue_struct *workqueue;
 	struct delayed_work delayed_work;
 	struct mutex mutex;
+	struct twl6040_output headset;
+	struct twl6040_output handsfree;
+	struct workqueue_struct *hf_workqueue;
+	struct workqueue_struct *hs_workqueue;
+	struct delayed_work hs_delayed_work;
+	struct delayed_work hf_delayed_work;
 };

 /*
@@ -263,6 +297,305 @@ static void twl6040_init_vdd_regs(struct
snd_soc_codec *codec)
 	}
 }

+/*
+ * Ramp HS PGA volume to minimise pops at stream startup and shutdown.
+ */
+static inline int twl6040_hs_ramp_step(struct snd_soc_codec *codec,
+			unsigned int left_step, unsigned int right_step)
+{
+
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *headset = &priv->headset;
+	int left_complete = 0, right_complete = 0;
+	u8 reg, val;
+
+	/* left channel */
+	left_step = (left_step > 0xF) ? 0xF : left_step;
+	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
+	val = (~reg & TWL6040_HSL_VOL_MASK);
+
+	if (headset->ramp == TWL6040_RAMP_UP) {
+		/* ramp step up */
+		if (val < headset->left_vol) {
+			val += left_step;
+			reg &= ~TWL6040_HSL_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HSGAIN,
+					(reg | (~val & TWL6040_HSL_VOL_MASK)));
+		} else {
+			left_complete = 1;
+		}
+	} else if (headset->ramp == TWL6040_RAMP_DOWN) {
+		/* ramp step down */
+		if (val > 0x0) {
+			val -= left_step;
+			reg &= ~TWL6040_HSL_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HSGAIN, reg |
+						(~val & TWL6040_HSL_VOL_MASK));
+		} else {
+			left_complete = 1;
+		}
+	}
+
+	/* right channel */
+	right_step = (right_step > 0xF) ? 0xF : right_step;
+	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
+	val = (~reg & TWL6040_HSR_VOL_MASK) >> TWL6040_HSR_VOL_SHIFT;
+
+	if (headset->ramp == TWL6040_RAMP_UP) {
+		/* ramp step up */
+		if (val < headset->right_vol) {
+			val += right_step;
+			reg &= ~TWL6040_HSR_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HSGAIN,
+				(reg | (~val << TWL6040_HSR_VOL_SHIFT)));
+		} else {
+			right_complete = 1;
+		}
+	} else if (headset->ramp == TWL6040_RAMP_DOWN) {
+		/* ramp step down */
+		if (val > 0x0) {
+			val -= right_step;
+			reg &= ~TWL6040_HSR_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HSGAIN,
+					 reg | (~val << TWL6040_HSR_VOL_SHIFT));
+		} else {
+			right_complete = 1;
+		}
+	}
+
+	return left_complete & right_complete;
+}
+
+/*
+ * Ramp HF PGA volume to minimise pops at stream startup and shutdown.
+ */
+static inline int twl6040_hf_ramp_step(struct snd_soc_codec *codec,
+			unsigned int left_step, unsigned int right_step)
+{
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *handsfree = &priv->handsfree;
+	int left_complete = 0, right_complete = 0;
+	u16 reg, val;
+
+	/* left channel */
+	left_step = (left_step > 0x1D) ? 0x1D : left_step;
+	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFLGAIN);
+	reg = 0x1D - reg;
+	val = (reg & TWL6040_HF_VOL_MASK);
+	if (handsfree->ramp == TWL6040_RAMP_UP) {
+		/* ramp step up */
+		if (val < handsfree->left_vol) {
+			val += left_step;
+			reg &= ~TWL6040_HF_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HFLGAIN,
+						reg | (0x1D - val));
+		} else {
+			left_complete = 1;
+		}
+	} else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+		/* ramp step down */
+		if (val > 0) {
+			val -= left_step;
+			reg &= ~TWL6040_HF_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HFLGAIN,
+						reg | (0x1D - val));
+		} else {
+			left_complete = 1;
+		}
+	}
+
+	/* right channel */
+	right_step = (right_step > 0x1D) ? 0x1D : right_step;
+	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFRGAIN);
+	reg = 0x1D - reg;
+	val = (reg & TWL6040_HF_VOL_MASK);
+	if (handsfree->ramp == TWL6040_RAMP_UP) {
+		/* ramp step up */
+		if (val < handsfree->right_vol) {
+			val += right_step;
+			reg &= ~TWL6040_HF_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HFRGAIN,
+						reg | (0x1D - val));
+		} else {
+			right_complete = 1;
+		}
+	} else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+		/* ramp step down */
+		if (val > 0) {
+			val -= right_step;
+			reg &= ~TWL6040_HF_VOL_MASK;
+			twl6040_write(codec, TWL6040_REG_HFRGAIN,
+						reg | (0x1D - val));
+		}
+	}
+
+	return left_complete & right_complete;
+}
+
+/*
+ * This work ramps both output PGAs at stream start/stop time to
+ * minimise pop associated with DAPM power switching.
+ */
+static void twl6040_pga_hs_work(struct work_struct *work)
+{
+	struct twl6040_data *priv =
+		container_of(work, struct twl6040_data, hs_delayed_work.work);
+	struct snd_soc_codec *codec = priv->codec;
+	struct twl6040_output *headset = &priv->headset;
+	unsigned int delay = headset->step_delay;
+	int i, headset_complete;
+
+	/* do we need to ramp at all ? */
+	if (headset->ramp == TWL6040_RAMP_NONE)
+		return;
+
+	/* HS PGA volumes have 4 bits of resolution to ramp */
+	for (i = 0; i <= 16; i++) {
+		headset_complete = 1;
+		if (headset->ramp != TWL6040_RAMP_NONE)
+			headset_complete = twl6040_hs_ramp_step(codec,
+							headset->left_step,
+							headset->right_step);
+
+		/* ramp finished ? */
+		if (headset_complete)
+			break;
+
+		/*
+		 * TODO: tune: delay is longer over 0dB
+		 * as increases are larger.
+		 */
+		if (i >= 8)
+			schedule_timeout_interruptible(msecs_to_jiffies(delay +
+							(delay >> 1)));
+		else
+			schedule_timeout_interruptible(msecs_to_jiffies(delay));
+	}
+
+	if (headset->ramp == TWL6040_RAMP_DOWN) {
+		headset->active = 0;
+		complete(&headset->ramp_done);
+	} else {
+		headset->active = 1;
+	}
+	headset->ramp = TWL6040_RAMP_NONE;
+}
+
+static void twl6040_pga_hf_work(struct work_struct *work)
+{
+	struct twl6040_data *priv =
+		container_of(work, struct twl6040_data, hf_delayed_work.work);
+	struct snd_soc_codec *codec = priv->codec;
+	struct twl6040_output *handsfree = &priv->handsfree;
+	unsigned int delay = handsfree->step_delay;
+	int i, handsfree_complete;
+
+	/* do we need to ramp at all ? */
+	if (handsfree->ramp == TWL6040_RAMP_NONE)
+		return;
+
+	/* HF PGA volumes have 5 bits of resolution to ramp */
+	for (i = 0; i <= 32; i++) {
+		handsfree_complete = 1;
+		if (handsfree->ramp != TWL6040_RAMP_NONE)
+			handsfree_complete = twl6040_hf_ramp_step(codec,
+							handsfree->left_step,
+							handsfree->right_step);
+
+		/* ramp finished ? */
+		if (handsfree_complete)
+			break;
+
+		/*
+		 * TODO: tune: delay is longer over 0dB
+		 * as increases are larger.
+		 */
+		if (i >= 16)
+			schedule_timeout_interruptible(msecs_to_jiffies(delay +
+						       (delay >> 1)));
+		else
+			schedule_timeout_interruptible(msecs_to_jiffies(delay));
+	}
+
+
+	if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+		handsfree->active = 0;
+		complete(&handsfree->ramp_done);
+	} else
+		handsfree->active = 1;
+	handsfree->ramp = TWL6040_RAMP_NONE;
+}
+
+static int pga_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *out;
+	struct delayed_work *work;
+	struct workqueue_struct *queue;
+
+	switch (w->shift) {
+	case 2:
+	case 3:
+		out = &priv->headset;
+		work = &priv->hs_delayed_work;
+		queue = priv->hs_workqueue;
+		out->step_delay = 5;	/* 5 ms between volume ramp steps */
+		break;
+	case 4:
+		out = &priv->handsfree;
+		work = &priv->hf_delayed_work;
+		queue = priv->hf_workqueue;
+		out->step_delay = 5;	/* 5 ms between volume ramp steps */
+		if (SND_SOC_DAPM_EVENT_ON(event))
+			priv->non_lp++;
+		else
+			priv->non_lp--;
+		break;
+	default:
+		return -1;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (out->active)
+			break;
+
+		/* don't use volume ramp for power-up */
+		out->left_step = out->left_vol;
+		out->right_step = out->right_vol;
+
+		if (!delayed_work_pending(work)) {
+			out->ramp = TWL6040_RAMP_UP;
+			queue_delayed_work(queue, work,
+					msecs_to_jiffies(1));
+		}
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		if (!out->active)
+			break;
+
+		if (!delayed_work_pending(work)) {
+			/* use volume ramp for power-down */
+			out->left_step = 1;
+			out->right_step = 1;
+			out->ramp = TWL6040_RAMP_DOWN;
+			INIT_COMPLETION(out->ramp_done);
+
+			queue_delayed_work(queue, work,
+					msecs_to_jiffies(1));
+
+			wait_for_completion_timeout(&out->ramp_done,
+					msecs_to_jiffies(2000));
+		}
+		break;
+	}
+
+	return 0;
+}
+
 /* twl6040 codec manual power-up sequence */
 static void twl6040_power_up(struct snd_soc_codec *codec)
 {
@@ -463,6 +796,156 @@ static irqreturn_t twl6040_naudint_handler(int
irq, void *data)
 	return IRQ_HANDLED;
 }

+static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *out = NULL;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int ret;
+	unsigned int reg = mc->reg;
+
+	/* For HS and HF we shadow the values and only actually write
+	 * them out when active in order to ensure the amplifier comes on
+	 * as quietly as possible. */
+	switch (reg) {
+	case TWL6040_REG_HSGAIN:
+		out = &twl6040_priv->headset;
+		break;
+	default:
+		break;
+	}
+
+	if (out) {
+		out->left_vol = ucontrol->value.integer.value[0];
+		out->right_vol = ucontrol->value.integer.value[1];
+		if (!out->active)
+			return 1;
+	}
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *out = &twl6040_priv->headset;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+
+	switch (reg) {
+	case TWL6040_REG_HSGAIN:
+		out = &twl6040_priv->headset;
+		ucontrol->value.integer.value[0] = out->left_vol;
+		ucontrol->value.integer.value[1] = out->right_vol;
+		return 0;
+
+	default:
+		break;
+	}
+
+	return snd_soc_get_volsw(kcontrol, ucontrol);
+}
+
+static int twl6040_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *out = NULL;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int ret;
+	unsigned int reg = mc->reg;
+
+	/* For HS and HF we shadow the values and only actually write
+	 * them out when active in order to ensure the amplifier comes on
+	 * as quietly as possible. */
+	switch (reg) {
+	case TWL6040_REG_HFLGAIN:
+	case TWL6040_REG_HFRGAIN:
+		out = &twl6040_priv->handsfree;
+		break;
+	default:
+		break;
+	}
+
+	if (out) {
+		out->left_vol = ucontrol->value.integer.value[0];
+		out->right_vol = ucontrol->value.integer.value[1];
+		if (!out->active)
+			return 1;
+	}
+
+	ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+static int twl6040_get_volsw_2r(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_output *out = &twl6040_priv->handsfree;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+
+	/* If these are cached registers use the cache */
+	switch (reg) {
+	case TWL6040_REG_HFLGAIN:
+	case TWL6040_REG_HFRGAIN:
+		out = &twl6040_priv->handsfree;
+		ucontrol->value.integer.value[0] = out->left_vol;
+		ucontrol->value.integer.value[1] = out->right_vol;
+		return 0;
+
+	default:
+		break;
+	}
+
+	return snd_soc_get_volsw_2r(kcontrol, ucontrol);
+}
+
+/* double control with volume update */
+#define SOC_TWL6040_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax,\
+							xinvert, tlv_array)\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = twl6040_get_volsw, \
+	.put = twl6040_put_volsw, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
+		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+
+/* double control with volume update */
+#define SOC_TWL6040_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax,\
+				xinvert, tlv_array)\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_2r, \
+	.get = twl6040_get_volsw_2r, .put = twl6040_put_volsw_2r_vu, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
+		 .rshift = xshift, .max = xmax, .invert = xinvert}, }
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -569,9 +1052,9 @@ static const struct snd_kcontrol_new
twl6040_snd_controls[] = {
 		TWL6040_REG_LINEGAIN, 0, 4, 0xF, 0, afm_amp_tlv),

 	/* Playback gains */
-	SOC_DOUBLE_TLV("Headset Playback Volume",
+	SOC_TWL6040_DOUBLE_TLV("Headset Playback Volume",
 		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
-	SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
+	SOC_TWL6040_DOUBLE_R_TLV("Handsfree Playback Volume",
 		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
 	SOC_SINGLE_TLV("Earphone Playback Volume",
 		TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
@@ -657,16 +1140,20 @@ static const struct snd_soc_dapm_widget
twl6040_dapm_widgets[] = {
 	/* Analog playback drivers */
 	SND_SOC_DAPM_PGA_E("Handsfree Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
-			twl6040_power_mode_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			pga_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_PGA_E("Handsfree Right Driver",
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
-			twl6040_power_mode_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_PGA("Headset Left Driver",
-			TWL6040_REG_HSLCTL, 2, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Headset Right Driver",
-			TWL6040_REG_HSRCTL, 2, 0, NULL, 0),
+			pga_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_E("Headset Left Driver",
+			TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
+			pga_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_E("Headset Right Driver",
+			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
+			pga_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SWITCH_E("Earphone Driver",
 			SND_SOC_NOPM, 0, 0, &ep_driver_switch_controls,
 			twl6040_power_mode_event,
@@ -1150,6 +1637,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	mutex_init(&priv->mutex);

 	init_completion(&priv->ready);
+	init_completion(&priv->headset.ramp_done);
+	init_completion(&priv->handsfree.ramp_done);

 	if (gpio_is_valid(audpwron)) {
 		ret = gpio_request(audpwron, "audpwron");
@@ -1183,10 +1672,24 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	/* init vio registers */
 	twl6040_init_vio_regs(codec);

+	priv->hf_workqueue = create_singlethread_workqueue("twl6040-hf");
+	if (priv->hf_workqueue == NULL) {
+		ret = -ENOMEM;
+		goto irq_err;
+	}
+	priv->hs_workqueue = create_singlethread_workqueue("twl6040-hs");
+	if (priv->hs_workqueue == NULL) {
+		ret = -ENOMEM;
+		goto wq_err;
+	}
+
+	INIT_DELAYED_WORK(&priv->hs_delayed_work, twl6040_pga_hs_work);
+	INIT_DELAYED_WORK(&priv->hf_delayed_work, twl6040_pga_hf_work);
+
 	/* power on device */
 	ret = twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	if (ret)
-		goto irq_err;
+		goto bias_err;

 	snd_soc_add_controls(codec, twl6040_snd_controls,
 				ARRAY_SIZE(twl6040_snd_controls));
@@ -1194,6 +1697,10 @@ static int twl6040_probe(struct snd_soc_codec *codec)

 	return 0;

+bias_err:
+	destroy_workqueue(priv->hs_workqueue);
+wq_err:
+	destroy_workqueue(priv->hf_workqueue);
 irq_err:
 	if (naudint)
 		free_irq(naudint, codec);
@@ -1222,6 +1729,8 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 		free_irq(naudint, codec);

 	destroy_workqueue(priv->workqueue);
+	destroy_workqueue(priv->hf_workqueue);
+	destroy_workqueue(priv->hs_workqueue);
 	kfree(priv);

 	return 0;
-- 
1.7.0.4

--0016e64f4b04ca770604977b2fde
Content-Type: application/octet-stream;
	name="0002-ASoC-twl6040-Add-ramp-up-down-volume-for-HS-and-HF.patch"
Content-Disposition: attachment;
	filename="0002-ASoC-twl6040-Add-ramp-up-down-volume-for-HS-and-HF.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghqucuei0

RnJvbSAzY2UwNGRhZDE5NjgxZDY0MjAzMTJjNzZlNDQ5NmJjZjk1ZTg2NzZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJnYXJpdGEgT2xheWEgQ2FicmVyYSA8bWFnaS5vbGF5YUB0
aS5jb20+CkRhdGU6IFR1ZSwgMTQgRGVjIDIwMTAgMTk6MDA6MjEgLTA2MDAKU3ViamVjdDogW1BB
VENIIDIvMl0gQVNvQzogdHdsNjA0MDogQWRkIHJhbXAgdXAvZG93biB2b2x1bWUgZm9yIEhTIGFu
ZCBIRgoKQWRkIHJhbXAgZnVuY3Rpb25zIGZvciB0aGUgaGVhZHNldCBhbmQgaGFuZHNmcmVlIG91
dHB1dHMKaW4gb3JkZXIgdG8gcmVkdWNlIHRoZSBwb3BzIGR1cmluZyBwb3dlciBvbi9vZmYgc2Vx
dWVuY2VzLgoKSW4gb3JkZXIgdG8gZ2l2ZSBtb3JlIGNvbnRyb2wgdG8gdm9sdW1lIHJhbXAsIHN0
ZXAgc2l6ZSBhbmQgZGVsYXkKYmV0d2VlbiBzdGVwcyBjYW4gYmUgc3BlY2lmaWVkLgoKVGhlIHBh
dGNoZXMgYXJlIGJhc2VkIG9uIHdtODM1MCBpbXBsZW1lbnRhdGlvbiBmcm9tIExpYW0KR2lyZHdv
b2QuCgpTaWduZWQtb2ZmLWJ5OiBNYXJnYXJpdGEgT2xheWEgQ2FicmVyYSA8bWFnaS5vbGF5YUB0
aS5jb20+ClNpZ25lZC1vZmYtYnk6IE1pc2FlbCBMb3BleiBDcnV6IDxtaXNhZWwubG9wZXpAdGku
Y29tPgpBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNy
by5jb20+Ci0tLQogc291bmQvc29jL2NvZGVjcy90d2w2MDQwLmMgfCAgNTMzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDUyMSBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29k
ZWNzL3R3bDYwNDAuYyBiL3NvdW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5jCmluZGV4IGIyNTJjZjgu
LjVhNmYyNjQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5jCisrKyBiL3Nv
dW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5jCkBAIC00MCw3ICs0MCwzNSBAQAogI2luY2x1ZGUgInR3
bDYwNDAuaCIKIAogI2RlZmluZSBUV0w2MDQwX1JBVEVTCQlTTkRSVl9QQ01fUkFURV84MDAwXzk2
MDAwCi0jZGVmaW5lIFRXTDYwNDBfRk9STUFUUwkgKFNORFJWX1BDTV9GTVRCSVRfUzMyX0xFKQor
I2RlZmluZSBUV0w2MDQwX0ZPUk1BVFMJKFNORFJWX1BDTV9GTVRCSVRfUzMyX0xFKQorCisjZGVm
aW5lIFRXTDYwNDBfT1VUSFNfMGRCIDB4MDAKKyNkZWZpbmUgVFdMNjA0MF9PVVRIU19NMzBkQiAw
eDBGCisjZGVmaW5lIFRXTDYwNDBfT1VUSEZfMGRCIDB4MDMKKyNkZWZpbmUgVFdMNjA0MF9PVVRI
Rl9NNTJkQiAweDFECisKKyNkZWZpbmUgVFdMNjA0MF9SQU1QX05PTkUJMAorI2RlZmluZSBUV0w2
MDQwX1JBTVBfVVAJCTEKKyNkZWZpbmUgVFdMNjA0MF9SQU1QX0RPV04JMgorCisjZGVmaW5lIFRX
TDYwNDBfSFNMX1ZPTF9NQVNLCTB4MEYKKyNkZWZpbmUgVFdMNjA0MF9IU0xfVk9MX1NISUZUCTAK
KyNkZWZpbmUgVFdMNjA0MF9IU1JfVk9MX01BU0sJMHhGMAorI2RlZmluZSBUV0w2MDQwX0hTUl9W
T0xfU0hJRlQJNAorI2RlZmluZSBUV0w2MDQwX0hGX1ZPTF9NQVNLCTB4MUYKKyNkZWZpbmUgVFdM
NjA0MF9IRl9WT0xfU0hJRlQJMAorCitzdHJ1Y3QgdHdsNjA0MF9vdXRwdXQgeworCXUxNiBhY3Rp
dmU7CisJdTE2IGxlZnRfdm9sOworCXUxNiByaWdodF92b2w7CisJdTE2IGxlZnRfc3RlcDsKKwl1
MTYgcmlnaHRfc3RlcDsKKwl1bnNpZ25lZCBpbnQgc3RlcF9kZWxheTsKKwl1MTYgcmFtcDsKKwl1
MTYgbXV0ZTsKKwlzdHJ1Y3QgY29tcGxldGlvbiByYW1wX2RvbmU7Cit9OwogCiBzdHJ1Y3QgdHds
NjA0MF9qYWNrX2RhdGEgewogCXN0cnVjdCBzbmRfc29jX2phY2sgKmphY2s7CkBAIC02Miw2ICs5
MCwxMiBAQCBzdHJ1Y3QgdHdsNjA0MF9kYXRhIHsKIAlzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAq
d29ya3F1ZXVlOwogCXN0cnVjdCBkZWxheWVkX3dvcmsgZGVsYXllZF93b3JrOwogCXN0cnVjdCBt
dXRleCBtdXRleDsKKwlzdHJ1Y3QgdHdsNjA0MF9vdXRwdXQgaGVhZHNldDsKKwlzdHJ1Y3QgdHds
NjA0MF9vdXRwdXQgaGFuZHNmcmVlOworCXN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpoZl93b3Jr
cXVldWU7CisJc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmhzX3dvcmtxdWV1ZTsKKwlzdHJ1Y3Qg
ZGVsYXllZF93b3JrIGhzX2RlbGF5ZWRfd29yazsKKwlzdHJ1Y3QgZGVsYXllZF93b3JrIGhmX2Rl
bGF5ZWRfd29yazsKIH07CiAKIC8qCkBAIC0yNjMsNiArMjk3LDMwNSBAQCBzdGF0aWMgdm9pZCB0
d2w2MDQwX2luaXRfdmRkX3JlZ3Moc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjKQogCX0KIH0K
IAorLyoKKyAqIFJhbXAgSFMgUEdBIHZvbHVtZSB0byBtaW5pbWlzZSBwb3BzIGF0IHN0cmVhbSBz
dGFydHVwIGFuZCBzaHV0ZG93bi4KKyAqLworc3RhdGljIGlubGluZSBpbnQgdHdsNjA0MF9oc19y
YW1wX3N0ZXAoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjLAorCQkJdW5zaWduZWQgaW50IGxl
ZnRfc3RlcCwgdW5zaWduZWQgaW50IHJpZ2h0X3N0ZXApCit7CisKKwlzdHJ1Y3QgdHdsNjA0MF9k
YXRhICpwcml2ID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7CisJc3RydWN0IHR3
bDYwNDBfb3V0cHV0ICpoZWFkc2V0ID0gJnByaXYtPmhlYWRzZXQ7CisJaW50IGxlZnRfY29tcGxl
dGUgPSAwLCByaWdodF9jb21wbGV0ZSA9IDA7CisJdTggcmVnLCB2YWw7CisKKwkvKiBsZWZ0IGNo
YW5uZWwgKi8KKwlsZWZ0X3N0ZXAgPSAobGVmdF9zdGVwID4gMHhGKSA/IDB4RiA6IGxlZnRfc3Rl
cDsKKwlyZWcgPSB0d2w2MDQwX3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBUV0w2MDQwX1JFR19IU0dB
SU4pOworCXZhbCA9ICh+cmVnICYgVFdMNjA0MF9IU0xfVk9MX01BU0spOworCisJaWYgKGhlYWRz
ZXQtPnJhbXAgPT0gVFdMNjA0MF9SQU1QX1VQKSB7CisJCS8qIHJhbXAgc3RlcCB1cCAqLworCQlp
ZiAodmFsIDwgaGVhZHNldC0+bGVmdF92b2wpIHsKKwkJCXZhbCArPSBsZWZ0X3N0ZXA7CisJCQly
ZWcgJj0gflRXTDYwNDBfSFNMX1ZPTF9NQVNLOworCQkJdHdsNjA0MF93cml0ZShjb2RlYywgVFdM
NjA0MF9SRUdfSFNHQUlOLAorCQkJCQkocmVnIHwgKH52YWwgJiBUV0w2MDQwX0hTTF9WT0xfTUFT
SykpKTsKKwkJfSBlbHNlIHsKKwkJCWxlZnRfY29tcGxldGUgPSAxOworCQl9CisJfSBlbHNlIGlm
IChoZWFkc2V0LT5yYW1wID09IFRXTDYwNDBfUkFNUF9ET1dOKSB7CisJCS8qIHJhbXAgc3RlcCBk
b3duICovCisJCWlmICh2YWwgPiAweDApIHsKKwkJCXZhbCAtPSBsZWZ0X3N0ZXA7CisJCQlyZWcg
Jj0gflRXTDYwNDBfSFNMX1ZPTF9NQVNLOworCQkJdHdsNjA0MF93cml0ZShjb2RlYywgVFdMNjA0
MF9SRUdfSFNHQUlOLCByZWcgfAorCQkJCQkJKH52YWwgJiBUV0w2MDQwX0hTTF9WT0xfTUFTSykp
OworCQl9IGVsc2UgeworCQkJbGVmdF9jb21wbGV0ZSA9IDE7CisJCX0KKwl9CisKKwkvKiByaWdo
dCBjaGFubmVsICovCisJcmlnaHRfc3RlcCA9IChyaWdodF9zdGVwID4gMHhGKSA/IDB4RiA6IHJp
Z2h0X3N0ZXA7CisJcmVnID0gdHdsNjA0MF9yZWFkX3JlZ19jYWNoZShjb2RlYywgVFdMNjA0MF9S
RUdfSFNHQUlOKTsKKwl2YWwgPSAofnJlZyAmIFRXTDYwNDBfSFNSX1ZPTF9NQVNLKSA+PiBUV0w2
MDQwX0hTUl9WT0xfU0hJRlQ7CisKKwlpZiAoaGVhZHNldC0+cmFtcCA9PSBUV0w2MDQwX1JBTVBf
VVApIHsKKwkJLyogcmFtcCBzdGVwIHVwICovCisJCWlmICh2YWwgPCBoZWFkc2V0LT5yaWdodF92
b2wpIHsKKwkJCXZhbCArPSByaWdodF9zdGVwOworCQkJcmVnICY9IH5UV0w2MDQwX0hTUl9WT0xf
TUFTSzsKKwkJCXR3bDYwNDBfd3JpdGUoY29kZWMsIFRXTDYwNDBfUkVHX0hTR0FJTiwKKwkJCQko
cmVnIHwgKH52YWwgPDwgVFdMNjA0MF9IU1JfVk9MX1NISUZUKSkpOworCQl9IGVsc2UgeworCQkJ
cmlnaHRfY29tcGxldGUgPSAxOworCQl9CisJfSBlbHNlIGlmIChoZWFkc2V0LT5yYW1wID09IFRX
TDYwNDBfUkFNUF9ET1dOKSB7CisJCS8qIHJhbXAgc3RlcCBkb3duICovCisJCWlmICh2YWwgPiAw
eDApIHsKKwkJCXZhbCAtPSByaWdodF9zdGVwOworCQkJcmVnICY9IH5UV0w2MDQwX0hTUl9WT0xf
TUFTSzsKKwkJCXR3bDYwNDBfd3JpdGUoY29kZWMsIFRXTDYwNDBfUkVHX0hTR0FJTiwKKwkJCQkJ
IHJlZyB8ICh+dmFsIDw8IFRXTDYwNDBfSFNSX1ZPTF9TSElGVCkpOworCQl9IGVsc2UgeworCQkJ
cmlnaHRfY29tcGxldGUgPSAxOworCQl9CisJfQorCisJcmV0dXJuIGxlZnRfY29tcGxldGUgJiBy
aWdodF9jb21wbGV0ZTsKK30KKworLyoKKyAqIFJhbXAgSEYgUEdBIHZvbHVtZSB0byBtaW5pbWlz
ZSBwb3BzIGF0IHN0cmVhbSBzdGFydHVwIGFuZCBzaHV0ZG93bi4KKyAqLworc3RhdGljIGlubGlu
ZSBpbnQgdHdsNjA0MF9oZl9yYW1wX3N0ZXAoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjLAor
CQkJdW5zaWduZWQgaW50IGxlZnRfc3RlcCwgdW5zaWduZWQgaW50IHJpZ2h0X3N0ZXApCit7CisJ
c3RydWN0IHR3bDYwNDBfZGF0YSAqcHJpdiA9IHNuZF9zb2NfY29kZWNfZ2V0X2RydmRhdGEoY29k
ZWMpOworCXN0cnVjdCB0d2w2MDQwX291dHB1dCAqaGFuZHNmcmVlID0gJnByaXYtPmhhbmRzZnJl
ZTsKKwlpbnQgbGVmdF9jb21wbGV0ZSA9IDAsIHJpZ2h0X2NvbXBsZXRlID0gMDsKKwl1MTYgcmVn
LCB2YWw7CisKKwkvKiBsZWZ0IGNoYW5uZWwgKi8KKwlsZWZ0X3N0ZXAgPSAobGVmdF9zdGVwID4g
MHgxRCkgPyAweDFEIDogbGVmdF9zdGVwOworCXJlZyA9IHR3bDYwNDBfcmVhZF9yZWdfY2FjaGUo
Y29kZWMsIFRXTDYwNDBfUkVHX0hGTEdBSU4pOworCXJlZyA9IDB4MUQgLSByZWc7CisJdmFsID0g
KHJlZyAmIFRXTDYwNDBfSEZfVk9MX01BU0spOworCWlmIChoYW5kc2ZyZWUtPnJhbXAgPT0gVFdM
NjA0MF9SQU1QX1VQKSB7CisJCS8qIHJhbXAgc3RlcCB1cCAqLworCQlpZiAodmFsIDwgaGFuZHNm
cmVlLT5sZWZ0X3ZvbCkgeworCQkJdmFsICs9IGxlZnRfc3RlcDsKKwkJCXJlZyAmPSB+VFdMNjA0
MF9IRl9WT0xfTUFTSzsKKwkJCXR3bDYwNDBfd3JpdGUoY29kZWMsIFRXTDYwNDBfUkVHX0hGTEdB
SU4sCisJCQkJCQlyZWcgfCAoMHgxRCAtIHZhbCkpOworCQl9IGVsc2UgeworCQkJbGVmdF9jb21w
bGV0ZSA9IDE7CisJCX0KKwl9IGVsc2UgaWYgKGhhbmRzZnJlZS0+cmFtcCA9PSBUV0w2MDQwX1JB
TVBfRE9XTikgeworCQkvKiByYW1wIHN0ZXAgZG93biAqLworCQlpZiAodmFsID4gMCkgeworCQkJ
dmFsIC09IGxlZnRfc3RlcDsKKwkJCXJlZyAmPSB+VFdMNjA0MF9IRl9WT0xfTUFTSzsKKwkJCXR3
bDYwNDBfd3JpdGUoY29kZWMsIFRXTDYwNDBfUkVHX0hGTEdBSU4sCisJCQkJCQlyZWcgfCAoMHgx
RCAtIHZhbCkpOworCQl9IGVsc2UgeworCQkJbGVmdF9jb21wbGV0ZSA9IDE7CisJCX0KKwl9CisK
KwkvKiByaWdodCBjaGFubmVsICovCisJcmlnaHRfc3RlcCA9IChyaWdodF9zdGVwID4gMHgxRCkg
PyAweDFEIDogcmlnaHRfc3RlcDsKKwlyZWcgPSB0d2w2MDQwX3JlYWRfcmVnX2NhY2hlKGNvZGVj
LCBUV0w2MDQwX1JFR19IRlJHQUlOKTsKKwlyZWcgPSAweDFEIC0gcmVnOworCXZhbCA9IChyZWcg
JiBUV0w2MDQwX0hGX1ZPTF9NQVNLKTsKKwlpZiAoaGFuZHNmcmVlLT5yYW1wID09IFRXTDYwNDBf
UkFNUF9VUCkgeworCQkvKiByYW1wIHN0ZXAgdXAgKi8KKwkJaWYgKHZhbCA8IGhhbmRzZnJlZS0+
cmlnaHRfdm9sKSB7CisJCQl2YWwgKz0gcmlnaHRfc3RlcDsKKwkJCXJlZyAmPSB+VFdMNjA0MF9I
Rl9WT0xfTUFTSzsKKwkJCXR3bDYwNDBfd3JpdGUoY29kZWMsIFRXTDYwNDBfUkVHX0hGUkdBSU4s
CisJCQkJCQlyZWcgfCAoMHgxRCAtIHZhbCkpOworCQl9IGVsc2UgeworCQkJcmlnaHRfY29tcGxl
dGUgPSAxOworCQl9CisJfSBlbHNlIGlmIChoYW5kc2ZyZWUtPnJhbXAgPT0gVFdMNjA0MF9SQU1Q
X0RPV04pIHsKKwkJLyogcmFtcCBzdGVwIGRvd24gKi8KKwkJaWYgKHZhbCA+IDApIHsKKwkJCXZh
bCAtPSByaWdodF9zdGVwOworCQkJcmVnICY9IH5UV0w2MDQwX0hGX1ZPTF9NQVNLOworCQkJdHds
NjA0MF93cml0ZShjb2RlYywgVFdMNjA0MF9SRUdfSEZSR0FJTiwKKwkJCQkJCXJlZyB8ICgweDFE
IC0gdmFsKSk7CisJCX0KKwl9CisKKwlyZXR1cm4gbGVmdF9jb21wbGV0ZSAmIHJpZ2h0X2NvbXBs
ZXRlOworfQorCisvKgorICogVGhpcyB3b3JrIHJhbXBzIGJvdGggb3V0cHV0IFBHQXMgYXQgc3Ry
ZWFtIHN0YXJ0L3N0b3AgdGltZSB0bworICogbWluaW1pc2UgcG9wIGFzc29jaWF0ZWQgd2l0aCBE
QVBNIHBvd2VyIHN3aXRjaGluZy4KKyAqLworc3RhdGljIHZvaWQgdHdsNjA0MF9wZ2FfaHNfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJc3RydWN0IHR3bDYwNDBfZGF0YSAqcHJp
diA9CisJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdHdsNjA0MF9kYXRhLCBoc19kZWxheWVk
X3dvcmsud29yayk7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gcHJpdi0+Y29kZWM7
CisJc3RydWN0IHR3bDYwNDBfb3V0cHV0ICpoZWFkc2V0ID0gJnByaXYtPmhlYWRzZXQ7CisJdW5z
aWduZWQgaW50IGRlbGF5ID0gaGVhZHNldC0+c3RlcF9kZWxheTsKKwlpbnQgaSwgaGVhZHNldF9j
b21wbGV0ZTsKKworCS8qIGRvIHdlIG5lZWQgdG8gcmFtcCBhdCBhbGwgPyAqLworCWlmIChoZWFk
c2V0LT5yYW1wID09IFRXTDYwNDBfUkFNUF9OT05FKQorCQlyZXR1cm47CisKKwkvKiBIUyBQR0Eg
dm9sdW1lcyBoYXZlIDQgYml0cyBvZiByZXNvbHV0aW9uIHRvIHJhbXAgKi8KKwlmb3IgKGkgPSAw
OyBpIDw9IDE2OyBpKyspIHsKKwkJaGVhZHNldF9jb21wbGV0ZSA9IDE7CisJCWlmIChoZWFkc2V0
LT5yYW1wICE9IFRXTDYwNDBfUkFNUF9OT05FKQorCQkJaGVhZHNldF9jb21wbGV0ZSA9IHR3bDYw
NDBfaHNfcmFtcF9zdGVwKGNvZGVjLAorCQkJCQkJCWhlYWRzZXQtPmxlZnRfc3RlcCwKKwkJCQkJ
CQloZWFkc2V0LT5yaWdodF9zdGVwKTsKKworCQkvKiByYW1wIGZpbmlzaGVkID8gKi8KKwkJaWYg
KGhlYWRzZXRfY29tcGxldGUpCisJCQlicmVhazsKKworCQkvKgorCQkgKiBUT0RPOiB0dW5lOiBk
ZWxheSBpcyBsb25nZXIgb3ZlciAwZEIKKwkJICogYXMgaW5jcmVhc2VzIGFyZSBsYXJnZXIuCisJ
CSAqLworCQlpZiAoaSA+PSA4KQorCQkJc2NoZWR1bGVfdGltZW91dF9pbnRlcnJ1cHRpYmxlKG1z
ZWNzX3RvX2ppZmZpZXMoZGVsYXkgKworCQkJCQkJCShkZWxheSA+PiAxKSkpOworCQllbHNlCisJ
CQlzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUobXNlY3NfdG9famlmZmllcyhkZWxheSkp
OworCX0KKworCWlmIChoZWFkc2V0LT5yYW1wID09IFRXTDYwNDBfUkFNUF9ET1dOKSB7CisJCWhl
YWRzZXQtPmFjdGl2ZSA9IDA7CisJCWNvbXBsZXRlKCZoZWFkc2V0LT5yYW1wX2RvbmUpOworCX0g
ZWxzZSB7CisJCWhlYWRzZXQtPmFjdGl2ZSA9IDE7CisJfQorCWhlYWRzZXQtPnJhbXAgPSBUV0w2
MDQwX1JBTVBfTk9ORTsKK30KKworc3RhdGljIHZvaWQgdHdsNjA0MF9wZ2FfaGZfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJc3RydWN0IHR3bDYwNDBfZGF0YSAqcHJpdiA9CisJ
CWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdHdsNjA0MF9kYXRhLCBoZl9kZWxheWVkX3dvcmsu
d29yayk7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gcHJpdi0+Y29kZWM7CisJc3Ry
dWN0IHR3bDYwNDBfb3V0cHV0ICpoYW5kc2ZyZWUgPSAmcHJpdi0+aGFuZHNmcmVlOworCXVuc2ln
bmVkIGludCBkZWxheSA9IGhhbmRzZnJlZS0+c3RlcF9kZWxheTsKKwlpbnQgaSwgaGFuZHNmcmVl
X2NvbXBsZXRlOworCisJLyogZG8gd2UgbmVlZCB0byByYW1wIGF0IGFsbCA/ICovCisJaWYgKGhh
bmRzZnJlZS0+cmFtcCA9PSBUV0w2MDQwX1JBTVBfTk9ORSkKKwkJcmV0dXJuOworCisJLyogSEYg
UEdBIHZvbHVtZXMgaGF2ZSA1IGJpdHMgb2YgcmVzb2x1dGlvbiB0byByYW1wICovCisJZm9yIChp
ID0gMDsgaSA8PSAzMjsgaSsrKSB7CisJCWhhbmRzZnJlZV9jb21wbGV0ZSA9IDE7CisJCWlmICho
YW5kc2ZyZWUtPnJhbXAgIT0gVFdMNjA0MF9SQU1QX05PTkUpCisJCQloYW5kc2ZyZWVfY29tcGxl
dGUgPSB0d2w2MDQwX2hmX3JhbXBfc3RlcChjb2RlYywKKwkJCQkJCQloYW5kc2ZyZWUtPmxlZnRf
c3RlcCwKKwkJCQkJCQloYW5kc2ZyZWUtPnJpZ2h0X3N0ZXApOworCisJCS8qIHJhbXAgZmluaXNo
ZWQgPyAqLworCQlpZiAoaGFuZHNmcmVlX2NvbXBsZXRlKQorCQkJYnJlYWs7CisKKwkJLyoKKwkJ
ICogVE9ETzogdHVuZTogZGVsYXkgaXMgbG9uZ2VyIG92ZXIgMGRCCisJCSAqIGFzIGluY3JlYXNl
cyBhcmUgbGFyZ2VyLgorCQkgKi8KKwkJaWYgKGkgPj0gMTYpCisJCQlzY2hlZHVsZV90aW1lb3V0
X2ludGVycnVwdGlibGUobXNlY3NfdG9famlmZmllcyhkZWxheSArCisJCQkJCQkgICAgICAgKGRl
bGF5ID4+IDEpKSk7CisJCWVsc2UKKwkJCXNjaGVkdWxlX3RpbWVvdXRfaW50ZXJydXB0aWJsZSht
c2Vjc190b19qaWZmaWVzKGRlbGF5KSk7CisJfQorCisKKwlpZiAoaGFuZHNmcmVlLT5yYW1wID09
IFRXTDYwNDBfUkFNUF9ET1dOKSB7CisJCWhhbmRzZnJlZS0+YWN0aXZlID0gMDsKKwkJY29tcGxl
dGUoJmhhbmRzZnJlZS0+cmFtcF9kb25lKTsKKwl9IGVsc2UKKwkJaGFuZHNmcmVlLT5hY3RpdmUg
PSAxOworCWhhbmRzZnJlZS0+cmFtcCA9IFRXTDYwNDBfUkFNUF9OT05FOworfQorCitzdGF0aWMg
aW50IHBnYV9ldmVudChzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdywKKwkJCXN0cnVjdCBz
bmRfa2NvbnRyb2wgKmtjb250cm9sLCBpbnQgZXZlbnQpCit7CisJc3RydWN0IHNuZF9zb2NfY29k
ZWMgKmNvZGVjID0gdy0+Y29kZWM7CisJc3RydWN0IHR3bDYwNDBfZGF0YSAqcHJpdiA9IHNuZF9z
b2NfY29kZWNfZ2V0X2RydmRhdGEoY29kZWMpOworCXN0cnVjdCB0d2w2MDQwX291dHB1dCAqb3V0
OworCXN0cnVjdCBkZWxheWVkX3dvcmsgKndvcms7CisJc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3Qg
KnF1ZXVlOworCisJc3dpdGNoICh3LT5zaGlmdCkgeworCWNhc2UgMjoKKwljYXNlIDM6CisJCW91
dCA9ICZwcml2LT5oZWFkc2V0OworCQl3b3JrID0gJnByaXYtPmhzX2RlbGF5ZWRfd29yazsKKwkJ
cXVldWUgPSBwcml2LT5oc193b3JrcXVldWU7CisJCW91dC0+c3RlcF9kZWxheSA9IDU7CS8qIDUg
bXMgYmV0d2VlbiB2b2x1bWUgcmFtcCBzdGVwcyAqLworCQlicmVhazsKKwljYXNlIDQ6CisJCW91
dCA9ICZwcml2LT5oYW5kc2ZyZWU7CisJCXdvcmsgPSAmcHJpdi0+aGZfZGVsYXllZF93b3JrOwor
CQlxdWV1ZSA9IHByaXYtPmhmX3dvcmtxdWV1ZTsKKwkJb3V0LT5zdGVwX2RlbGF5ID0gNTsJLyog
NSBtcyBiZXR3ZWVuIHZvbHVtZSByYW1wIHN0ZXBzICovCisJCWlmIChTTkRfU09DX0RBUE1fRVZF
TlRfT04oZXZlbnQpKQorCQkJcHJpdi0+bm9uX2xwKys7CisJCWVsc2UKKwkJCXByaXYtPm5vbl9s
cC0tOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLTE7CisJfQorCisJc3dpdGNoIChl
dmVudCkgeworCWNhc2UgU05EX1NPQ19EQVBNX1BPU1RfUE1VOgorCQlpZiAob3V0LT5hY3RpdmUp
CisJCQlicmVhazsKKworCQkvKiBkb24ndCB1c2Ugdm9sdW1lIHJhbXAgZm9yIHBvd2VyLXVwICov
CisJCW91dC0+bGVmdF9zdGVwID0gb3V0LT5sZWZ0X3ZvbDsKKwkJb3V0LT5yaWdodF9zdGVwID0g
b3V0LT5yaWdodF92b2w7CisKKwkJaWYgKCFkZWxheWVkX3dvcmtfcGVuZGluZyh3b3JrKSkgewor
CQkJb3V0LT5yYW1wID0gVFdMNjA0MF9SQU1QX1VQOworCQkJcXVldWVfZGVsYXllZF93b3JrKHF1
ZXVlLCB3b3JrLAorCQkJCQltc2Vjc190b19qaWZmaWVzKDEpKTsKKwkJfQorCQlicmVhazsKKwor
CWNhc2UgU05EX1NPQ19EQVBNX1BSRV9QTUQ6CisJCWlmICghb3V0LT5hY3RpdmUpCisJCQlicmVh
azsKKworCQlpZiAoIWRlbGF5ZWRfd29ya19wZW5kaW5nKHdvcmspKSB7CisJCQkvKiB1c2Ugdm9s
dW1lIHJhbXAgZm9yIHBvd2VyLWRvd24gKi8KKwkJCW91dC0+bGVmdF9zdGVwID0gMTsKKwkJCW91
dC0+cmlnaHRfc3RlcCA9IDE7CisJCQlvdXQtPnJhbXAgPSBUV0w2MDQwX1JBTVBfRE9XTjsKKwkJ
CUlOSVRfQ09NUExFVElPTihvdXQtPnJhbXBfZG9uZSk7CisKKwkJCXF1ZXVlX2RlbGF5ZWRfd29y
ayhxdWV1ZSwgd29yaywKKwkJCQkJbXNlY3NfdG9famlmZmllcygxKSk7CisKKwkJCXdhaXRfZm9y
X2NvbXBsZXRpb25fdGltZW91dCgmb3V0LT5yYW1wX2RvbmUsCisJCQkJCW1zZWNzX3RvX2ppZmZp
ZXMoMjAwMCkpOworCQl9CisJCWJyZWFrOworCX0KKworCXJldHVybiAwOworfQorCiAvKiB0d2w2
MDQwIGNvZGVjIG1hbnVhbCBwb3dlci11cCBzZXF1ZW5jZSAqLwogc3RhdGljIHZvaWQgdHdsNjA0
MF9wb3dlcl91cChzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMpCiB7CkBAIC00NjMsNiArNzk2
LDE1NiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdHdsNjA0MF9uYXVkaW50X2hhbmRsZXIoaW50IGly
cSwgdm9pZCAqZGF0YSkKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9CiAKK3N0YXRpYyBpbnQgdHds
NjA0MF9wdXRfdm9sc3coc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsCisJCQkJICBzdHJ1
Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2Rl
YyAqY29kZWMgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7CisJc3RydWN0IHR3bDYwNDBf
ZGF0YSAqdHdsNjA0MF9wcml2ID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7CisJ
c3RydWN0IHR3bDYwNDBfb3V0cHV0ICpvdXQgPSBOVUxMOworCXN0cnVjdCBzb2NfbWl4ZXJfY29u
dHJvbCAqbWMgPQorCQkoc3RydWN0IHNvY19taXhlcl9jb250cm9sICopa2NvbnRyb2wtPnByaXZh
dGVfdmFsdWU7CisJaW50IHJldDsKKwl1bnNpZ25lZCBpbnQgcmVnID0gbWMtPnJlZzsKKworCS8q
IEZvciBIUyBhbmQgSEYgd2Ugc2hhZG93IHRoZSB2YWx1ZXMgYW5kIG9ubHkgYWN0dWFsbHkgd3Jp
dGUKKwkgKiB0aGVtIG91dCB3aGVuIGFjdGl2ZSBpbiBvcmRlciB0byBlbnN1cmUgdGhlIGFtcGxp
ZmllciBjb21lcyBvbgorCSAqIGFzIHF1aWV0bHkgYXMgcG9zc2libGUuICovCisJc3dpdGNoIChy
ZWcpIHsKKwljYXNlIFRXTDYwNDBfUkVHX0hTR0FJTjoKKwkJb3V0ID0gJnR3bDYwNDBfcHJpdi0+
aGVhZHNldDsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJYnJlYWs7CisJfQorCisJaWYgKG91dCkg
eworCQlvdXQtPmxlZnRfdm9sID0gdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMF07CisJ
CW91dC0+cmlnaHRfdm9sID0gdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMV07CisJCWlm
ICghb3V0LT5hY3RpdmUpCisJCQlyZXR1cm4gMTsKKwl9CisKKwlyZXQgPSBzbmRfc29jX3B1dF92
b2xzdyhrY29udHJvbCwgdWNvbnRyb2wpOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0Owor
CisJcmV0dXJuIDE7Cit9CisKK3N0YXRpYyBpbnQgdHdsNjA0MF9nZXRfdm9sc3coc3RydWN0IHNu
ZF9rY29udHJvbCAqa2NvbnRyb2wsCisJCQkJc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSAqdWNv
bnRyb2wpCit7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gc25kX2tjb250cm9sX2No
aXAoa2NvbnRyb2wpOworCXN0cnVjdCB0d2w2MDQwX2RhdGEgKnR3bDYwNDBfcHJpdiA9IHNuZF9z
b2NfY29kZWNfZ2V0X2RydmRhdGEoY29kZWMpOworCXN0cnVjdCB0d2w2MDQwX291dHB1dCAqb3V0
ID0gJnR3bDYwNDBfcHJpdi0+aGVhZHNldDsKKwlzdHJ1Y3Qgc29jX21peGVyX2NvbnRyb2wgKm1j
ID0KKwkJKHN0cnVjdCBzb2NfbWl4ZXJfY29udHJvbCAqKWtjb250cm9sLT5wcml2YXRlX3ZhbHVl
OworCXVuc2lnbmVkIGludCByZWcgPSBtYy0+cmVnOworCisJc3dpdGNoIChyZWcpIHsKKwljYXNl
IFRXTDYwNDBfUkVHX0hTR0FJTjoKKwkJb3V0ID0gJnR3bDYwNDBfcHJpdi0+aGVhZHNldDsKKwkJ
dWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMF0gPSBvdXQtPmxlZnRfdm9sOworCQl1Y29u
dHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVsxXSA9IG91dC0+cmlnaHRfdm9sOworCQlyZXR1cm4g
MDsKKworCWRlZmF1bHQ6CisJCWJyZWFrOworCX0KKworCXJldHVybiBzbmRfc29jX2dldF92b2xz
dyhrY29udHJvbCwgdWNvbnRyb2wpOworfQorCitzdGF0aWMgaW50IHR3bDYwNDBfcHV0X3ZvbHN3
XzJyX3Z1KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAorCQkJCSAgc3RydWN0IHNuZF9j
dGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpCit7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVj
ID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRyb2wpOworCXN0cnVjdCB0d2w2MDQwX2RhdGEgKnR3
bDYwNDBfcHJpdiA9IHNuZF9zb2NfY29kZWNfZ2V0X2RydmRhdGEoY29kZWMpOworCXN0cnVjdCB0
d2w2MDQwX291dHB1dCAqb3V0ID0gTlVMTDsKKwlzdHJ1Y3Qgc29jX21peGVyX2NvbnRyb2wgKm1j
ID0KKwkJKHN0cnVjdCBzb2NfbWl4ZXJfY29udHJvbCAqKWtjb250cm9sLT5wcml2YXRlX3ZhbHVl
OworCWludCByZXQ7CisJdW5zaWduZWQgaW50IHJlZyA9IG1jLT5yZWc7CisKKwkvKiBGb3IgSFMg
YW5kIEhGIHdlIHNoYWRvdyB0aGUgdmFsdWVzIGFuZCBvbmx5IGFjdHVhbGx5IHdyaXRlCisJICog
dGhlbSBvdXQgd2hlbiBhY3RpdmUgaW4gb3JkZXIgdG8gZW5zdXJlIHRoZSBhbXBsaWZpZXIgY29t
ZXMgb24KKwkgKiBhcyBxdWlldGx5IGFzIHBvc3NpYmxlLiAqLworCXN3aXRjaCAocmVnKSB7CisJ
Y2FzZSBUV0w2MDQwX1JFR19IRkxHQUlOOgorCWNhc2UgVFdMNjA0MF9SRUdfSEZSR0FJTjoKKwkJ
b3V0ID0gJnR3bDYwNDBfcHJpdi0+aGFuZHNmcmVlOworCQlicmVhazsKKwlkZWZhdWx0OgorCQli
cmVhazsKKwl9CisKKwlpZiAob3V0KSB7CisJCW91dC0+bGVmdF92b2wgPSB1Y29udHJvbC0+dmFs
dWUuaW50ZWdlci52YWx1ZVswXTsKKwkJb3V0LT5yaWdodF92b2wgPSB1Y29udHJvbC0+dmFsdWUu
aW50ZWdlci52YWx1ZVsxXTsKKwkJaWYgKCFvdXQtPmFjdGl2ZSkKKwkJCXJldHVybiAxOworCX0K
KworCXJldCA9IHNuZF9zb2NfcHV0X3ZvbHN3XzJyKGtjb250cm9sLCB1Y29udHJvbCk7CisJaWYg
KHJldCA8IDApCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gMTsKK30KKworc3RhdGljIGludCB0
d2w2MDQwX2dldF92b2xzd18ycihzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKKwkJCQlz
dHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19j
b2RlYyAqY29kZWMgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7CisJc3RydWN0IHR3bDYw
NDBfZGF0YSAqdHdsNjA0MF9wcml2ID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7
CisJc3RydWN0IHR3bDYwNDBfb3V0cHV0ICpvdXQgPSAmdHdsNjA0MF9wcml2LT5oYW5kc2ZyZWU7
CisJc3RydWN0IHNvY19taXhlcl9jb250cm9sICptYyA9CisJCShzdHJ1Y3Qgc29jX21peGVyX2Nv
bnRyb2wgKilrY29udHJvbC0+cHJpdmF0ZV92YWx1ZTsKKwl1bnNpZ25lZCBpbnQgcmVnID0gbWMt
PnJlZzsKKworCS8qIElmIHRoZXNlIGFyZSBjYWNoZWQgcmVnaXN0ZXJzIHVzZSB0aGUgY2FjaGUg
Ki8KKwlzd2l0Y2ggKHJlZykgeworCWNhc2UgVFdMNjA0MF9SRUdfSEZMR0FJTjoKKwljYXNlIFRX
TDYwNDBfUkVHX0hGUkdBSU46CisJCW91dCA9ICZ0d2w2MDQwX3ByaXYtPmhhbmRzZnJlZTsKKwkJ
dWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWVbMF0gPSBvdXQtPmxlZnRfdm9sOworCQl1Y29u
dHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVsxXSA9IG91dC0+cmlnaHRfdm9sOworCQlyZXR1cm4g
MDsKKworCWRlZmF1bHQ6CisJCWJyZWFrOworCX0KKworCXJldHVybiBzbmRfc29jX2dldF92b2xz
d18ycihrY29udHJvbCwgdWNvbnRyb2wpOworfQorCisvKiBkb3VibGUgY29udHJvbCB3aXRoIHZv
bHVtZSB1cGRhdGUgKi8KKyNkZWZpbmUgU09DX1RXTDYwNDBfRE9VQkxFX1RMVih4bmFtZSwgeHJl
Zywgc2hpZnRfbGVmdCwgc2hpZnRfcmlnaHQsIHhtYXgsXAorCQkJCQkJCXhpbnZlcnQsIHRsdl9h
cnJheSlcCit7CS5pZmFjZSA9IFNORFJWX0NUTF9FTEVNX0lGQUNFX01JWEVSLCAubmFtZSA9ICh4
bmFtZSksXAorCS5hY2Nlc3MgPSBTTkRSVl9DVExfRUxFTV9BQ0NFU1NfVExWX1JFQUQgfFwKKwkJ
IFNORFJWX0NUTF9FTEVNX0FDQ0VTU19SRUFEV1JJVEUsXAorCS50bHYucCA9ICh0bHZfYXJyYXkp
LCBcCisJLmluZm8gPSBzbmRfc29jX2luZm9fdm9sc3csIC5nZXQgPSB0d2w2MDQwX2dldF92b2xz
dywgXAorCS5wdXQgPSB0d2w2MDQwX3B1dF92b2xzdywgXAorCS5wcml2YXRlX3ZhbHVlID0gKHVu
c2lnbmVkIGxvbmcpJihzdHJ1Y3Qgc29jX21peGVyX2NvbnRyb2wpIFwKKwkJey5yZWcgPSB4cmVn
LCAuc2hpZnQgPSBzaGlmdF9sZWZ0LCAucnNoaWZ0ID0gc2hpZnRfcmlnaHQsXAorCQkgLm1heCA9
IHhtYXgsIC5wbGF0Zm9ybV9tYXggPSB4bWF4LCAuaW52ZXJ0ID0geGludmVydH0gfQorCisvKiBk
b3VibGUgY29udHJvbCB3aXRoIHZvbHVtZSB1cGRhdGUgKi8KKyNkZWZpbmUgU09DX1RXTDYwNDBf
RE9VQkxFX1JfVExWKHhuYW1lLCByZWdfbGVmdCwgcmVnX3JpZ2h0LCB4c2hpZnQsIHhtYXgsXAor
CQkJCXhpbnZlcnQsIHRsdl9hcnJheSlcCit7CS5pZmFjZSA9IFNORFJWX0NUTF9FTEVNX0lGQUNF
X01JWEVSLCAubmFtZSA9ICh4bmFtZSksXAorCS5hY2Nlc3MgPSBTTkRSVl9DVExfRUxFTV9BQ0NF
U1NfVExWX1JFQUQgfCBcCisJCVNORFJWX0NUTF9FTEVNX0FDQ0VTU19SRUFEV1JJVEUgfCBcCisJ
CVNORFJWX0NUTF9FTEVNX0FDQ0VTU19WT0xBVElMRSwgXAorCS50bHYucCA9ICh0bHZfYXJyYXkp
LCBcCisJLmluZm8gPSBzbmRfc29jX2luZm9fdm9sc3dfMnIsIFwKKwkuZ2V0ID0gdHdsNjA0MF9n
ZXRfdm9sc3dfMnIsIC5wdXQgPSB0d2w2MDQwX3B1dF92b2xzd18ycl92dSwgXAorCS5wcml2YXRl
X3ZhbHVlID0gKHVuc2lnbmVkIGxvbmcpJihzdHJ1Y3Qgc29jX21peGVyX2NvbnRyb2wpIFwKKwkJ
ey5yZWcgPSByZWdfbGVmdCwgLnJyZWcgPSByZWdfcmlnaHQsIC5zaGlmdCA9IHhzaGlmdCwgXAor
CQkgLnJzaGlmdCA9IHhzaGlmdCwgLm1heCA9IHhtYXgsIC5pbnZlcnQgPSB4aW52ZXJ0fSwgfQor
CiAvKgogICogTUlDQVRUIHZvbHVtZSBjb250cm9sOgogICogZnJvbSAtNiB0byAwIGRCIGluIDYg
ZEIgc3RlcHMKQEAgLTU2OSw5ICsxMDUyLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2Nv
bnRyb2xfbmV3IHR3bDYwNDBfc25kX2NvbnRyb2xzW10gPSB7CiAJCVRXTDYwNDBfUkVHX0xJTkVH
QUlOLCAwLCA0LCAweEYsIDAsIGFmbV9hbXBfdGx2KSwKIAogCS8qIFBsYXliYWNrIGdhaW5zICov
Ci0JU09DX0RPVUJMRV9UTFYoIkhlYWRzZXQgUGxheWJhY2sgVm9sdW1lIiwKKwlTT0NfVFdMNjA0
MF9ET1VCTEVfVExWKCJIZWFkc2V0IFBsYXliYWNrIFZvbHVtZSIsCiAJCVRXTDYwNDBfUkVHX0hT
R0FJTiwgMCwgNCwgMHhGLCAxLCBoc190bHYpLAotCVNPQ19ET1VCTEVfUl9UTFYoIkhhbmRzZnJl
ZSBQbGF5YmFjayBWb2x1bWUiLAorCVNPQ19UV0w2MDQwX0RPVUJMRV9SX1RMVigiSGFuZHNmcmVl
IFBsYXliYWNrIFZvbHVtZSIsCiAJCVRXTDYwNDBfUkVHX0hGTEdBSU4sIFRXTDYwNDBfUkVHX0hG
UkdBSU4sIDAsIDB4MUQsIDEsIGhmX3RsdiksCiAJU09DX1NJTkdMRV9UTFYoIkVhcnBob25lIFBs
YXliYWNrIFZvbHVtZSIsCiAJCVRXTDYwNDBfUkVHX0VBUkNUTCwgMSwgMHhGLCAxLCBlcF90bHYp
LApAQCAtNjU3LDE2ICsxMTQwLDIwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBt
X3dpZGdldCB0d2w2MDQwX2RhcG1fd2lkZ2V0c1tdID0gewogCS8qIEFuYWxvZyBwbGF5YmFjayBk
cml2ZXJzICovCiAJU05EX1NPQ19EQVBNX1BHQV9FKCJIYW5kc2ZyZWUgTGVmdCBEcml2ZXIiLAog
CQkJVFdMNjA0MF9SRUdfSEZMQ1RMLCA0LCAwLCBOVUxMLCAwLAotCQkJdHdsNjA0MF9wb3dlcl9t
b2RlX2V2ZW50LAotCQkJU05EX1NPQ19EQVBNX1BPU1RfUE1VIHwgU05EX1NPQ19EQVBNX1BPU1Rf
UE1EKSwKKwkJCXBnYV9ldmVudCwKKwkJCVNORF9TT0NfREFQTV9QT1NUX1BNVSB8IFNORF9TT0Nf
REFQTV9QUkVfUE1EKSwKIAlTTkRfU09DX0RBUE1fUEdBX0UoIkhhbmRzZnJlZSBSaWdodCBEcml2
ZXIiLAogCQkJVFdMNjA0MF9SRUdfSEZSQ1RMLCA0LCAwLCBOVUxMLCAwLAotCQkJdHdsNjA0MF9w
b3dlcl9tb2RlX2V2ZW50LAotCQkJU05EX1NPQ19EQVBNX1BPU1RfUE1VIHwgU05EX1NPQ19EQVBN
X1BPU1RfUE1EKSwKLQlTTkRfU09DX0RBUE1fUEdBKCJIZWFkc2V0IExlZnQgRHJpdmVyIiwKLQkJ
CVRXTDYwNDBfUkVHX0hTTENUTCwgMiwgMCwgTlVMTCwgMCksCi0JU05EX1NPQ19EQVBNX1BHQSgi
SGVhZHNldCBSaWdodCBEcml2ZXIiLAotCQkJVFdMNjA0MF9SRUdfSFNSQ1RMLCAyLCAwLCBOVUxM
LCAwKSwKKwkJCXBnYV9ldmVudCwKKwkJCVNORF9TT0NfREFQTV9QT1NUX1BNVSB8IFNORF9TT0Nf
REFQTV9QUkVfUE1EKSwKKwlTTkRfU09DX0RBUE1fUEdBX0UoIkhlYWRzZXQgTGVmdCBEcml2ZXIi
LAorCQkJVFdMNjA0MF9SRUdfSFNMQ1RMLCAyLCAwLCBOVUxMLCAwLAorCQkJcGdhX2V2ZW50LAor
CQkJU05EX1NPQ19EQVBNX1BPU1RfUE1VIHwgU05EX1NPQ19EQVBNX1BSRV9QTUQpLAorCVNORF9T
T0NfREFQTV9QR0FfRSgiSGVhZHNldCBSaWdodCBEcml2ZXIiLAorCQkJVFdMNjA0MF9SRUdfSFNS
Q1RMLCAyLCAwLCBOVUxMLCAwLAorCQkJcGdhX2V2ZW50LAorCQkJU05EX1NPQ19EQVBNX1BPU1Rf
UE1VIHwgU05EX1NPQ19EQVBNX1BSRV9QTUQpLAogCVNORF9TT0NfREFQTV9TV0lUQ0hfRSgiRWFy
cGhvbmUgRHJpdmVyIiwKIAkJCVNORF9TT0NfTk9QTSwgMCwgMCwgJmVwX2RyaXZlcl9zd2l0Y2hf
Y29udHJvbHMsCiAJCQl0d2w2MDQwX3Bvd2VyX21vZGVfZXZlbnQsCkBAIC0xMTUwLDYgKzE2Mzcs
OCBAQCBzdGF0aWMgaW50IHR3bDYwNDBfcHJvYmUoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVj
KQogCW11dGV4X2luaXQoJnByaXYtPm11dGV4KTsKIAogCWluaXRfY29tcGxldGlvbigmcHJpdi0+
cmVhZHkpOworCWluaXRfY29tcGxldGlvbigmcHJpdi0+aGVhZHNldC5yYW1wX2RvbmUpOworCWlu
aXRfY29tcGxldGlvbigmcHJpdi0+aGFuZHNmcmVlLnJhbXBfZG9uZSk7CiAKIAlpZiAoZ3Bpb19p
c192YWxpZChhdWRwd3JvbikpIHsKIAkJcmV0ID0gZ3Bpb19yZXF1ZXN0KGF1ZHB3cm9uLCAiYXVk
cHdyb24iKTsKQEAgLTExODMsMTAgKzE2NzIsMjQgQEAgc3RhdGljIGludCB0d2w2MDQwX3Byb2Jl
KHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKIAkvKiBpbml0IHZpbyByZWdpc3RlcnMgKi8K
IAl0d2w2MDQwX2luaXRfdmlvX3JlZ3MoY29kZWMpOwogCisJcHJpdi0+aGZfd29ya3F1ZXVlID0g
Y3JlYXRlX3NpbmdsZXRocmVhZF93b3JrcXVldWUoInR3bDYwNDAtaGYiKTsKKwlpZiAocHJpdi0+
aGZfd29ya3F1ZXVlID09IE5VTEwpIHsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBpcnFfZXJy
OworCX0KKwlwcml2LT5oc193b3JrcXVldWUgPSBjcmVhdGVfc2luZ2xldGhyZWFkX3dvcmtxdWV1
ZSgidHdsNjA0MC1ocyIpOworCWlmIChwcml2LT5oc193b3JrcXVldWUgPT0gTlVMTCkgeworCQly
ZXQgPSAtRU5PTUVNOworCQlnb3RvIHdxX2VycjsKKwl9CisKKwlJTklUX0RFTEFZRURfV09SSygm
cHJpdi0+aHNfZGVsYXllZF93b3JrLCB0d2w2MDQwX3BnYV9oc193b3JrKTsKKwlJTklUX0RFTEFZ
RURfV09SSygmcHJpdi0+aGZfZGVsYXllZF93b3JrLCB0d2w2MDQwX3BnYV9oZl93b3JrKTsKKwog
CS8qIHBvd2VyIG9uIGRldmljZSAqLwogCXJldCA9IHR3bDYwNDBfc2V0X2JpYXNfbGV2ZWwoY29k
ZWMsIFNORF9TT0NfQklBU19TVEFOREJZKTsKIAlpZiAocmV0KQotCQlnb3RvIGlycV9lcnI7CisJ
CWdvdG8gYmlhc19lcnI7CiAKIAlzbmRfc29jX2FkZF9jb250cm9scyhjb2RlYywgdHdsNjA0MF9z
bmRfY29udHJvbHMsCiAJCQkJQVJSQVlfU0laRSh0d2w2MDQwX3NuZF9jb250cm9scykpOwpAQCAt
MTE5NCw2ICsxNjk3LDEwIEBAIHN0YXRpYyBpbnQgdHdsNjA0MF9wcm9iZShzdHJ1Y3Qgc25kX3Nv
Y19jb2RlYyAqY29kZWMpCiAKIAlyZXR1cm4gMDsKIAorYmlhc19lcnI6CisJZGVzdHJveV93b3Jr
cXVldWUocHJpdi0+aHNfd29ya3F1ZXVlKTsKK3dxX2VycjoKKwlkZXN0cm95X3dvcmtxdWV1ZShw
cml2LT5oZl93b3JrcXVldWUpOwogaXJxX2VycjoKIAlpZiAobmF1ZGludCkKIAkJZnJlZV9pcnEo
bmF1ZGludCwgY29kZWMpOwpAQCAtMTIyMiw2ICsxNzI5LDggQEAgc3RhdGljIGludCB0d2w2MDQw
X3JlbW92ZShzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMpCiAJCWZyZWVfaXJxKG5hdWRpbnQs
IGNvZGVjKTsKIAogCWRlc3Ryb3lfd29ya3F1ZXVlKHByaXYtPndvcmtxdWV1ZSk7CisJZGVzdHJv
eV93b3JrcXVldWUocHJpdi0+aGZfd29ya3F1ZXVlKTsKKwlkZXN0cm95X3dvcmtxdWV1ZShwcml2
LT5oc193b3JrcXVldWUpOwogCWtmcmVlKHByaXYpOwogCiAJcmV0dXJuIDA7Ci0tIAoxLjcuMC40
Cgo=
--0016e64f4b04ca770604977b2fde
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e64f4b04ca770604977b2fde--
