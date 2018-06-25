From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
	support
Date: Mon, 25 Jun 2018 12:21:44 +0100
Message-ID: <20180625112144.GB9413@sirena.org.uk>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7895185686822350756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ECC52676D8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:21:47 +0200 (CEST)
In-Reply-To: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7895185686822350756==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 01:06:16PM +0200, Nicol=F2 Veronese wrote:
> Many boards have speaker amplifier attached on an analog output.
> Most of them are only managed by a mute or shutdown GPIO.
> In order to reduce duplicate driver, this patch adds generic/simple-ampli=
fier.

Copying in Hans who has a machine that needs something like this, not
deleting context for his benefit.

This looks good to me, one coding style thing below but otherwise the
main thing I'm thinking is that we might want to add a mono channel as
well for simplicity when wiring up a system using a mono amplifier.
That could always be done later though.

>=20
> Signed-off-by: Nicol=F2 Veronese <nicveronese@gmail.com>
> ---
>  sound/soc/generic/Kconfig            |   5 ++
>  sound/soc/generic/Makefile           |   2 +
>  sound/soc/generic/simple-amplifier.c | 109 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 sound/soc/generic/simple-amplifier.c
>=20
> diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
> index c954be0..ace17c3a 100644
> --- a/sound/soc/generic/Kconfig
> +++ b/sound/soc/generic/Kconfig
> @@ -7,6 +7,11 @@ config SND_SIMPLE_CARD
>  	help
>  	  This option enables generic simple sound card support
> =20
> +config SND_SIMPLE_AMPLIFIER
> +	tristate "ASoC Simple Amplifier support"
> +	help
> +	  This option enables generic simple amplifier support
> +
>  config SND_SIMPLE_SCU_CARD
>  	tristate "ASoC Simple SCU sound card support"
>  	depends on OF
> diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
> index 9dec293..805a746 100644
> --- a/sound/soc/generic/Makefile
> +++ b/sound/soc/generic/Makefile
> @@ -1,12 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
>  snd-soc-simple-card-utils-objs	:=3D simple-card-utils.o
>  snd-soc-simple-card-objs	:=3D simple-card.o
> +snd-soc-simple-amplifier-objs		:=3D simple-amplifier.o
>  snd-soc-simple-scu-card-objs	:=3D simple-scu-card.o
>  snd-soc-audio-graph-card-objs	:=3D audio-graph-card.o
>  snd-soc-audio-graph-scu-card-objs	:=3D audio-graph-scu-card.o
> =20
>  obj-$(CONFIG_SND_SIMPLE_CARD_UTILS)	+=3D snd-soc-simple-card-utils.o
>  obj-$(CONFIG_SND_SIMPLE_CARD)		+=3D snd-soc-simple-card.o
> +obj-$(CONFIG_SND_SIMPLE_AMPLIFIER)		+=3D snd-soc-simple-amplifier.o
>  obj-$(CONFIG_SND_SIMPLE_SCU_CARD)	+=3D snd-soc-simple-scu-card.o
>  obj-$(CONFIG_SND_AUDIO_GRAPH_CARD)	+=3D snd-soc-audio-graph-card.o
>  obj-$(CONFIG_SND_AUDIO_GRAPH_SCU_CARD)	+=3D snd-soc-audio-graph-scu-card=
=2Eo
> diff --git a/sound/soc/generic/simple-amplifier.c b/sound/soc/generic/sim=
ple-amplifier.c
> new file mode 100644
> index 0000000..e135a43
> --- /dev/null
> +++ b/sound/soc/generic/simple-amplifier.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// ALSA SoC simple amplifier driver
> +//
> +// Copyright 2018
> +// Author:  Nicol=F2 Veronese <nicveronese@gmail.com>
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +/* This struct is used to save the context */
> +struct simple_amp_data {
> +	struct device *dev;
> +	struct regmap *regmap;

You don't need a regmap here.

> +	struct gpio_desc *power_gpio;
> +};
> +
> +static int simple_amp_power_event(struct snd_soc_dapm_widget *widget,
> +				 struct snd_kcontrol *kctrl, int event)
> +{
> +	struct snd_soc_component *c =3D snd_soc_dapm_to_component(widget->dapm);
> +	struct simple_amp_data *data =3D snd_soc_component_get_drvdata(c);
> +
> +	/* Shutdown GPIO */
> +    if (data->power_gpio)
> +        gpiod_set_value_cansleep(data->power_gpio, SND_SOC_DAPM_EVENT_ON=
(event));
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget simple_amp_dapm_widgets[] =3D {
> +	SND_SOC_DAPM_INPUT("LEFT AMP IN"),
> +	SND_SOC_DAPM_INPUT("RIGHT AMP IN"),
> +
> +	SND_SOC_DAPM_OUTPUT("SPK LEFT"),
> +	SND_SOC_DAPM_OUTPUT("SPK RIGHT"),
> +
> +	SND_SOC_DAPM_REGULATOR_SUPPLY("VCC", 20, 0),
> +	SND_SOC_DAPM_SPK("MUTE", simple_amp_power_event),
> +};
> +
> +static const struct snd_soc_dapm_route simple_amp_dapm_routes[] =3D {
> +	{ "MUTE", NULL, "LEFT AMP IN" },
> +	{ "MUTE", NULL, "RIGHT AMP IN" },
> +
> +	{ "SPK LEFT", NULL, "VCC" },
> +	{ "SPK RIGHT", NULL, "VCC" },
> +
> +	{ "SPK LEFT", NULL, "MUTE" },
> +	{ "SPK RIGHT", NULL, "MUTE" },
> +};
> +
> +static const struct snd_soc_component_driver simple_amp_component_driver=
 =3D {
> +	.name =3D "simple-amplifier",
> +	.dapm_widgets =3D simple_amp_dapm_widgets,
> +	.num_dapm_widgets =3D ARRAY_SIZE(simple_amp_dapm_widgets),
> +	.dapm_routes =3D simple_amp_dapm_routes,
> +	.num_dapm_routes =3D ARRAY_SIZE(simple_amp_dapm_routes),
> +};
> +
> +static int asoc_simple_amp_probe(struct platform_device *pdev)
> +{
> +	struct simple_amp_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, data);
> +
> +	if(of_property_read_bool(pdev->dev.of_node,"shutdown-gpios")) {

Coding style: should be if (

> +		data->power_gpio =3D devm_gpiod_get_optional(&pdev->dev, "shutdown", G=
PIOD_OUT_LOW);
> +
> +		if (IS_ERR(data->power_gpio)) {
> +			ret =3D PTR_ERR(data->power_gpio);
> +			dev_err(&pdev->dev, "Failed to get shutdown gpio: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return devm_snd_soc_register_component(dev,
> +			&simple_amp_component_driver, NULL, 0);
> +}
> +
> +static const struct of_device_id asoc_simple_of_match[] =3D {
> +	{ .compatible =3D "simple-audio-amplifier", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
> +
> +static struct platform_driver asoc_simple_amp =3D {
> +	.driver =3D {
> +		.name =3D "asoc-simple-amplifier",
> +		.of_match_table =3D of_match_ptr(asoc_simple_of_match),
> +	},
> +	.probe =3D asoc_simple_amp_probe,
> +};
> +
> +module_platform_driver(asoc_simple_amp);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ASoC Simple Amplifier");
> +MODULE_AUTHOR("Nicol=F2 Veronese <nicveronese@gmail.com>");
> --=20
> 2.7.4
>=20

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw0EgACgkQJNaLcl1U
h9Cwhgf+KMApQgs16jYozz5h7pIZqyTOR9OuXfOKiUJRIn0dY0ji1kFe+5UQyFQH
rBrjAiI3qO+vM1F+4nHWu6PC49DWQCpaStOY7U6/f5rEOFBh6r+za/ybwrkhrUer
QAez2I7ARJgSAybjo+27mdiqt8XXB2p7i+LF8lTKopFSEcq+MKUpo/kCk1Bot+VB
nIrStCjPHRqJprXXPJGHjl4S9ZnE530LgOJB3zXNpn3spsqONGZLplCZDglzT/Qm
yRcEThDh4P7TOu+DGTWMb1s04C6xuOhI8mwsZT2wADl+Fd2w51WeTr3Jr9ALKqFk
/Kp5oFJK2j4VFJDfZIgAVsMsQUjjJg==
=ahSh
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--===============7895185686822350756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7895185686822350756==--
