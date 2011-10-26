From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] v2: ASoC: Add new Realtek ALC5632 CODEC
	driver.
Date: Wed, 26 Oct 2011 15:51:15 +0100
Message-ID: <20111026145115.GA9359@opensource.wolfsonmicro.com>
References: <1319579778-21850-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A981B249BB
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 16:51:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319579778-21850-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 25, 2011 at 11:56:18PM +0200, Leon Romanovsky wrote:
> This driver implements basic functionality, using I=B2C for the control c=
hannel.
> =

> Signed-off-by: Leon Romanovsky <leon@leon.nu>

This looks good overall, much better than the out of tree driver you
pointed me at the other day!  A couple of fairly minor points below,
basically style issues.

>  	select SND_SOC_AK4642 if I2C
>  	select SND_SOC_AK4671 if I2C
>  	select SND_SOC_ALC5623 if I2C
> +    select SND_SOC_ALC5632 if I2C
>  	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
>  	select SND_SOC_CS42L51 if I2C

Think there's a tab/space issue here.

> +/* #define DEBUG */

Better to drop this but it's very minor either way.

> +#define ALC5632_VERSION	"0.1"

Drop the version number from the driver - once it's in manline git and
the kernel versioning are enough, these versions never get updated
anyway.

> +static int caps_charge =3D 2000;
> +module_param(caps_charge, int, 0);
> +MODULE_PARM_DESC(caps_charge, "ALC5632 cap charge time (msecs)");

Ouch!

> +SND_SOC_DAPM_MICBIAS("Mic Bias1", ALC5632_PWR_MANAG_ADD1, 3, 0),
> +SND_SOC_DAPM_MICBIAS("Mic Bias2", ALC5632_PWR_MANAG_ADD1, 2, 0),

It's better to convert these to _SUPPLY() widgets - since the
introduction of supplies there's really no need for the MICBIAS widgets
and supplies are much easier to hook up in the boards.  We really ought
to go through and convert as many drivers to this model.

> +/* choose MCLK/BCLK/VBCLK */
> +	snd_soc_write(codec, ALC5632_GPCR2, gbl_clk);

Indent the comments with the code please.

> +#define ALC5632_ADD1_POWER_EN \
> +		(ALC5632_PWR_ADD1_SPK_AMP_EN \
> +		| ALC5632_PWR_ADD1_DAC_REF \
> +		| ALC5632_PWR_ADD1_DAC_L_EN \
> +		| ALC5632_PWR_ADD1_DAC_R_EN \
> +		| ALC5632_PWR_ADD1_SOFTGEN_EN \
> +		| ALC5632_PWR_ADD1_MAIN_I2S_EN \
> +		| ALC5632_PWR_ADD1_HP_OUT_AMP \
> +		| ALC5632_PWR_ADD1_HP_OUT_ENH_AMP \
> +		| ALC5632_PWR_ADD1_MAIN_BIAS)

This looks like it ought to go into DAPM but looking at the pop/click
sequence you have I suspect that might not work so well.

> +static struct snd_soc_dai_driver alc5632_dai =3D {
> +	.name =3D "alc5632-hifi",
> +	.playback =3D {

Based on the code above it looks like the same clock configuration is
used for playback and record so I expect you need to set the
symmetric_rates flags so that we don't get people trying to set
different rates for playback and capture which would mean that the first
one to get started would get disrupted.

> +
> +	/* Sync reg_cache with the hardware */
> +	for (i =3D 2 ; i < codec->driver->reg_cache_size ; i +=3D step)
> +		snd_soc_write(codec, i, cache[i]);

snd_soc_cache_sync().

> +	if (codec->dapm.suspend_bias_level =3D=3D SND_SOC_BIAS_ON) {
> +		alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +		codec->dapm.bias_level =3D SND_SOC_BIAS_ON;
> +		alc5632_set_bias_level(codec, codec->dapm.bias_level);
> +	}

This isn't needed, you'll never be in a state above _STANDBY before you
go into suspend so it'll never actually get run.

> +	/* spk amp pwr enable 3A | 0x0400 @ 3A */
> +	snd_soc_update_bits(codec, ALC5632_PWR_MANAG_ADD1,
> +		0, ALC5632_PWR_ADD1_SPK_AMP_EN);

Should this be in DAPM?

> +	/* enable slave mode 0x8000 @ 34 */
> +	snd_soc_write(codec, ALC5632_DAI_CONTROL, ALC5632_DAI_SDP_SLAVE_MODE);

Just leave this at default and let the machine driver configure the
chip.

> +	snd_soc_add_controls(codec, alc5632_snd_controls,
> +			ARRAY_SIZE(alc5632_snd_controls));
> +
> +	snd_soc_dapm_new_controls(dapm, alc5632_dapm_widgets,
> +					ARRAY_SIZE(alc5632_dapm_widgets));
> +
> +	/* set up audio path interconnects */
> +	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));

New code should just point to the tables from the codec driver structure
and let the core do these calls.

> +	dev_dbg(&client->dev, "in i2c probe...\n");

Drop this stuff for mainline.

> +	alc5632 =3D kzalloc(sizeof(struct alc5632_priv), GFP_KERNEL);
> +	if (alc5632 =3D=3D NULL)
> +		return -ENOMEM;

Use devm_kzalloc() for this, device model code will then deal with
calling kfree() for you.
