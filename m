From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix null pointer issue
Date: Tue, 29 Jul 2014 13:04:29 +0100
Message-ID: <20140729120429.GR17528@sirena.org.uk>
References: <1406613057-17359-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5722241619032692506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A46042650C3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 14:04:40 +0200 (CEST)
In-Reply-To: <1406613057-17359-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5722241619032692506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kGQGJjO6+plzktLY"
Content-Disposition: inline


--kGQGJjO6+plzktLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2014 at 01:50:57PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> To make the interrupt safe if it happens to be called before the card is
> ready, we use regmap read/write in the interrupt handler. Also, we try to
> prevent the interrupt happen before the card is ready by enabling codec's
> IRQ in the ASoC probe.

Applied, thanks.

--kGQGJjO6+plzktLY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT143KAAoJELSic+t+oim9+lYP/jo2e+MC7JoOUQcYKWmN9SeF
VoxNaxxe0vXWemxQUDeZ9+TvfmgWy53oW3qCNdn/LBm1snUGF1RotIl2BxPB65Pn
wfJcKsQbMIafXwzsAaMfyQhklYzJPkHkt47A7oWhZI4445SIylZSgTt8HLn3e15N
W1XBS2qINU5YsVi4/a6RrVmxHq5qpFHeFkywmStxDr8bbOPSzhxVdZzJZRljxluU
Q4+p5obqHNvm6poovEoUJCW84rq+lt1M5aftVP1KIWkSEDKJygB4B0Fev4KnwHnm
Rr3bWjcRnAQWafGalTiRVElVUNTVQGsuj4tSeFAM8pKRrwKMAFTtLhrlt+xxyw+n
hxdftjAjy50CF3BpFZhgw6Qi24G0nRyqdXSgi4GbQJR3Ujt4mAf2ETZfqbr90AZR
dBP+t0hCZTzDgk252w2lmdyG+PVdhWR9aHxCLVj2e7m47n574e6aXEsh0uVCGBqY
gjHGWtIyI3V+z//3fwyEwmK4lKnizlMrUl4D1rPEmfZTWgawLX2uXAnn/J9DM+bj
1u2LGvGigvXExtzMPEPzwN6qHgizbL4tgEreY4xPYlhfMokF2kb02lOlge+aDpVz
HAV7SVCo+19HnfZ1Dc3xMN6F1vQATATBLgmBkRqEQeq3pNChUiCe1IxFi3FJRe23
Czl6ooQMjDSMmelW3G3M
=pvYf
-----END PGP SIGNATURE-----

--kGQGJjO6+plzktLY--

--===============5722241619032692506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5722241619032692506==--
