From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/3] ASoC: restructure
	dmaengine_pcm_request_chan_of()
Date: Mon, 9 Dec 2013 18:43:31 +0000
Message-ID: <20131209184331.GT29268@sirena.org.uk>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230169311353304269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F0D85261A3E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 19:43:39 +0100 (CET)
In-Reply-To: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1230169311353304269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+i6GWCH4khrSQjQ2"
Content-Disposition: inline


--+i6GWCH4khrSQjQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 02:26:32PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Restructure the internals of dmaengine_pcm_request_chan_of() as a loop
> over all channels to be allocated. This makes it easier to add logic

Applied, thanks.

--+i6GWCH4khrSQjQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpg9QAAoJELSic+t+oim9m08P/2z62w8TQqexm8cSI3z/BvwO
LLOTAhMtTby+rU0bvb5VskQFYOu60/l52bdD7COcXhR+2A+9osFV++tN235943qT
wVklzsZbC1IM3ZInp6BXXK+P7jwmhtE2+4eKyRkCYc90Pu3iYPwFI9MYEEfaRgOB
0FakXwGXfKr4uAxRNDmp4uTda95QB05sxrr+iEPrNVMhC8c9u1oCH0Np/Q28KO09
Gul4HXC3oQTH0p+YfwrQ/IfNhH9dv2Brii68sma7jze9c0xoCRAvCvzWRKa1aWZz
csiOtMgwCJpUVhp9q542DsOzC3fZ202UF5fbW6Y1tRqyvHQPuG2FvfGK1AeYJdeO
HKx31cpp6AdB/WbseisOcORIrNoeHe6jEC1RyAyEkdM/4sTGT/gOjTLsGVF6y65g
5IutO7tD4M9Iiy4wSNWNA+H32H1728NT4V2n0Sra9JjKPN8vdyw04qBCpao4o1zo
XzhiUmpxAmtgvM+Zo3A/o8JwSKRDo4ZbS+15X1ntC2JWjRI/izkZdqyQ3L7osgv/
m73dVOqK0bdZvJZ5TaI12Zyv8bbeiDixKoJUhcwbY63SDgYQfEupRvYQdkv19gLQ
N+PEuzYP8/xdMtbEylhHFy+mUwYomAjrayvTktA1U/+/EJW1gpzteiV06MvfssJX
m+fGqxy3374mHo/cqxst
=byAM
-----END PGP SIGNATURE-----

--+i6GWCH4khrSQjQ2--

--===============1230169311353304269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1230169311353304269==--
