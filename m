From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 10:39:13 +0800
Message-ID: <20140225023912.GC7229@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <530B8741.3010302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <530B8741.3010302@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: broonie@kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-doc@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 24, 2014 at 06:54:09PM +0100, Lars-Peter Clausen wrote:
> Hi,
> 
> Couple of trivial things.

Will fix them all.

Thanks a lot,
Nicolin Chen

> 
> On 02/24/2014 07:55 AM, Nicolin Chen wrote:
> [...]
> >+config SND_SOC_CS42888
> >+	tristate "Cirrus Logic CS42888 CODEC"
> >+	depends on I2C
> 
> should select REGMAP_I2C
> 
> >+
> [...]
> >+#define CS42888_NUM_SUPPLIES 4
> >+static const char *cs42888_supply_names[CS42888_NUM_SUPPLIES] = {
> 
> const char *const
> 
> >+	"VA",
> >+	"VD",
> >+	"VLS",
> >+	"VLC",
> >+};
> >+
> >+static const char *cs42888_adc_single[] = { "Differential", "Single-Ended" };
> 
> const char * const
> 
> >+static const char *cs42888_szc[] = { "Immediate Change", "Zero Cross",
> >+				     "Soft Ramp", "Soft Ramp on Zero Cross" };
> >+
> 
> const char * constr
> 
> >+static const struct soc_enum cs42888_enum[] = {
> >+	SOC_ENUM_SINGLE(CS42888_ADCCTL, 4, 2, cs42888_adc_single),
> >+	SOC_ENUM_SINGLE(CS42888_ADCCTL, 3, 2, cs42888_adc_single),
> >+	SOC_ENUM_SINGLE(CS42888_TXCTL, 5, 4, cs42888_szc),
> >+	SOC_ENUM_SINGLE(CS42888_TXCTL, 0, 4, cs42888_szc),
> >+};
> 
> Usually it makes things a bit more clearer when you have a variable
> with a unique name for each enum rather then putting them into one
> large array.
> 
> >+
> [...]
> >+static struct cs42888_ratios cs42888_ratios[] = {
> 
> const
> 
> [...]
> >+static struct snd_soc_dai_ops cs42888_dai_ops = {
> 
> const
> 
> >+	.set_fmt	= cs42888_set_dai_fmt,
> >+	.set_sysclk	= cs42888_set_dai_sysclk,
> >+	.hw_params	= cs42888_hw_params,
> >+	.digital_mute	= cs42888_digital_mute,
> >+};
> >+
> [...]
> >+
> >+static struct reg_default cs42888_reg[] = {
> 
> const
> [...]
> >+
> >+static struct snd_soc_codec_driver cs42888_driver = {
> 
> const
> 
> >+	.probe = cs42888_probe,
> >+	.idle_bias_off = true,
> >+
> >+	.controls = cs42888_snd_controls,
> >+	.num_controls = ARRAY_SIZE(cs42888_snd_controls),
> >+	.dapm_widgets = cs42888_dapm_widgets,
> >+	.num_dapm_widgets = ARRAY_SIZE(cs42888_dapm_widgets),
> >+	.dapm_routes = cs42888_dapm_routes,
> >+	.num_dapm_routes = ARRAY_SIZE(cs42888_dapm_routes),
> >+};
> >+
> 
> 
> 


