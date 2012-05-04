From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Remove HS/HF gain ramp feature
Date: Fri,  4 May 2012 15:17:20 +0300
Message-ID: <1336133840-12330-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog134.obsmtp.com (na3sys009aog134.obsmtp.com
	[74.125.149.83]) by alsa0.perex.cz (Postfix) with ESMTP id 16F50246AB
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 14:17:45 +0200 (CEST)
Received: by lbbgg6 with SMTP id gg6so2482121lbb.36
	for <alsa-devel@alsa-project.org>; Fri, 04 May 2012 05:17:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

None of the machines uses the gain ramp possibility for HS/HF.
This code path is mostly unused and it does not reduces the pop
noise on the output (it alters it to sound a bit different).
The preferred method to reduce pop noise is to use ABE.
Remove the gain ramp, and related features form the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |  441 ++------------------------------------------
 1 files changed, 12 insertions(+), 429 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index dc7509b..0747260 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -46,17 +46,6 @@
 #define TWL6040_OUTHF_0dB 0x03
 #define TWL6040_OUTHF_M52dB 0x1D
 
-#define TWL6040_RAMP_NONE	0
-#define TWL6040_RAMP_UP		1
-#define TWL6040_RAMP_DOWN	2
-
-#define TWL6040_HSL_VOL_MASK	0x0F
-#define TWL6040_HSL_VOL_SHIFT	0
-#define TWL6040_HSR_VOL_MASK	0xF0
-#define TWL6040_HSR_VOL_SHIFT	4
-#define TWL6040_HF_VOL_MASK	0x1F
-#define TWL6040_HF_VOL_SHIFT	0
-
 /* Shadow register used by the driver */
 #define TWL6040_REG_SW_SHADOW	0x2F
 #define TWL6040_CACHEREGNUM	(TWL6040_REG_SW_SHADOW + 1)
@@ -64,18 +53,6 @@
 /* TWL6040_REG_SW_SHADOW (0x2F) fields */
 #define TWL6040_EAR_PATH_ENABLE	0x01
 
