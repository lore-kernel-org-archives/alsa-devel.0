From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: sh: fsi: add FSI-WM8978 support
Date: Mon, 2 Apr 2012 22:42:33 +0100
Message-ID: <20120402214233.GE3160@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87wr5y9au1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1480069326312789719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6639724365
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 23:42:29 +0200 (CEST)
In-Reply-To: <87wr5y9au1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1480069326312789719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 01, 2012 at 06:33:29PM -0700, Kuninori Morimoto wrote:

> +config SND_FSI_WM8978
> +	tristate "FSI-WM8978 sound support"
> +	depends on SND_SOC_SH4_FSI
> +	select SND_SOC_WM8978
> +        select SND_FSI_CODEC
> +	help
> +	  This option enables generic sound support for the
> +	  FSI - WM8978 unit

Rather than having an explicit Kconfig option like this it might be more
sensible to have the boards select their CODEC driver.  We should only
build the CODEC driver if the user enables the subsystem IIRC so this
shouldn't be a big cost.  You could then just have a single Kconfig for
the simple driver.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPeh04AAoJEBus8iNuMP3dYXgP/0Xv/d0I//rmZMCmGPF9Xt3D
iEH4u93QwZ71njhWS4qnEgF7TSJNqRr5occtTxN80ik0vQakYyFIDVXTgyRadW+5
Z/2cpNOb9ZW0uwWQlNZjRMQhv5ItXJDKRSa77MnJiU8pHEMkR42RmAL8ZtHtYVwk
l3x1hz3JJtjDq9wrA7chTjdzD9kco2cEVC5nxzgRi9mK5XiF0L3H4ZWhbdrVKKna
x6Z7xrTE8YVz3X+GjMxJj6p6VdH8johZF2CMJHFwr4kzEa/U49asHPHQlDJG2VWr
OwNV6KHkMuLNG1jfPFnZllYxLckUbDTC+yktqG8G9muTwephEtH4m13Vz/2S5pZ/
59X/fWo8yQFFejarKCwgXumanokHC8IYfY5Mk4lFR1Com4YT/4OJ3/6PqNxrUvdE
vki4u+2eCQ3gMHYoCJV1eC4QHFbV8pcT6nDWm/3W/atzK0xKcxwCG1P36t5QbLhM
o7YHNXRiaAFwFwjKLVuzcVouNzP1mzdCv3DwgiEA7JL4W7gKRGOPmhOObncL7Ldc
Hp6ZmlQgo2qEvhtQDTvVY0+ou0N4l69DG3V63h/y/VpGs4oVGNZ8fg3vwjd3gsip
r5kvmyKpMhZf0D0Ixg3rzqNctkDcDXMe2OEUlEEhi/I9AN38Vux4H7jbLF3GR5L7
/vxT7BnlOeXfG+xrSyEZ
=7Npd
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============1480069326312789719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1480069326312789719==--
