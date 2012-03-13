From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 12/16] ASoC: Ux500: Add MSP I2S-driver
Date: Tue, 13 Mar 2012 22:11:17 +0000
Message-ID: <20120313221116.GI3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-13-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3909499831350905219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D368E103D39
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 23:11:20 +0100 (CET)
In-Reply-To: <1331651503-16917-13-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3909499831350905219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:39PM +0100, Ola Lilja wrote:

> +menuconfig SND_SOC_UX500
> +	bool "SoC Audio support for Ux500 platform"
> +	depends on SND_SOC
> +	default n

This is redundant, the default default is n.

> +config SND_SOC_UX500_MSP_I2S
> +	bool "Platform - MSP (I2S)"
> +	depends on SND_SOC_UX500
> +	default n
> +	help
> +
> +		Say Y if you want to enable the Ux500 MSP I2S-driver.

Don't do this, the driver is only usable with a machine driver so should
be selected by the machine driver.

> +config SND_SOC_UX500_DEBUG
> +	bool "Activate Ux500 platform debug-mode (pr_debug)"
> +	depends on SND_SOC_UX500
> +	default n
> +	help
> +		Say Y if you want to enable debug-level prints for Ux500 code-files.

No.

> +ifdef CONFIG_SND_SOC_UX500_MSP_I2S
> +snd-soc-ux500-platform-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
> +obj-$(CONFIG_SND_SOC_UX500_MSP_I2S) += snd-soc-ux500-platform-i2s.o
> +endif

Do this idiomatically please.  If you need to do use this odd method the
code should explain why.

> +#define to_i2s_controller(d) container_of(d, struct i2s_controller, dev)

Use a function please for type safety (static inline should work out
about the same in terms of the generated code).

> +/*** Protocols ***/
> +enum msp_protocol {
> +	MSP_I2S_PROTOCOL,
> +	MSP_PCM_PROTOCOL,
> +	MSP_PCM_COMPAND_PROTOCOL,
> +	MSP_AC97_PROTOCOL,
> +	MSP_MASTER_SPI_PROTOCOL,
> +	MSP_SLAVE_SPI_PROTOCOL,
> +	MSP_INVALID_PROTOCOL
> +};

Does some of this code want to be in a library somewhere so the hardware
support can be shared with the SPI subsystem?  In general there's a
pretty enormous abstraction layer in here which probably isn't doing all
that much if this stuff is internal to the audio subsystem - my overall
feeling reading the code is that the abstraction layer should be removed
as it's internal to this driver.

> +static struct ux500_platform_drvdata platform_drvdata[UX500_NBR_OF_DAI] = {
> +	{
> +		.msp_i2s_drvdata = NULL,
> +		.fmt = 0,
> +		.slots = 1,
> +		.tx_mask = 0x01,
> +		.rx_mask = 0x01,
> +		.slot_width = 16,
> +		.playback_active = false,
> +		.capture_active = false,
> +		.configured = 0,
> +		.master_clk = UX500_MSP_INTERNAL_CLOCK_FREQ,
> +	},

This looks like it should be dynamically created by the platform
device, not a static struct.

> +static const char *stream_str(struct snd_pcm_substream *substream)
> +{
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		return "Playback";
> +	else
> +		return "Capture";
> +}

Don't add generic code in drivers.

> +	if (mode_playback)
> +		drvdata->playback_active = true;
> +	else
> +		drvdata->capture_active = true;

All this mode_playback stuff is non-idiomatic.

> +static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
> +	bool mode_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
> +
> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
> +		stream_str(substream));
> +
> +	if (drvdata == NULL)
> +		return;

Why might that happen?

> +	prot_desc->total_clocks_for_one_frame =
> +			prot_desc->frame_period+1;
> +
> +	dev_dbg(dai->dev, "%s: Total clocks per frame: %u\n",
> +		__func__,
> +		prot_desc->total_clocks_for_one_frame);

This looks like your clock calculation stuff may be replicating
framework features.

> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	default:
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +
> +	case SND_SOC_DAIFMT_NB_IF:
> +		msp_config->tx_frame_sync_pol ^= 1 << TFSPOL_SHIFT;
> +		msp_config->rx_frame_sync_pol ^= 1 << RFSPOL_SHIFT;
> +		break;
> +	}