-struct twl6040_output {
-	u16 active;
-	u16 left_vol;
-	u16 right_vol;
-	u16 left_step;
-	u16 right_step;
-	unsigned int step_delay;
-	u16 ramp;
-	struct delayed_work work;
-	struct completion ramp_done;
-};
-
 struct twl6040_jack_data {
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
@@ -100,8 +77,6 @@ struct twl6040_data {
 	struct snd_soc_codec *codec;
 	struct workqueue_struct *workqueue;
 	struct mutex mutex;
-	struct twl6040_output headset;
-	struct twl6040_output handsfree;
 };
 
 /*
@@ -311,318 +286,6 @@ static void twl6040_restore_regs(struct snd_soc_codec *codec)
 	}
 }
 
-/*
- * Ramp HS PGA volume to minimise pops at stream startup and shutdown.
- */
-static inline int twl6040_hs_ramp_step(struct snd_soc_codec *codec,
-			unsigned int left_step, unsigned int right_step)
-{
-
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *headset = &priv->headset;
-	int left_complete = 0, right_complete = 0;
-	u8 reg, val;
-
-	/* left channel */
-	left_step = (left_step > 0xF) ? 0xF : left_step;
-	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
-	val = (~reg & TWL6040_HSL_VOL_MASK);
-
-	if (headset->ramp == TWL6040_RAMP_UP) {
-		/* ramp step up */
-		if (val < headset->left_vol) {
-			if (val + left_step > headset->left_vol)
-				val = headset->left_vol;
-			else
-				val += left_step;
-
-			reg &= ~TWL6040_HSL_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HSGAIN,
-					(reg | (~val & TWL6040_HSL_VOL_MASK)));
-		} else {
-			left_complete = 1;
-		}
-	} else if (headset->ramp == TWL6040_RAMP_DOWN) {
-		/* ramp step down */
-		if (val > 0x0) {
-			if ((int)val - (int)left_step < 0)
-				val = 0;
-			else
-				val -= left_step;
-
-			reg &= ~TWL6040_HSL_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HSGAIN, reg |
-						(~val & TWL6040_HSL_VOL_MASK));
-		} else {
-			left_complete = 1;
-		}
-	}
-
-	/* right channel */
-	right_step = (right_step > 0xF) ? 0xF : right_step;
-	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
-	val = (~reg & TWL6040_HSR_VOL_MASK) >> TWL6040_HSR_VOL_SHIFT;
-
-	if (headset->ramp == TWL6040_RAMP_UP) {
-		/* ramp step up */
-		if (val < headset->right_vol) {
-			if (val + right_step > headset->right_vol)
-				val = headset->right_vol;
-			else
-				val += right_step;
-
-			reg &= ~TWL6040_HSR_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HSGAIN,
-				(reg | (~val << TWL6040_HSR_VOL_SHIFT)));
-		} else {
-			right_complete = 1;
-		}
-	} else if (headset->ramp == TWL6040_RAMP_DOWN) {
-		/* ramp step down */
-		if (val > 0x0) {
-			if ((int)val - (int)right_step < 0)
-				val = 0;
-			else
-				val -= right_step;
-
-			reg &= ~TWL6040_HSR_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HSGAIN,
-					 reg | (~val << TWL6040_HSR_VOL_SHIFT));
-		} else {
-			right_complete = 1;
-		}
-	}
-
-	return left_complete & right_complete;
-}
-
-/*
- * Ramp HF PGA volume to minimise pops at stream startup and shutdown.
- */
-static inline int twl6040_hf_ramp_step(struct snd_soc_codec *codec,
-			unsigned int left_step, unsigned int right_step)
-{
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *handsfree = &priv->handsfree;
-	int left_complete = 0, right_complete = 0;
-	u16 reg, val;
-
-	/* left channel */
-	left_step = (left_step > 0x1D) ? 0x1D : left_step;
-	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFLGAIN);
-	reg = 0x1D - reg;
-	val = (reg & TWL6040_HF_VOL_MASK);
-	if (handsfree->ramp == TWL6040_RAMP_UP) {
-		/* ramp step up */
-		if (val < handsfree->left_vol) {
-			if (val + left_step > handsfree->left_vol)
-				val = handsfree->left_vol;
-			else
-				val += left_step;
-
-			reg &= ~TWL6040_HF_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HFLGAIN,
-						reg | (0x1D - val));
-		} else {
-			left_complete = 1;
-		}
-	} else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
-		/* ramp step down */
-		if (val > 0) {
-			if ((int)val - (int)left_step < 0)
-				val = 0;
-			else
-				val -= left_step;
-
-			reg &= ~TWL6040_HF_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HFLGAIN,
-						reg | (0x1D - val));
-		} else {
-			left_complete = 1;
-		}
-	}
-
-	/* right channel */
-	right_step = (right_step > 0x1D) ? 0x1D : right_step;
-	reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFRGAIN);
-	reg = 0x1D - reg;
-	val = (reg & TWL6040_HF_VOL_MASK);
-	if (handsfree->ramp == TWL6040_RAMP_UP) {
-		/* ramp step up */
-		if (val < handsfree->right_vol) {
-			if (val + right_step > handsfree->right_vol)
-				val = handsfree->right_vol;
-			else
-				val += right_step;
-
-			reg &= ~TWL6040_HF_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HFRGAIN,
-						reg | (0x1D - val));
-		} else {
-			right_complete = 1;
-		}
-	} else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
-		/* ramp step down */
-		if (val > 0) {
-			if ((int)val - (int)right_step < 0)
-				val = 0;
-			else
-				val -= right_step;
-
-			reg &= ~TWL6040_HF_VOL_MASK;
-			twl6040_write(codec, TWL6040_REG_HFRGAIN,
-						reg | (0x1D - val));
-		}
-	}
-
-	return left_complete & right_complete;
-}
-
-/*
- * This work ramps both output PGAs at stream start/stop time to
- * minimise pop associated with DAPM power switching.
- */
-static void twl6040_pga_hs_work(struct work_struct *work)
-{
-	struct twl6040_data *priv =
-		container_of(work, struct twl6040_data, headset.work.work);
-	struct snd_soc_codec *codec = priv->codec;
-	struct twl6040_output *headset = &priv->headset;
-	int i, headset_complete;
-
-	/* do we need to ramp at all ? */
-	if (headset->ramp == TWL6040_RAMP_NONE)
-		return;
-
-	/* HS PGA gain range: 0x0 - 0xf (0 - 15) */
-	for (i = 0; i < 16; i++) {
-		headset_complete = twl6040_hs_ramp_step(codec,
-						headset->left_step,
-						headset->right_step);
-
-		/* ramp finished ? */
-		if (headset_complete)
-			break;
-
-		schedule_timeout_interruptible(
-				msecs_to_jiffies(headset->step_delay));
-	}
-
-	if (headset->ramp == TWL6040_RAMP_DOWN) {
-		headset->active = 0;
-		complete(&headset->ramp_done);
-	} else {
-		headset->active = 1;
-	}
-	headset->ramp = TWL6040_RAMP_NONE;
-}
-
-static void twl6040_pga_hf_work(struct work_struct *work)
-{
-	struct twl6040_data *priv =
-		container_of(work, struct twl6040_data, handsfree.work.work);
-	struct snd_soc_codec *codec = priv->codec;
-	struct twl6040_output *handsfree = &priv->handsfree;
-	int i, handsfree_complete;
-
-	/* do we need to ramp at all ? */
-	if (handsfree->ramp == TWL6040_RAMP_NONE)
-		return;
-
-	/*
-	 * HF PGA gain range: 0x00 - 0x1d (0 - 29) */
-	for (i = 0; i < 30; i++) {
-		handsfree_complete = twl6040_hf_ramp_step(codec,
-						handsfree->left_step,
-						handsfree->right_step);
-
-		/* ramp finished ? */
-		if (handsfree_complete)
-			break;
-
-		schedule_timeout_interruptible(
-				msecs_to_jiffies(handsfree->step_delay));
-	}
-
-
-	if (handsfree->ramp == TWL6040_RAMP_DOWN) {
-		handsfree->active = 0;
-		complete(&handsfree->ramp_done);
-	} else
-		handsfree->active = 1;
-	handsfree->ramp = TWL6040_RAMP_NONE;
-}
-
-static int out_drv_event(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *out;
-	struct delayed_work *work;
-
-	switch (w->shift) {
-	case 2: /* Headset output driver */
-		out = &priv->headset;
-		work = &out->work;
-		/*
-		 * Make sure, that we do not mess up variables for already
-		 * executing work.
-		 */
-		cancel_delayed_work_sync(work);
-
-		out->left_step = priv->hs_left_step;
-		out->right_step = priv->hs_right_step;
-		out->step_delay = 5;	/* 5 ms between volume ramp steps */
-		break;
-	case 4: /* Handsfree output driver */
-		out = &priv->handsfree;
-		work = &out->work;
-		/*
-		 * Make sure, that we do not mess up variables for already
-		 * executing work.
-		 */
-		cancel_delayed_work_sync(work);
-
-		out->left_step = priv->hf_left_step;
-		out->right_step = priv->hf_right_step;
-		out->step_delay = 5;	/* 5 ms between volume ramp steps */
-		break;
-	default:
-		return -1;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		if (out->active)
-			break;
-
-		/* don't use volume ramp for power-up */
-		out->ramp = TWL6040_RAMP_UP;
-		out->left_step = out->left_vol;
-		out->right_step = out->right_vol;
-
-		queue_delayed_work(priv->workqueue, work, msecs_to_jiffies(1));
-		break;
-
-	case SND_SOC_DAPM_PRE_PMD:
-		if (!out->active)
-			break;
-
-		/* use volume ramp for power-down */
-		out->ramp = TWL6040_RAMP_DOWN;
-		INIT_COMPLETION(out->ramp_done);
-
-		queue_delayed_work(priv->workqueue, work, msecs_to_jiffies(1));
-
-		wait_for_completion_timeout(&out->ramp_done,
-					    msecs_to_jiffies(2000));
-		break;
-	}
-
-	return 0;
-}
-
 /* set headset dac and driver power mode */
 static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 {
@@ -747,71 +410,6 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *out = NULL;
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int ret;
-
-	/* For HS and HF we shadow the values and only actually write
-	 * them out when active in order to ensure the amplifier comes on
-	 * as quietly as possible. */
-	switch (mc->reg) {
-	case TWL6040_REG_HSGAIN:
-		out = &twl6040_priv->headset;
-		break;
-	case TWL6040_REG_HFLGAIN:
-		out = &twl6040_priv->handsfree;
-		break;
-	default:
-		dev_warn(codec->dev, "%s: Unexpected register: 0x%02x\n",
-					__func__, mc->reg);
-		return -EINVAL;
-	}
-
-	out->left_vol = ucontrol->value.integer.value[0];
-	out->right_vol = ucontrol->value.integer.value[1];
-	if (!out->active)
-		return 1;
-
-	ret = snd_soc_put_volsw(kcontrol, ucontrol);
-	if (ret < 0)
-		return ret;
-
-	return 1;
-}
-
-static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *out = &twl6040_priv->headset;
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-
-	switch (mc->reg) {
-	case TWL6040_REG_HSGAIN:
-		out = &twl6040_priv->headset;
-		break;
-	case TWL6040_REG_HFLGAIN:
-		out = &twl6040_priv->handsfree;
-		break;
-	default:
-		dev_warn(codec->dev, "%s: Unexpected register: 0x%02x\n",
-					__func__, mc->reg);
-		return -EINVAL;
-	}
-
-	ucontrol->value.integer.value[0] = out->left_vol;
-	ucontrol->value.integer.value[1] = out->right_vol;
-	return 0;
-}
-
 static int twl6040_soc_dapm_put_vibra_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -1076,12 +674,10 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 		TWL6040_REG_LINEGAIN, 0, 3, 7, 0, afm_amp_tlv),
 
 	/* Playback gains */
