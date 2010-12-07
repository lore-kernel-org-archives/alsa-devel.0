From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 10/15] ASoC: twl6040: Add ramp up/down volume
	for HS and HF
Date: Mon, 6 Dec 2010 18:18:11 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BF3511039AC
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:13 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Add ramp functions for the headset and handsfree outputs
in order to reduce the pops during power on/off sequences.

In order to give more control to volume ramp, step size and delay
between steps can be specified.

The patches are based on wm8350 implementation from Liam
Girdwood.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 sound/soc/codecs/twl6040.c |  536 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 524 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0079e12..b2402ae 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -40,7 +40,35 @@
 #include "twl6040.h"

 #define TWL6040_RATES          SNDRV_PCM_RATE_8000_96000
-#define TWL6040_FORMATS         (SNDRV_PCM_FMTBIT_S32_LE)
+#define TWL6040_FORMATS        (SNDRV_PCM_FMTBIT_S32_LE)
+
+#define TWL6040_OUTHS_0dB 0x00
+#define TWL6040_OUTHS_M30dB 0x0F
+#define TWL6040_OUTHF_0dB 0x03
+#define TWL6040_OUTHF_M52dB 0x1D
+
+#define TWL6040_RAMP_NONE      0
+#define TWL6040_RAMP_UP                1
+#define TWL6040_RAMP_DOWN      2
+
+#define TWL6040_HSL_VOL_MASK    0x0F
+#define TWL6040_HSL_VOL_SHIFT   0
+#define TWL6040_HSR_VOL_MASK    0xF0
+#define TWL6040_HSR_VOL_SHIFT   4
+#define TWL6040_HF_VOL_MASK    0x1F
+#define TWL6040_HF_VOL_SHIFT   0
+
+struct twl6040_output {
+       u16 active;
+       u16 left_vol;
+       u16 right_vol;
+       u16 left_step;
+       u16 right_step;
+       unsigned int step_delay;
+       u16 ramp;
+       u16 mute;
+       struct completion ramp_done;
+};

 struct twl6040_jack_data {
        struct snd_soc_jack *jack;
@@ -58,6 +86,13 @@ struct twl6040_data {
        unsigned int sysclk;
        struct snd_pcm_hw_constraint_list *sysclk_constraints;
        struct completion ready;
+       struct twl6040_output headset;
+       struct twl6040_output handsfree;
+       struct workqueue_struct *hf_workqueue;
+       struct workqueue_struct *hs_workqueue;
+       struct delayed_work hs_delayed_work;
+       struct delayed_work hf_delayed_work;
+       struct snd_soc_codec *codec;
 };

 /*
@@ -259,6 +294,305 @@ static void twl6040_init_vdd_regs(struct snd_soc_codec *codec)
        }
 }

+/*
+ * Ramp HS PGA volume to minimise pops at stream startup and shutdown.
+ */
+static inline int twl6040_hs_ramp_step(struct snd_soc_codec *codec,
+                       unsigned int left_step, unsigned int right_step)
+{
+
+       struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *headset = &priv->headset;
+       int left_complete = 0, right_complete = 0;
+       u8 reg, val;
+
+       /* left channel */
+       left_step = (left_step > 0xF) ? 0xF : left_step;
+       reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
+       val = (~reg & TWL6040_HSL_VOL_MASK);
+
+       if (headset->ramp == TWL6040_RAMP_UP) {
+               /* ramp step up */
+               if (val < headset->left_vol) {
+                       val += left_step;
+                       reg &= ~TWL6040_HSL_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HSGAIN,
+                                       (reg | (~val & TWL6040_HSL_VOL_MASK)));
+               } else {
+                       left_complete = 1;
+               }
+       } else if (headset->ramp == TWL6040_RAMP_DOWN) {
+               /* ramp step down */
+               if (val > 0x0) {
+                       val -= left_step;
+                       reg &= ~TWL6040_HSL_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HSGAIN, reg |
+                                               (~val & TWL6040_HSL_VOL_MASK));
+               } else {
+                       left_complete = 1;
+               }
+       }
+
+       /* right channel */
+       right_step = (right_step > 0xF) ? 0xF : right_step;
+       reg = twl6040_read_reg_cache(codec, TWL6040_REG_HSGAIN);
+       val = (~reg & TWL6040_HSR_VOL_MASK) >> TWL6040_HSR_VOL_SHIFT;
+
+       if (headset->ramp == TWL6040_RAMP_UP) {
+               /* ramp step up */
+               if (val < headset->right_vol) {
+                       val += right_step;
+                       reg &= ~TWL6040_HSR_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HSGAIN,
+                               (reg | (~val << TWL6040_HSR_VOL_SHIFT)));
+               } else {
+                       right_complete = 1;
+               }
+       } else if (headset->ramp == TWL6040_RAMP_DOWN) {
+               /* ramp step down */
+               if (val > 0x0) {
+                       val -= right_step;
+                       reg &= ~TWL6040_HSR_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HSGAIN,
+                                        reg | (~val << TWL6040_HSR_VOL_SHIFT));
+               } else {
+                       right_complete = 1;
+               }
+       }
+
+       return left_complete & right_complete;
+}
+
+/*
+ * Ramp HF PGA volume to minimise pops at stream startup and shutdown.
+ */
+static inline int twl6040_hf_ramp_step(struct snd_soc_codec *codec,
+                       unsigned int left_step, unsigned int right_step)
+{
+       struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *handsfree = &priv->handsfree;
+       int left_complete = 0, right_complete = 0;
+       u16 reg, val;
+
+       /* left channel */
+       left_step = (left_step > 0x1D) ? 0x1D : left_step;
+       reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFLGAIN);
+       reg = 0x1D - reg;
+       val = (reg & TWL6040_HF_VOL_MASK);
+       if (handsfree->ramp == TWL6040_RAMP_UP) {
+               /* ramp step up */
+               if (val < handsfree->left_vol) {
+                       val += left_step;
+                       reg &= ~TWL6040_HF_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HFLGAIN,
+                                               reg | (0x1D - val));
+               } else {
+                       left_complete = 1;
+               }
+       } else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+               /* ramp step down */
+               if (val > 0) {
+                       val -= left_step;
+                       reg &= ~TWL6040_HF_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HFLGAIN,
+                                               reg | (0x1D - val));
+               } else {
+                       left_complete = 1;
+               }
+       }
+
+       /* right channel */
+       right_step = (right_step > 0x1D) ? 0x1D : right_step;
+       reg = twl6040_read_reg_cache(codec, TWL6040_REG_HFRGAIN);
+       reg = 0x1D - reg;
+       val = (reg & TWL6040_HF_VOL_MASK);
+       if (handsfree->ramp == TWL6040_RAMP_UP) {
+               /* ramp step up */
+               if (val < handsfree->right_vol) {
+                       val += right_step;
+                       reg &= ~TWL6040_HF_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HFRGAIN,
+                                               reg | (0x1D - val));
+               } else {
+                       right_complete = 1;
+               }
+       } else if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+               /* ramp step down */
+               if (val > 0) {
+                       val -= right_step;
+                       reg &= ~TWL6040_HF_VOL_MASK;
+                       twl6040_write(codec, TWL6040_REG_HFRGAIN,
+                                               reg | (0x1D - val));
+               }
+       }
+
+       return left_complete & right_complete;
+}
+
+/*
+ * This work ramps both output PGAs at stream start/stop time to
+ * minimise pop associated with DAPM power switching.
+ */
+static void twl6040_pga_hs_work(struct work_struct *work)
+{
+       struct twl6040_data *priv =
+               container_of(work, struct twl6040_data, hs_delayed_work.work);
+       struct snd_soc_codec *codec = priv->codec;
+       struct twl6040_output *headset = &priv->headset;
+       unsigned int delay = headset->step_delay;
+       int i, headset_complete;
+
+       /* do we need to ramp at all ? */
+       if (headset->ramp == TWL6040_RAMP_NONE)
+               return;
+
+       /* HS PGA volumes have 4 bits of resolution to ramp */
+       for (i = 0; i <= 16; i++) {
+               headset_complete = 1;
+               if (headset->ramp != TWL6040_RAMP_NONE)
+                       headset_complete = twl6040_hs_ramp_step(codec,
+                                                       headset->left_step,
+                                                       headset->right_step);
+
+               /* ramp finished ? */
+               if (headset_complete)
+                       break;
+
+               /*
+                * TODO: tune: delay is longer over 0dB
+                * as increases are larger.
+                */
+               if (i >= 8)
+                       schedule_timeout_interruptible(msecs_to_jiffies(delay +
+                                                      (delay >> 1)));
+               else
+                       schedule_timeout_interruptible(msecs_to_jiffies(delay));
+       }
+
+       if (headset->ramp == TWL6040_RAMP_DOWN) {
+               headset->active = 0;
+               complete(&headset->ramp_done);
+       } else {
+               headset->active = 1;
+       }
+       headset->ramp = TWL6040_RAMP_NONE;
+}
+
+static void twl6040_pga_hf_work(struct work_struct *work)
+{
+       struct twl6040_data *priv =
+               container_of(work, struct twl6040_data, hf_delayed_work.work);
+       struct snd_soc_codec *codec = priv->codec;
+       struct twl6040_output *handsfree = &priv->handsfree;
+       unsigned int delay = handsfree->step_delay;
+       int i, handsfree_complete;
+
+       /* do we need to ramp at all ? */
+       if (handsfree->ramp == TWL6040_RAMP_NONE)
+               return;
+
+       /* HF PGA volumes have 5 bits of resolution to ramp */
+       for (i = 0; i <= 32; i++) {
+               handsfree_complete = 1;
+               if (handsfree->ramp != TWL6040_RAMP_NONE)
+                       handsfree_complete = twl6040_hf_ramp_step(codec,
+                                                       handsfree->left_step,
+                                                       handsfree->right_step);
+
+               /* ramp finished ? */
+               if (handsfree_complete)
+                       break;
+
+               /*
+                * TODO: tune: delay is longer over 0dB
+                * as increases are larger.
+                */
+               if (i >= 16)
+                       schedule_timeout_interruptible(msecs_to_jiffies(delay +
+                                                      (delay >> 1)));
+               else
+                       schedule_timeout_interruptible(msecs_to_jiffies(delay));
+       }
+
+
+       if (handsfree->ramp == TWL6040_RAMP_DOWN) {
+               handsfree->active = 0;
+               complete(&handsfree->ramp_done);
+       } else
+               handsfree->active = 1;
+       handsfree->ramp = TWL6040_RAMP_NONE;
+}
+
+static int pga_event(struct snd_soc_dapm_widget *w,
+                       struct snd_kcontrol *kcontrol, int event)
+{
+       struct snd_soc_codec *codec = w->codec;
+       struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *out;
+       struct delayed_work *work;
+       struct workqueue_struct *queue;
+
+       switch (w->shift) {
+       case 2:
+       case 3:
+               out = &priv->headset;
+               work = &priv->hs_delayed_work;
+               queue = priv->hs_workqueue;
+               out->step_delay = 5;    /* 5 ms between volume ramp steps */
+               break;
+       case 4:
+               out = &priv->handsfree;
+               work = &priv->hf_delayed_work;
+               queue = priv->hf_workqueue;
+               out->step_delay = 5;    /* 5 ms between volume ramp steps */
+               if (SND_SOC_DAPM_EVENT_ON(event))
+                       priv->non_lp++;
+               else
+                       priv->non_lp--;
+               break;
+       default:
+               return -1;
+       }
+
+       switch (event) {
+       case SND_SOC_DAPM_POST_PMU:
+               if (out->active)
+                       break;
+
+               /* don't use volume ramp for power-up */
+               out->left_step = out->left_vol;
+               out->right_step = out->right_vol;
+
+               if (!delayed_work_pending(work)) {
+                       out->ramp = TWL6040_RAMP_UP;
+                       queue_delayed_work(queue, work,
+                                       msecs_to_jiffies(1));
+               }
+               break;
+
+       case SND_SOC_DAPM_PRE_PMD:
+               if (!out->active)
+                       break;
+
+               if (!delayed_work_pending(work)) {
+                       /* use volume ramp for power-down */
+                       out->left_step = 1;
+                       out->right_step = 1;
+                       out->ramp = TWL6040_RAMP_DOWN;
+                       INIT_COMPLETION(out->ramp_done);
+
+                       queue_delayed_work(queue, work,
+                                       msecs_to_jiffies(1));
+
+                       wait_for_completion_timeout(&out->ramp_done,
+                                       msecs_to_jiffies(2000));
+               }
+               break;
+       }
+
+       return 0;
+}
+
 /* twl6040 codec manual power-up sequence */
 static void twl6040_power_up(struct snd_soc_codec *codec)
 {
@@ -419,6 +753,156 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
        return IRQ_HANDLED;
 }