Shold be returning an error for unsupported modes.

> +	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM) {
> +		dev_dbg(dai->dev, "%s: Codec is MASTER.\n",

This should be a switch statement and again should error out on
unsupporetd modes.  Use of if statements instead of switch statements
happens elsewhere too.

> +	/* To avoid division by zero in I2S-driver (i2s_setup) */
> +	prot_desc->total_clocks_for_one_frame = 1;


Also many_of_these_variable_names_are_getting_so_long_it_is_hard_to_use_them_without_word_wrapping

> +	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
> +		dev_dbg(dai->dev, "%s: SND_SOC_DAIFMT_I2S.\n",
> +			__func__);

In general if you find this logging useful I'd add it to the framework;
perhaps other people will too and it'll save everyone open coding it.

> +
> +		msp_config->default_protocol_desc = 1;
> +		msp_config->protocol = MSP_I2S_PROTOCOL;
> +		break;
> +
> +	default:
> +	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:

Are you *positive* that all modes you don't explicitly support are
identical to _I2S | _CBM_CFM?

> +	/* If already configured -> not errors reported */
> +	if (mode_playback) {
> +		if ((drvdata->configured & PLAYBACK_CONFIGURED) &&
> +			(drvdata->playback_active))
> +			goto cleanup;
> +	} else {
> +		if ((drvdata->configured & CAPTURE_CONFIGURED) &&
> +			(drvdata->capture_active))
> +			goto cleanup;
> +	}

This looks suspicious...  why are you doing this?

> +			dev_err(dai->dev, "%s: Error: PCM TDM format requires channels "
> +				"to match active slots "
> +				"(channels = %d, active slots = %d)!\n",
> +				__func__, params_channels(params), slots_active);

Don't split error messages over multiple lines, it makes them hard to
search for.

> +	if (!(slots == 1 || slots == 2 || slots == 8 || slots == 16)) {
> +		dev_err(dai->dev, "%s: Error: Unsupported slots (%d)! "
> +			"Supported values are 1/2/8/16.\n",
> +			__func__, slots);
> +		return -EINVAL;
> +	}

This looks like a switch statement....

> +	switch (slots) {
> +	default:
> +	case 1:
> +		cap = 0x01;
> +		break;
> +	case 2:
> +		cap = 0x03;
> +		break;
> +	case 8:
> +		cap = 0xFF;
> +		break;
> +	case 16:
> +		cap = 0xFFFF;
> +		break;
> +	}

...in fact it could be combined with this one.

> +static int ux500_msp_dai_trigger(struct snd_pcm_substream *substream,
> +				int cmd, struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
> +
> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter (msp->id = %d, cmd = %d).\n",
> +		__func__, dai->id, stream_str(substream),
> +		(int)drvdata->msp_i2s_drvdata->id, cmd);
> +
> +	ret = ux500_msp_i2s_trigger(drvdata->msp_i2s_drvdata, cmd, substream->stream);
> +
> +	return ret;
> +}

This function does nothing, just inline the function you're calling.

> +		.suspend = NULL,
> +		.resume = NULL,

No need to assign nonexistant ops like this.

> +		.ops = (struct snd_soc_dai_ops[]) {
> +			{
> +			.set_sysclk = ux500_msp_dai_set_dai_sysclk,
> +			.set_fmt = ux500_msp_dai_set_dai_fmt,
> +			.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
> +			.startup = ux500_msp_dai_startup,
> +			.shutdown = ux500_msp_dai_shutdown,
> +			.prepare = ux500_msp_dai_prepare,
> +			.trigger = ux500_msp_dai_trigger,
> +			.hw_params = ux500_msp_dai_hw_params,
> +			}

Just declare the struct as a variable, if you need casts like this
something is going wrong and doing this will prevent sharing the ops
struct between the DAIs which is the whole point.

> +EXPORT_SYMBOL(ux500_msp_dai_drv);

Why are you doing this?

> +	dev_err(&pdev->dev, "%s: Enter (pdev->name = %s).\n", __func__, pdev->name);

Remove stuff like this, it's not an error.  You've got lots of logging
that should at most be at dev_dbg() level.

> +	platform_data = (struct msp_i2s_platform_data *)pdev->dev.platform_data;

Why not just inline this function?

> +	msp_i2s_drvdata = ux500_msp_i2s_init(pdev, platform_data);
> +	if (!msp_i2s_drvdata) {
> +		dev_err(&pdev->dev, "%s: ERROR: ux500_msp_i2s_init failed!", __func__);
> +		return -1;
> +	}

Are you sure that -EPERM is the best error code?  If you are then you
should use the constant not the number.

> +	dev_info(&pdev->dev, "%s: Registering ux500-msp-dai SoC CPU-DAI.\n", __func__);

For things like this the core will already log for you.

> +int ux500_msp_drv_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata = dev_get_drvdata(&pdev->dev);
> +
> +	dev_dbg(&pdev->dev, "%s: Enter (pdev->name = %s).\n", __func__, pdev->name);
> +
> +	return ux500_msp_i2s_suspend(msp_i2s_drvdata);

Once again, this function does nothing and should just have the contents
inline.  This should also be done from the ASoC level callbacks so that
it's joined up with the suspend of the audio subsystem as a whole.

> +static struct platform_driver msp_i2s_driver = {
> +	.driver = {
> +		.name = "ux500-msp-i2s",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = ux500_msp_drv_probe,
> +	.remove = ux500_msp_drv_remove,

It looks like this just registers one device for all the ports in the
system.  Are all the ports really part of one IP or should the driver be
controlling a single port and letting the SoC instantiate whatever is
present on a given chip?

> +static int __init ux500_msp_init(void)

module_platform_driver.

> +#ifndef CONFIG_SND_SOC_UX500_AB5500
> +#define UX500_MSP_INTERNAL_CLOCK_FREQ  40000000
> +#define UX500_MSP1_INTERNAL_CLOCK_FREQ UX500_MSP_INTERNAL_CLOCK_FREQ
> +#else
> +#define UX500_MSP_INTERNAL_CLOCK_FREQ 13000000
> +#define UX500_MSP1_INTERNAL_CLOCK_FREQ (UX500_MSP_INTERNAL_CLOCK_FREQ * 2)
> +#endif

This should probably be coming out of the clock framework.

> +int ux500_msp_dai_set_data_delay(struct snd_soc_dai *dai, int delay);

What is this?

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX8X9AAoJEBus8iNuMP3dniwP/2wpZoZch9Z+e2d61hMHDsq6
avfVW7VdOozOT3yMSOrQg3sfGjQRJO/qbCORWtQZg2XLeS/OWisDvwFYcLYGYUMI
ERO8JzjwT9erreDKY6ZD60zGTJ4F8SGyg/LfrMAqiEzhz0yjtpchWKwqlQw+pXL9
ziXEFunbPPXLsRx/8g21dcThkq+ZR95rJglzFeN26ixPvgqOEkFp3F8fNXK7Qo5d
sysMAG2po0XXlZeeFyMbU9OBrzMuV9WGmmXsG8ZZGskAIYnFOHG+WwgJqRiku/bl
KYXSZNg6r6f7H7gOAX/ZxyCNlhoUbA/CeMMOjAyAONuOHiqY3v465nRH0makFWlb
74is2VyhMD1ZaiKG8UxYQopMUgTOgcb2YU3WBdnobbLXnvE/8uFC4cDi6CW2Op/g
JoTh7xn1lGdsHyf81i+WayYaYEoelqXNnd8mTMN/1E9FjOhNzU5o84KGEbiOCeXW
DHMCrzeb5QbxFkgUiMxU679ZrzSvmOQrCgR/XChwqUJajX2aBDPZS26pdMhyyVwN
OaYA9HJOWD5bUZA6I0uafriO+oybiDF3FXase52KswsxP8HIz2Wpkq9kt9w0eAqm
r7GYjOKHFr98Hu+qhFepsSkG+u5ckiEhdCFib+qIj6zBUABKuGYyWhuR4VzgBIo9
qlGH2ITuWmlKX9bNU2xt
=pLUN
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--

--===============3909499831350905219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3909499831350905219==--
