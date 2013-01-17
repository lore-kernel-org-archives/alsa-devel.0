From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 002/002] ASoC: Replace max98090
	Device	Driver
Date: Thu, 17 Jan 2013 02:53:33 +0000
Message-ID: <20130117025333.GA12645@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F403@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17291264F07
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 03:53:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F403@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 14, 2013 at 07:13:30AM -0800, Jerry Wong wrote:

> I have updated most per the review comments, except...
> "External MIC Mux" is a mux with 0=power down, and exists in DAPM as well
> "Digital Sidetone Source", with a master SHDN has no power impact, so was left out of DAPM

Sidetone should have an impact on routing though?  DAPM needs routing to
do power.

> "Quick Setup System Clock" was just a question what they do... they override the
>  clock settings for common use cases.
> "VCM bandgap reference", with a master SHDN has no power impact, so was left out of DAPM
> 

Please have this sort of discussion in line with the previous review -
discuss why you don't agree with the feedback rather than just sending a
new patch.  That tends to be less time consuming and it's easier to
follow the discusssion.

> +static const char * max98090_extmic_mux_text[] = { "MIC1", "MIC2" };
> +
> +static const struct soc_enum max98090_extmic_mux_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_CFG_LINE, M98090_EXTMIC_SHIFT,
> +               ARRAY_SIZE(max98090_extmic_mux_text),
> +               max98090_extmic_mux_text);

This looks like routing control which I'd expect to be in DAPM - I'd not
expect duplication between DAPM and non-DAPM to work very well.

> +static const char * max98090_mixg_text[] = { "Normal", "6dB" };

> +static const struct soc_enum max98090_mixg135_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_LVL_LINE, M98090_MIXG135_SHIFT,
> +               ARRAY_SIZE(max98090_mixg_text), max98090_mixg_text);
> +
> +static const struct soc_enum max98090_mixg246_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_LVL_LINE, M98090_MIXT246_SHIFT,
> +               ARRAY_SIZE(max98090_mixg_text), max98090_mixg_text);

This looks like it should be a volume control with two steps of 0dB and
6dB?

> +static const char * max98090_enableddisabled_text[] =
> +       { "Disabled", "Enabled" };
> +static const char * max98090_enableddisabled_inv_text[] =
> +       { "Enabled", "Disabled" };
> +/* Note: Inverted Logic (0 = Enabled) */
> +
> +static const struct soc_enum max98090_eqclpn_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_DAI_LVL_EQ, M98090_DAI_LVL_EQCLPN_SHIFT,
> +               ARRAY_SIZE(max98090_enableddisabled_inv_text),
> +               max98090_enableddisabled_inv_text);

These look like they should be Switch controls (which will help UIs
render them).

> +static const struct snd_kcontrol_new max98090_snd_controls[] = {
> +       SOC_SINGLE("MIC Bias VCM Bandgap", M98090_REG_BIAS_CNTL,
> +               M98090_VCM_MODE_SHIFT, M98090_VCM_MODE_NUM - 1, 0),

Why is this a user visible control?

> +       SOC_SINGLE("Quick Setup Sample Rate", M98090_REG_QCFG_RATE,
> +               M98090_SR_ALL_SHIFT, M98090_SR_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup DAI Interface", M98090_REG_QCFG_DAI,
> +               M98090_DAI_ALL_SHIFT, M98090_DAI_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup DAC Path", M98090_REG_QCFG_DAC,
> +               M98090_DIG2_ALL_SHIFT, M98090_DIG2_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup MIC/Direct ADC", M98090_REG_QCFG_MIC_PATH,
> +               M98090_MIC_ALL_SHIFT, M98090_MIC_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup Line ADC", M98090_REG_QCFG_LINE_PATH,
> +               M98090_LINE_ALL_SHIFT, M98090_LINE_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup Analog MIC Loop", M98090_REG_QCFG_MIC_LOOP,
> +               M98090_AMIC_ALL_SHIFT, M98090_AMIC_ALL_NUM - 1, 0),
> +       SOC_SINGLE("Quick Setup Analog Line Loop",
> +               M98090_REG_QCFG_LINE_LOOP, M98090_ALIN_ALL_SHIFT,
> +               M98090_ALIN_ALL_NUM - 1, 0),

What do these controls do?

> +       SOC_SINGLE("Rev ID", M98090_REG_REV_ID,
> +               M98090_REVID_SHIFT, M98090_REVID_NUM - 1, 0),

Hrm, this needs to be read only I think but we don't support that via
standard macros.  I'd expect exposing via a sysfs file rather than an
ALSA control, or just logging on startup - it'll be exposed via the
regmap debugfs interface anyway.

> +static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
> +
> +       {"MIC1 Input", NULL, "MIC1"},
> +       {"MIC2 Input", NULL, "MIC2"},
> +       {"MIC1 Input", NULL, "MICBIAS"},
> +       {"MIC2 Input", NULL, "MICBIAS"},

Is this really an internal connection in the device and not something
that's done in the system?

> +/*
> + * This accommodates an inverted logic in the MAX98090 chip
> + * for Bit Clock Invert (BCI). The inverted logic is only seen
> + * for the case of TDM mode. The remaining cases have normal logic.
> + */
> +               if (max98090->tdm_slots > 1) {
> +                       regval ^= M98090_DAI_BCI_MASK;

Coding style, your comment is misaligned.

> +
> +       switch (reg & (M98090_LSNS_MASK | M98090_JKSNS_MASK)) {
> +               case M98090_LSNS_MASK | M98090_JKSNS_MASK:
> +               {

You don't need the { } and they make the code look unusual.

> +                       dev_info(codec->dev, "No Headset Detected\n");
> +
> +                       max98090->jack_state = M98090_JACK_STATE_NO_HEADSET;
> +
> +                       max98090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

The issues I mentioned last time with the lack of sync between this code
and DAPM still apply - DAPM is likely to just come along and override
you here.

> +       if (active & M98090_IRQ_ULK_MASK) {
> +               dev_dbg(codec->dev, "M98090_IRQ_ULK_MASK\n");
> +       }

Should things like this be dev_err() - they look like real error
reports from the device?

> +                                const struct i2c_device_id *id)
> +{
> +       struct max98090_priv *max98090;
> +       int ret;
> +
> +       pr_info("max98090_i2c_probe\n");

No need for log messages like this - dev_dbg() at most.

> +       max98090 = kzalloc(sizeof(struct max98090_priv), GFP_KERNEL);
> +       if (max98090 == NULL)
> +               return -ENOMEM;

devm_kzalloc() then you don't need to explicitly free() which will fix
leaks on error.

> +static int max98090_runtime_resume(struct device *dev)
> +{
> +       struct max98090_priv *max98090 = dev_get_drvdata(dev);
> +
> +       regcache_cache_only(max98090->regmap, false);
> +
> +       max98090_reset(max98090);
> +
> +       regcache_sync(max98090->regmap);

Do you realy need to reset the device here?  If anything I'd expect it
on suspend since the reset state is probably the lowest power state.