+static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
+                                 struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *out = NULL;
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       int ret;
+       unsigned int reg = mc->reg;
+
+       /* For HS and HF we shadow the values and only actually write
+        * them out when active in order to ensure the amplifier comes on
+        * as quietly as possible. */
+       switch (reg) {
+       case TWL6040_REG_HSGAIN:
+               out = &twl6040_priv->headset;
+               break;
+       default:
+               break;
+       }
+
+       if (out) {
+               out->left_vol = ucontrol->value.integer.value[0];
+               out->right_vol = ucontrol->value.integer.value[1];
+               if (!out->active)
+                       return 1;
+       }
+
+       ret = snd_soc_put_volsw(kcontrol, ucontrol);
+       if (ret < 0)
+               return ret;
+
+       return 1;
+}
+
+static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
+                              struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *out = &twl6040_priv->headset;
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       unsigned int reg = mc->reg;
+
+       switch (reg) {
+       case TWL6040_REG_HSGAIN:
+               out = &twl6040_priv->headset;
+               ucontrol->value.integer.value[0] = out->left_vol;
+               ucontrol->value.integer.value[1] = out->right_vol;
+               return 0;
+
+       default:
+               break;
+       }
+
+       return snd_soc_get_volsw(kcontrol, ucontrol);
+}
+
+static int twl6040_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
+                                 struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *out = NULL;
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       int ret;
+       unsigned int reg = mc->reg;
+
+       /* For HS and HF we shadow the values and only actually write
+        * them out when active in order to ensure the amplifier comes on
+        * as quietly as possible. */
+       switch (reg) {
+       case TWL6040_REG_HFLGAIN:
+       case TWL6040_REG_HFRGAIN:
+               out = &twl6040_priv->handsfree;
+               break;
+       default:
+               break;
+       }
+
+       if (out) {
+               out->left_vol = ucontrol->value.integer.value[0];
+               out->right_vol = ucontrol->value.integer.value[1];
+               if (!out->active)
+                       return 1;
+       }
+
+       ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
+       if (ret < 0)
+               return ret;
+
+       return 1;
+}
+
+static int twl6040_get_volsw_2r(struct snd_kcontrol *kcontrol,
+                              struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
+       struct twl6040_output *out = &twl6040_priv->handsfree;
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       unsigned int reg = mc->reg;
+
+       /* If these are cached registers use the cache */
+       switch (reg) {
+       case TWL6040_REG_HFLGAIN:
+       case TWL6040_REG_HFRGAIN:
+               out = &twl6040_priv->handsfree;
+               ucontrol->value.integer.value[0] = out->left_vol;
+               ucontrol->value.integer.value[1] = out->right_vol;
+               return 0;
+
+       default:
+               break;
+       }
+
+       return snd_soc_get_volsw_2r(kcontrol, ucontrol);
+}
+
+/* double control with volume update */
+#define SOC_TWL6040_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax,\
+                                                       xinvert, tlv_array) \
+{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+       .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+                SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+       .tlv.p = (tlv_array), \
+       .info = snd_soc_info_volsw, .get = twl6040_get_volsw, \
+       .put = twl6040_put_volsw, \
+       .private_value = (unsigned long)&(struct soc_mixer_control) \
+               {.reg = xreg, .shift = shift_left, .rshift = shift_right,\
+                .max = xmax, .platform_max = xmax, .invert = xinvert} }
+
+/* double control with volume update */
+#define SOC_TWL6040_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, \
+                               xinvert, tlv_array) \
+{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+       .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+               SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+               SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+       .tlv.p = (tlv_array), \
+       .info = snd_soc_info_volsw_2r, \
+       .get = twl6040_get_volsw_2r, .put = twl6040_put_volsw_2r_vu, \
+       .private_value = (unsigned long)&(struct soc_mixer_control) \
+               {.reg = reg_left, .rreg = reg_right, .shift = xshift, \
+                .rshift = xshift, .max = xmax, .invert = xinvert}, }
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -516,9 +1000,9 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
                TWL6040_REG_LINEGAIN, 0, 5, 0xF, 0, afm_amp_tlv),

        /* Playback gains */
