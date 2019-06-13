From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/4] ASoC: Add codec driver for ST
	TDA7802
Date: Thu, 13 Jun 2019 19:34:37 +0100
Message-ID: <20190613183437.GR5316@sirena.org.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-3-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7554716403821106252=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA776F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 20:34:41 +0200 (CEST)
In-Reply-To: <20190611174909.12162-3-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Marco Felsch <m.felsch@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7554716403821106252==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
Content-Disposition: inline


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2019 at 06:49:07PM +0100, Thomas Preston wrote:

> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,580 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802
> + *

Make the entire comment a C++ one so this looks more intentional.

> + * Copyright (C) 2016-2019 Tesla Motors, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.

You've got a SPDX header, you don't also need GPL boilerplate (this
doesn't match your SPDX header either...).

> +enum tda7802_type {
> +	tda7802_base,
> +};
> +
> +#define I2C_BUS				   4
> +
> +#define CHANNELS_PER_AMP		   4
> +#define MAX_NUM_AMPS			   4
> +

These are concerning but also unused.

> +
> +static const u8 IB3_FORMAT[4][4] = {
> +	/* 1x amp, 4 channels */
> +	{ IB3_FORMAT_TDM4 },
> +	/* 2x amp, 8 channels */
> +	{ IB3_FORMAT_TDM8_DEV1,
> +		IB3_FORMAT_TDM8_DEV2 },
> +	/* 3x amp not supported */
> +	{ },
> +	/* 4x amp, 16 channels */
> +	{ IB3_FORMAT_TDM16_DEV1,
> +		IB3_FORMAT_TDM16_DEV2,
> +		IB3_FORMAT_TDM16_DEV3,
> +		IB3_FORMAT_TDM16_DEV4 },
> +};

There are indentation issues here and this is also rather magic
numberish.  I *think* you should be implement set_tdm_slot().

> +#ifdef DEBUG
> +static int tda7802_dump_regs(struct tda7802_priv *tda7802)
> +{

There's already facilities for viewing the register map in regmap, no
need to open code anything.

> +	/* All channels out of tri-state mode, all channels in Standard Class
> +	 * AB mode (not High-efficiency)
> +	 */
> +	data[0] = IB0_CH4_CLASS_AB | IB0_CH3_CLASS_AB | IB0_CH2_CLASS_AB |
> +		IB0_CH1_CLASS_AB;

The AB mode selection should be a user visible control not hard coded.

> +	/* Rear channel load impedance set to 2-Ohm, default diagnostic timing,
> +	 * GV1 gain on all channels (default), no digital gain increase
> +	 */
> +	data[1] = IB1_REAR_IMPEDANCE_2_OHM | IB1_LONG_DIAG_TIMING_x1;
> +	switch (tda7802->gain_ch13) {

The impedance should be a DT property, the gains should be user
controllable.

> +	case 2:
> +		data[1] |= IB1_GAIN_CH13_GV2;
> +		break;
> +	default:
> +		dev_err(dev, "Unknown gain for channel 1,3 %d, setting to 1\n",
> +				tda7802->gain_ch13);
> +	case 1:
> +		data[1] |= IB1_GAIN_CH13_GV1;
> +		break;

It would be more normal to have the default case as the last thing in the
switch statement and the fall through is obviously a bug, if the driver
doesn't know how to handle the configuration it should return an error.

> +	}
> +	switch (tda7802->gain_ch24) {

Blank line please.

> +	/* Mute timing 1.45ms, all channels un-muted, digital mute enabled,
> +	 * 5.3V undervoltage threshold, front-channel load impedance set to
> +	 * 2-Ohms
> +	 */
> +	data[2] = IB2_MUTE_TIME_1_MS | IB2_CH13_UNMUTED | IB2_CH24_UNMUTED |
> +		IB2_AUTOMUTE_THRESHOLD_5V3 | IB2_FRONT_IMPEDANCE_2_OHM;

More stuff that shouldn't be hard coded in the driver.

> +	if (mute) {
> +		/* digital mute */
> +		err = snd_soc_component_update_bits(dai->component, TDA7802_IB2,
> +				IB2_DIGITAL_MUTE_DISABLED,
> +				~IB2_DIGITAL_MUTE_DISABLED);
> +		if (err < 0)
> +			dev_err(dev, "Cannot mute amp %d\n", err);
> +
> +		/* amp off */
> +		err = snd_soc_component_update_bits(dai->component, TDA7802_IB5,
> +				IB5_AMPLIFIER_ON, ~IB5_AMPLIFIER_ON);
> +		if (err < 0)
> +			dev_err(dev, "Cannot amp off %d\n", err);

Turning off the amplifier is clearly power management and should be
handled via DAPM.

> +static int tda7802_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +		unsigned int rx_mask, int slots, int slot_width)
> +{

> +	/* 48kHz sample rate, TDM configuration, 64-bit I2S frame period, PLL
> +	 * clock dither disabled, high-pass filter enabled (blocks DC output)
> +	 */
> +	data = IB3_SAMPLE_RATE_48_KHZ | IB3_FORMAT[width_index][slot_index] |

The sample rate should be set using hw_params(), the high pass filter
should be controllable via a control.

I've stopped reading here, it's fairly clear from what I've seen up to
here that the code is not well integrated with the framework with lots
of hard coding and things scattered around in places where I'd not
expect to find them.  A lot of things should be moved out of hard coding
into ALSA controls, stream configuration should be done via hw_params()
and power management via DAPM - the hardware looks fairly simple so I'd
expect this to all be fairly straightforward to fix.

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0ClzwACgkQJNaLcl1U
h9BtgQf8DNS5KLuTfx8tNHKf3DBEY6J98cBVTbxdBjEHzKG43Ef9yHG4x7REfX9S
2eU1lWSrvrbb6t5UgU8vdAOziNr4Bm1wd1IS47Uys0JGLGMQZjPb4DKz8AswNrof
tc4yS6PyJp3dWfWTBfJUDbyPI0B4xLYjINGO/frdkl4mzMt/awV+rW9r4ijX/dDp
hTq1cnUKc9DMCj+lPFVW3D20V2/yOVMk9Wzk9nq1cd5000MdYNNRWD/GODyPYPz/
b/pDRiY1noNc0X76ftfIy7P45YWcxFmzmaxKq1NdeAPVeCppTU527An12euP/9X+
6rq81oS3Dinzi+6gCSHqGnEl7AqL5A==
=iGaS
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--

--===============7554716403821106252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7554716403821106252==--
