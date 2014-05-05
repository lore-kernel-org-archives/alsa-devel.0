From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sta350: add support for bits in
 miscellaneous registers
Date: Mon, 5 May 2014 12:55:29 -0700
Message-ID: <20140505195529.GZ22111@sirena.org.uk>
References: <1399283363-16441-1-git-send-email-zonque@gmail.com>
 <1399283363-16441-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0247798308841951082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59C83261B11
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:56:16 +0200 (CEST)
In-Reply-To: <1399283363-16441-2-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0247798308841951082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGwLO2yoW8Ya4hN1"
Content-Disposition: inline


--eGwLO2yoW8Ya4hN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 11:49:23AM +0200, Daniel Mack wrote:
> Add support for RPDNEN, NSHHPEN, BRIDGOFF, CPWMEN and PNDLSL, and add DT
> bindings to access them.

Applied, thanks.  However...

> +  -  st,powerdown-delay-divider:
> +	If present, the bridge power-down time will be divided by the provided
> +	value. If not specified, a divider of 1 will be used. Allowed values
> +	are 1, 2, 4, 8, 16, 32, 64 and 128.
> +	This property has to be specified as '/bits/ 8' value.

There doesn't seem to be a pressing need for this to be specified as
/bits/ 8?  It makes the parsing marginally easier but doesn't seem
entirely helpful for users.

--eGwLO2yoW8Ya4hN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+yuAAoJELSic+t+oim9GRIP/2gOtdXdA1hVP9UaXLI8OVPI
uyjE7wR39LYqFNtNxhVWE7o+Qfht0CrYXGPmIzQivSwfSX5NCC/ovXnf03Vb25vk
mgsTwQc5Q1Pknb7KByMLeB16mjezj8JP2Mh5EgYNVlwv/CQTwOxuhzyQ8cscpfmc
NDcNuVnGXnjbHyuwQ1jVQL+JeOjLu7oEuUyVmLlla3xT5yfUfyIUQie8FleeXnxG
TbZqNdhbDa+vz7x33tQ3RoMKOJ3PMP+OX13ULK5H1qSSZvdmHLFvgh7Rp/PGXvHe
siKvM1sMlyg/NYU3uHMGRXAjye5VZx4QuV2qwjOD8/iqkigcMYCMA/CEr6FkutQ3
1wNNF2gTUQyYufGWpKnsobtQMonbx1EKkDiMvON5OFNpljGfIj0x8+E1HHjZcvuA
/qjsxQa1HNm8Be0+UPBbTA4I35seyaww7xPfS+U0SvJY3dDmx75Kbml0grJlPz2N
U/iuFo8BJjMhICXEEmDOnxy3HBw0mhE0W5ysyDPA0wQdpcZoXJmlkRxbywVIXBUT
d+hnDLdrr6j4JqMxLzENBlprnca08vCV0gV8QtzWKNTZlQz077M466qAk9ID+hAV
M+aDp2DB+XgOOZYw2rGM2i6euhZT5NB7P14gD/ZqCendRj3GtyHjhqqz0oAl++0q
gZQPsdqdqAC4CaRtFTvp
=dAne
-----END PGP SIGNATURE-----

--eGwLO2yoW8Ya4hN1--

--===============0247798308841951082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0247798308841951082==--