-       SOC_DOUBLE_TLV("Headset Playback Volume",
+       SOC_TWL6040_DOUBLE_TLV("Headset Playback Volume",
                TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
-       SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
+       SOC_TWL6040_DOUBLE_R_TLV("Handsfree Playback Volume",
                TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
        SOC_SINGLE_TLV("Earphone Playback Volume",
                TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
@@ -604,16 +1088,20 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
        /* Analog playback drivers */
        SND_SOC_DAPM_PGA_E("Handsfree Left Driver",
                        TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
-                       twl6040_power_mode_event,
-                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+                       pga_event,
+                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
        SND_SOC_DAPM_PGA_E("Handsfree Right Driver",
                        TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
-                       twl6040_power_mode_event,
-                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
-       SND_SOC_DAPM_PGA("Headset Left Driver",
-                       TWL6040_REG_HSLCTL, 2, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("Headset Right Driver",
-                       TWL6040_REG_HSRCTL, 2, 0, NULL, 0),
+                       pga_event,
+                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+       SND_SOC_DAPM_PGA_E("Headset Left Driver",
+                       TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
+                       pga_event,
+                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+       SND_SOC_DAPM_PGA_E("Headset Right Driver",
+                       TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
+                       pga_event,
+                       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
        SND_SOC_DAPM_SWITCH_E("Earphone Driver",
                        SND_SOC_NOPM, 0, 0, &ep_driver_switch_controls,
                        twl6040_power_mode_event,
@@ -1108,6 +1596,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
                return -ENOMEM;
        snd_soc_codec_set_drvdata(codec, priv);

+       priv->codec = codec;
+
        twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &icrev, TWL6040_REG_ASICREV);

        if (twl_codec && (icrev > 0))
@@ -1124,6 +1614,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
        priv->naudint = naudint;

        init_completion(&priv->ready);
+       init_completion(&priv->headset.ramp_done);
+       init_completion(&priv->handsfree.ramp_done);

        if (gpio_is_valid(audpwron)) {
                ret = gpio_request(audpwron, "audpwron");
@@ -1160,10 +1652,24 @@ static int twl6040_probe(struct snd_soc_codec *codec)
        /* init vio registers */
        twl6040_init_vio_regs(codec);

+       priv->hf_workqueue = create_singlethread_workqueue("twl6040-hf");
+       if (priv->hf_workqueue == NULL) {
+               ret = -ENOMEM;
+               goto irq_err;
+       }
+       priv->hs_workqueue = create_singlethread_workqueue("twl6040-hs");
+       if (priv->hs_workqueue == NULL) {
+               ret = -ENOMEM;
+               goto wq_err;
+       }
+
+       INIT_DELAYED_WORK(&priv->hs_delayed_work, twl6040_pga_hs_work);
+       INIT_DELAYED_WORK(&priv->hf_delayed_work, twl6040_pga_hf_work);
+
        /* power on device */
        ret = twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
        if (ret)
-               goto irq_err;
+               goto bias_err;

        snd_soc_add_controls(codec, twl6040_snd_controls,
                                ARRAY_SIZE(twl6040_snd_controls));
@@ -1171,6 +1677,10 @@ static int twl6040_probe(struct snd_soc_codec *codec)

        return 0;

+bias_err:
+       destroy_workqueue(priv->hs_workqueue);
+wq_err:
+       destroy_workqueue(priv->hf_workqueue);
 irq_err:
        if (naudint)
                free_irq(naudint, codec);
@@ -1196,6 +1706,8 @@ static int twl6040_remove(struct snd_soc_codec *codec)
        if (naudint)
                free_irq(naudint, codec);

+       destroy_workqueue(priv->hf_workqueue);
+       destroy_workqueue(priv->hs_workqueue);
        kfree(priv);

        return 0;
--
1.7.0.4
