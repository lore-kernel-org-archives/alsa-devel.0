From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: sta350: Use
	snd_soc_kcontrol_codec()
Date: Mon, 21 Apr 2014 11:21:05 +0100
Message-ID: <20140421102104.GE12304@sirena.org.uk>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
 <1397897042-20092-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7685333752055559483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F60F26167E
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 12:21:26 +0200 (CEST)
In-Reply-To: <1397897042-20092-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Sven Brandau <brandau@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============7685333752055559483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/w6SIz4FoGVKecU"
Content-Disposition: inline


--V/w6SIz4FoGVKecU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 19, 2014 at 10:43:56AM +0200, Lars-Peter Clausen wrote:
> In preparation for componentisation of the kcontrol helpers use
> snd_soc_kcontrol_codec() instead of snd_kcontrol_chip().

Applied, thanks.

--V/w6SIz4FoGVKecU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVPENAAoJELSic+t+oim9yBgP+waZwtyQeM+BOqDUG7Tm4e9s
xb1mPZBpJjYkhhMtT8XcPIxTWjkcXxA9u5kXKn9fjXtn+lgTktF1LsaWi62HyWDA
zkQf8t1KhKaRDodgWBmIGG2Z2tyLGS6kMoKgwtnF9KGyc5Wh1wvI9LQtDwPOba6m
IJ1pQ9UR7dC/7tHhBL33xV4nz/anQe1M7zl338GFSLkyhVpJwOZOhKMAQPDsjQ8+
IIb7JF3zqUkR31pAfNCBlx4+weIwnTLPY9MXSFb9kAwhuO6GupAnvlmEiMwkQ0rc
O7Zjb8LP5XUS+bhlPYAH0LtW9AZKyq2MmEZcwm7o4gXh7G+Pb6eN+k4IoclNhAjl
UhZk+CoHkSK6JmZgEpOtFCLDa7Km3My1ylPGgE75kp5ndMUURYkH0nsVyCwpBJ7A
kKfS7oBdJ2gBIfRaozflsb2VnrUHhMr9qX99TY81oue3Xp+V6J4xNRKBTpvRu8br
xI6Rpx4YUAUeyZlGFQozfrp/AfscsdgKdWuwmXxlOAI3o1MYfkct9f22k4g68iI2
jp95OLGzbXgD2DA2u8vK49vsD58jNTW1GF/+rztpGkghasYR2tm6EK/i0qQFYQH0
faGn62cuiwH9V2i/moF07JFbABq3M+DEfrrgfD9gtRQsaEIz/ofYklzNxElOvzOX
YhmXnspiPtaXKMue1yoU
=k+tM
-----END PGP SIGNATURE-----

--V/w6SIz4FoGVKecU--

--===============7685333752055559483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7685333752055559483==--