-	SOC_DOUBLE_EXT_TLV("Headset Playback Volume",
-		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, twl6040_get_volsw,
-		twl6040_put_volsw, hs_tlv),
-	SOC_DOUBLE_R_EXT_TLV("Handsfree Playback Volume",
-		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1,
-		twl6040_get_volsw, twl6040_put_volsw, hf_tlv),
+	SOC_DOUBLE_TLV("Headset Playback Volume",
+		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
+	SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
+		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
 	SOC_SINGLE_TLV("Earphone Playback Volume",
 		TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
 
@@ -1180,22 +776,14 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			&auxr_switch_control),
 
 	/* Analog playback drivers */
-	SND_SOC_DAPM_OUT_DRV_E("HF Left Driver",
-			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
-			out_drv_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("HF Right Driver",
-			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
-			out_drv_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("HS Left Driver",
-			TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
-			out_drv_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("HS Right Driver",
-			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
-			out_drv_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_OUT_DRV("HF Left Driver",
+			TWL6040_REG_HFLCTL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("HF Right Driver",
+			TWL6040_REG_HFRCTL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("HS Left Driver",
+			TWL6040_REG_HSLCTL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("HS Right Driver",
+			TWL6040_REG_HSRCTL, 2, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV_E("Earphone Driver",
 			TWL6040_REG_EARCTL, 0, 0, NULL, 0,
 			twl6040_ep_drv_event,
@@ -1570,14 +1158,9 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	}
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
-	INIT_DELAYED_WORK(&priv->headset.work, twl6040_pga_hs_work);
-	INIT_DELAYED_WORK(&priv->handsfree.work, twl6040_pga_hf_work);
 
 	mutex_init(&priv->mutex);
 
-	init_completion(&priv->headset.ramp_done);
-	init_completion(&priv->handsfree.ramp_done);
-
 	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
 				   0, "twl6040_irq_plug", codec);
 	if (ret) {
-- 
1.7.8.6
