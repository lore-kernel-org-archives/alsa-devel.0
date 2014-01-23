From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH Resend 3/8] ASoC: simple-card: simplify the daifmt code
Date: Thu, 23 Jan 2014 19:20:04 +0000
Message-ID: <20140123192004.GD11727@sirena.org.uk>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-4-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390453370-29194-4-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 01:02:45PM +0800, Xiubo Li wrote:
> In the asoc_simple_card_parse_of() will parse the device node's CPU/CODEC
> DAI commone fmts, and then in asoc_simple_card_sub_parse_of() will parse
> the CPU/CODEC DAI's sub-node fmts, so we can combine the info->daifmt and
> info->set.fmt in asoc_simple_card_sub_parse_of() not while just before
> _set_fmt().

This doesn't apply against the current topic/simple, can you please
check and resend?

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4WtaAAoJELSic+t+oim95aQP/iXfEhjJQ85Qj8IU4az7+aNk
2tW6kCvwypPEZN04p4Yp82Atf3GX/p8t4Oo70qaWnRYs++NdFdqWrU8NXXyQ0ku0
P4pKZjQh1ynK5k9b3fI9PGkecefMAfpqQtHU1iy/rOaUSWht9yWB2yvnkfc7XaQU
lONcmRVbCgSilK0mktUoqreChLdtkd/aytfYswWhkRIIjD9N3yQegt8eBZIan/hZ
zOKW3SYcZO3JjJibFCc5fZhyN+Ud3xDGY5MPuE/Kx8vNnqKpZkjRApw/teyCLQRc
LbXbn2ifMDqGADaWLjQk6YyWzS0pPqY4oY1F9/k4n+KaAQwKSoEZaafa0pIWzgBx
AIPwJ3jFfRxR6u8JD/4o1To7PPjF+0MAZpJkUV4lCUtN0Tb0gVXsg/h5rBYitoGR
fVh24hretXK1qibCA1nR/1b+ov5pWeDTFCmTtUkykLAW47rEwy5WSUOPddYq5sYZ
NWvZ1HKKwjOuHj81OoPv2skrwyJbAqkAvbFyYx5jLFREwzBmKi6hXlLx7t4rztPy
P5kFgIiJj+Z/tQ6IiUSOIr4MHrxxPleg47nEFkYMFgrRbnnTr8xdCQWcVwMqtMIO
l5QHO9UrbjEmPEKQy4CLSILX6klijStOZCylA6qZoPglxmgdw5k6qReycsduxSq8
KMS7OloBaa+jjvYscApj
=ZsJg
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
