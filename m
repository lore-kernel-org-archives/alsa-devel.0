From: Jerry Wong <Jerry.Wong@maximintegrated.com>
Subject: Re: [PATCH 002/002] ASoC: Replace max98090
	Device	Driver
Date: Wed, 23 Jan 2013 09:33:57 -0800
Message-ID: <A453F1AE3B5DC14DB19666C506CE75A7108684F4A9@ITSVLEX06.it.maxim-ic.internal>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F403@ITSVLEX06.it.maxim-ic.internal>,
 <20130117025333.GA12645@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maximintegrated.com (antispam01.maxim-ic.com
 [205.153.101.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 11A0D265360
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 18:34:03 +0100 (CET)
In-Reply-To: <20130117025333.GA12645@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

I was able to make changes for each of your comments except the following...

Jerry

-----

> +static const char * max98090_extmic_mux_text[] = { "MIC1", "MIC2" };
> +
> +static const struct soc_enum max98090_extmic_mux_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_CFG_LINE, M98090_EXTMIC_SHIFT,
> +               ARRAY_SIZE(max98090_extmic_mux_text),
> +               max98090_extmic_mux_text);

> This looks like routing control which I'd expect to be in DAPM - I'd not
> expect duplication between DAPM and non-DAPM to work very well.

This is an odd control that is a combination of an enum and a power
management widget. The 0 value of the enum  turns power off.
Not sure what is another choice. The enum value needs to be
saved so it can be restored when DAPM turns the control on.

> +static const struct snd_kcontrol_new max98090_snd_controls[] = {
> +       SOC_SINGLE("MIC Bias VCM Bandgap", M98090_REG_BIAS_CNTL,
> +               M98090_VCM_MODE_SHIFT, M98090_VCM_MODE_NUM - 1, 0),

> Why is this a user visible control?

It is not controlled by DAPM. The low power function is taken care of by
/SHDN\, so this retains the user choice of bandgap or divider reference.

> +static int max98090_runtime_resume(struct device *dev)
> +{
> +       struct max98090_priv *max98090 = dev_get_drvdata(dev);
> +
> +       regcache_cache_only(max98090->regmap, false);
> +
> +       max98090_reset(max98090);
> +
> +       regcache_sync(max98090->regmap);

> Do you really need to reset the device here?  If anything I'd expect it
> on suspend since the reset state is probably the lowest power state.

Yes, for a soft reset where the device is not power cycled, DAPM has
the device go in and out of the low power /SHDN\ state, and the old
register values are retained. Without this, we would need to specify
that the PMIC power cycle the chip.



 
