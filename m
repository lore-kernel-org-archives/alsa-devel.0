From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix property name for
 simple-audio-card, format
Date: Mon, 10 Mar 2014 07:53:16 +0000
Message-ID: <20140310075316.GB28112@sirena.org.uk>
References: <1394194711-32009-1-git-send-email-peter.ujfalusi@ti.com>
 <ca5458a9aa144c20b8c5987fa29f74a8@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4802569556554615143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B856D264F8D
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 08:53:29 +0100 (CET)
In-Reply-To: <ca5458a9aa144c20b8c5987fa29f74a8@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4802569556554615143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ppquB515c9UZNlUZ"
Content-Disposition: inline


--ppquB515c9UZNlUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 02:25:02AM +0000, Li.Xiubo@freescale.com wrote:

> Sorry, the interface of snd_soc_of_parse_daifmt(struct device_node *np,
> const char *prefix), it's intended not only to parse the 'XXX,format', but also
> 'XXX,continuous-clock', 'XXX, bitclock-inversion', 'XXX, frame-inversion',
> 'XXX,bitclock-master' and 'XXX,frame-master' at the same time.

> Maybe just the comment here is not very correct.

Yes, the comment needs fixing.  I've dropped the patch.

--ppquB515c9UZNlUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHW9oAAoJELSic+t+oim9WkYP/2b0diQFGWP6o25bLZqAGYhb
l78YJkOsljTZSl+I4rrBpvt+BHZhzB7Pn0QbD1yvV3rXQwfkt3z7Vr7BU7OQB4a/
yT2TzSCpqIbP8pwYtH/RrRb2Nq8QfnOwmBAAlHwHV7TKVF9x4hptYRejLJssF4ZR
TCj07zD5nl6MbFN/QBAh8hJNkM/5dRrvCspDOH57q9qF99qIojd1stQ1wlJv5hcX
j9LqQSslI7U7yj32hz3J/X+iR2sJu1rQFBuKy46rK4UjrS8x2WCJPMwFakMn/hWv
LqTkQ97oej+3zUmM4qkKHah7T9IvdblRXNTJiJqG7lXGOHxJUxV3WmgoG9PjqG6w
oWAYyQRzOsu7fzjqi/4pX0yj20ZwIV4PPnEcvPZnGGsvbUkXZ4vFfTFdU6GTo8ju
eY+iOL1ei4PxDBvAU+ozpaTfJr9m3/lIzezqV3MrCV0+b3OYRaGw882Fbss9bp5Q
ytlhIMRfAtzdM9gpawd5KbiU0wF+iX9RU9HFXJM1VuQJTUfXoLi/hX4u6aav+soq
lSk/0WU4Ok/GhnC5qJAXlzmkZYIaseFuLj1Wpv7ltGWDoJ0kYau1EKJKWpxiUoas
bOHWcfQRa2GEWf4xUUvbv2YYSXFIXx7UoM4eB1PYRn8iGzKtVyaY2WQNkbZIgGHt
VhvmYy/oUAzpF6tzl43i
=uvIX
-----END PGP SIGNATURE-----

--ppquB515c9UZNlUZ--

--===============4802569556554615143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4802569556554615143==--
