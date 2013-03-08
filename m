From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Add codec driver for AK5386
Date: Fri, 8 Mar 2013 19:51:39 +0800
Message-ID: <20130308115137.GG28481@opensource.wolfsonmicro.com>
References: <1362740848-15752-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0067345079776451092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE6B52616FE
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 12:52:08 +0100 (CET)
In-Reply-To: <1362740848-15752-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0067345079776451092==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 12:07:28PM +0100, Daniel Mack wrote:
> Adds a driver for Asahi Kasei's AK5386 Single-ended 24-Bit 192kHz
> delta-sigma ADC. The device has no control port interface but an
> optional RESET/PDN GPIO pin.

Applied, thanks.  One possible update...

> +	/*
> +	 * From the datasheet:
> +	 *
> +	 * All external clocks (MCLK, SCLK and LRCK) must be present unless
> +	 * PDN pin =3D =E2=80=9CL=E2=80=9D. If these clocks are not provided, t=
he AK5386 may
> +	 * draw excess current due to its use of internal dynamically
> +	 * refreshed logic. If the external clocks are not present, place
> +	 * the AK5386 in power-down mode (PDN pin =3D =E2=80=9CL=E2=80=9D).
> +	 */
> +
> +	if (gpio_is_valid(priv->reset_gpio))
> +		gpio_set_value(priv->reset_gpio, 1);

I think that mute_stream() which was recently added and I mentioned in
my review of your previous patch would do what you want here
idiomatically - the effect is about the same as a mute and it should be
called bat the right moments.

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROdDBAAoJELSic+t+oim9vJoQAI4PWk8cL2f/LxStYV0+Obfb
91iD0m7iLGtTIGcSEyOWXQaSIyu/Z+Vu0djigDe1cPi30DL5SnpnH4XlE69MM85g
rkMgimbGOXP4bi2ob7H402k4X9wfP0y0X+mBRnb0xgt6/XX1Nt984yABbLFEvWHY
M5tq2N2L9eZjRcSAEyAnF5nCOPH67OuTwy3wlxk0K4BvPgCHyRfIcGhFtYJynMVB
HpY2KWwjozKMJxt70zEYth/SikbWeZRQGzEhKhKCJvRrjVZGUNQzSGDxePg59nnk
CHvuA1P/BhYVjvfsG7tVGsS2x+njQzBs9M8am+mDL0Si44oi82p9CR6L090gSsLp
GQOCH/cwV+gDmLINyB89sPvfPUeKrO24oOBzmAicbsb6hCSJJ3C7RkBA8cZpYskB
6MF6zq8zdTVMuh5VJzlTD3/UgKm9FtsXvPGb0dKJENvbVsWa0bvg/oNiF36OVCpv
JDNvc4MHqfrUcgOvxqkrrk3IQ96PtFPViRST/o6ExfzH5R7MvLtYFafNL3sC+++L
SmaWi6ilrPGubSlfdkBNuEkrN34dSCgMLlPyzTzWHxjfhALStNRZQ4bfr/qb/8Xo
H3FPvtclwUaqfwXX73E362+a6C8ZNY53rtfZdpKXDTjC6BgD/tZLRT4ZbuE0wqw3
twvmEZ1k0BzF62CjhWgO
=iIbF
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--

--===============0067345079776451092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0067345079776451092==--
