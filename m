From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: max98088: Add master clock
	handling
Date: Wed, 26 Sep 2018 13:22:49 +0100
Message-ID: <20180926122249.GV20825@sirena.org.uk>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
 <20180925142352.24106-5-m.felsch@pengutronix.de>
 <20180925171742.GR20825@sirena.org.uk>
 <20180926100030.tzn6hx6qqbjseopw@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3303434797260848695=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 832BD2678BA
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 14:22:56 +0200 (CEST)
In-Reply-To: <20180926100030.tzn6hx6qqbjseopw@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, robh+dt@kernel.org, kernel@pengutronix.de, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3303434797260848695==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1J4USyVh4Jt5OGCL"
Content-Disposition: inline


--1J4USyVh4Jt5OGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 26, 2018 at 12:00:30PM +0200, Marco Felsch wrote:

> One question, should it optional or not? If not I will fix it to return
> the clk_get error else I will drop it. It shouldn't be optional In my
> point of view, since it is needed by the chip.

Optional seems safer, requiring the clock isn't going to work so well on
ACPI systems.

--1J4USyVh4Jt5OGCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlurehgACgkQJNaLcl1U
h9CKLwf9EU8PsDpFMELxyTDZQ0wqN9oXm+nJSNyrslCrgH50cCr9WkxwxhR0vPQY
Fp1Zvb8A5drNmvj9LCzGu9Cf9mOCItKlHpmCGRQC1q3Jx+r8cBkC08Z8rSRjD93b
VvpsAd+noQCPLxXllsPoNMP5N9VYRibbqWzRZDHcI6CjWkSU7aY0CFOwdQJm/iul
6ZkWKbkfh+6RYdsEmtDLKEkga5oLekekeLE2KrhZHFt27HAMRvuZCt3osKCFwWdc
pFwdjRc5SdsFybxJJ105dPqnF138vuv5TIU9HnuDE/jJD2v9naftzIW1YClNvp3G
lJlr+IXKSx503p8vqG13fx9ErZWmDA==
=2dX2
-----END PGP SIGNATURE-----

--1J4USyVh4Jt5OGCL--

--===============3303434797260848695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3303434797260848695==--
