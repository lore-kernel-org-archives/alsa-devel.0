From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
Date: Tue, 13 Nov 2018 14:51:35 -0800
Message-ID: <20181113225135.GQ2089@sirena.org.uk>
References: <20181108124934.32381-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5372483374844399459=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A982677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 23:51:43 +0100 (CET)
In-Reply-To: <20181108124934.32381-1-peron.clem@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Adrien Charruel <adrien.charruel@devialet.com>
List-Id: alsa-devel@alsa-project.org


--===============5372483374844399459==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6hDAtPN9q+ZnUca"
Content-Disposition: inline


--p6hDAtPN9q+ZnUca
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=E9ment P=E9ron wrote:

This looks mostly good, a few small things below but nothing too major:

> --- /dev/null
> +++ b/sound/soc/codecs/ak4118.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> + *

Please make the entire comment a C++ one so this looks more intentional.

> +static const char * const ak4118_iec958_fs_texts[] =3D {
> +	"44100",
> +	"Reserved",

If you use a _VALUE_ENUM_SINGLE you can hide the reserved/invalid values
=66rom userspace which is easier to use.

> +	ret =3D request_threaded_irq(gpiod_to_irq(ak4118->irq), NULL,
> +				   ak4118_irq_handler, IRQF_TRIGGER_RISING |
> +				   IRQF_ONESHOT, "ak4118-irq", ak4118);
> +	if (ret < 0) {
> +		dev_err(component->dev, "Fail to request_irq: %d\n", ret);
> +		return ret;
> +	}

You should request resources in the device level probe, there's no point
in requesting and releasing the interrupt like this.

--p6hDAtPN9q+ZnUca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrVXYACgkQJNaLcl1U
h9DB7wf/W1LooFgqTJgJoHvp4HpuSNxrpd12Sm2ZvqCgQcHcO4XW8JbRSm4gWq14
X9bLYqyv9bqA4ZQYDYsXPwiyC/ogftVkIejGVoijWJixtZQEfwMT3e1yFw3AASpD
p6/3pBml35uKWenFY1hsQB7pYvuh9chBs4L3paUeNhHWW+LXX/uQzbyrkvH9I/3j
7lV935pkIOpzCKBu9DhNRVaom6XjR22w9iBvJiDoOeZtGgSu7WbBWevrfzfUrg8j
wOIVZSlNPA15OBle3Zn+AozwJE1AUuw67vVvL5w1V/5WNNoxpvPtvjZ0sVmL8hSU
KhHpkDUpZyb6F7tQIRe2If8WwYA/zg==
=OxYf
-----END PGP SIGNATURE-----

--p6hDAtPN9q+ZnUca--

--===============5372483374844399459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5372483374844399459==--
