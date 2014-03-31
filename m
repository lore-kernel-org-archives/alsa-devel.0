From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add an of_match table
Date: Mon, 31 Mar 2014 18:28:32 +0100
Message-ID: <20140331172832.GA2269@sirena.org.uk>
References: <1396285517-17892-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0825263926495871628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BE03261A7E
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 19:28:45 +0200 (CEST)
In-Reply-To: <1396285517-17892-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0825263926495871628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rMBvpMIlSQ3hWZ0K"
Content-Disposition: inline


--rMBvpMIlSQ3hWZ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 11:05:17AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.

Applied, thanks.

--rMBvpMIlSQ3hWZ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOaW9AAoJELSic+t+oim9048P/0DsMeEf3K+AhkEB+WLsWa07
wwp74QCMlIQMuVPNajKn7YTFcFt2izLPuB60EEb8iqc3re823+kYcHRPijdeyptf
RPAaZl86+67QPbz82u98IcHEv5VuoKmpfcsR5QZJ6MWe1wq3LtSNq6vJmiIcTpAL
6ps+iP0t79z44X6gszpNytadpxpNSQ3hcFC+GL7GVGs77oz574SuKZx3OHujju1M
53fF0tYgcwWzp92B9G09x5p8SL74p49sdZNP2Mby7jYYL6Z2Co3Zr85dETBZLaci
qCipeufHOih9DJcmvEM637mnaoZYnsNcDTOFYjheGZfGmC2TYELkdF8eyc46RcXq
dFMnlpk7IHG9+5wNXTfIHG2RIkrXd+w858Tmu8G7bLruV8/xE1DFWNWNCJwG5u3F
jwFh4Bvb/T9hm7ImNI+bNRpZ1ZcwTZCvzS5aolcMGvKkpETzsxJiCN1ll2fQGv07
lYG8qJKWMUxmr37XAVTQvQ/9sLXSiWCpiFccFfFERZfZusrTdOuhLAFupW1AIHWE
7iP2I3HaqtKotdTwDoQjfNQlBe5q6A8GUxJJaYry+UrMC5JHD3R6Z2h4LjmAFnwL
POcxF5q2xSkGkhsEQrGiYxmrc7OLIUftzoaIo1uSqC1p7fFjyFbo9LMc5vakmcYi
Ve2eQxfsn45Z+qtaIw1u
=DsOk
-----END PGP SIGNATURE-----

--rMBvpMIlSQ3hWZ0K--

--===============0825263926495871628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0825263926495871628==--
