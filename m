From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/11] ASoC: sn95031: Staticize non
	exported struct
Date: Wed, 15 May 2013 08:53:22 +0400
Message-ID: <20130515045322.GI24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3438457164773001242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CCB7265148
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:53:29 +0200 (CEST)
In-Reply-To: <1368562797-10440-10-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3438457164773001242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:56PM +0200, Lars-Peter Clausen wrote:
> The sn95031_codec struct is not used outside of sn95031.c, so make it static.

Applied, thanks.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxS/AAoJELSic+t+oim9zogP/3WbqppqC9xTowRgvt3/Fsq8
PHkDdO2sR36Sm7HuOjCzz/b2ZYQWgQJPD4eYmngASCaPrgRArLzuZF8QVoKL9FOY
BJtB3Va198q/GNlseW0amPJFMs56le3YO+de62GuNad64VzsmDyMxhEwPUlaJO4g
QgNQjmhy6ldEpT06NbLVFvOP0ePJE5kRelpoa9h0tyrplYsBYfx1wEC7pbXk8oI7
HjlRUtz7sPD3Ah8vQ8HmElev2AS4B1heFko/13JRMeUa0XNgTy4LtTLXBt29bqZH
zzP2GUz5PGQptlHIoxggH60moecFBZPW84onMLULCEElqi+MVj5QI4lUfuw7gk7r
rm2GM7pMsddH06b7nOw83J7qASUYfESHKoXMmZ0dxPealV9oJaq05G4sPgjRrDD9
Vyis7V7F6zggGynPeemNq+zM6Jw/aahs0BDUv16MrQ/vruAALbfZgoVCG7BNWjgu
n16ck9StudcmXTxHH4hbiP0KzuNYBlXM3vC33NbGSeXwMTvcZcFBM0kKEZDofmeW
lNukANxbSIAPLVaLJjEFxnl9Iltl04/E9WzROoEj3ijQIHH0mDzEYrHZ8Jl94B3J
38FcgAMwDXjBGMli+KurWED55iVVsf3BVtNFE7Dj6DeHP4qPYzVc5t0WCPFK/j3Z
REUxHqHMs4prQroQsjfC
=QVaa
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--

--===============3438457164773001242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3438457164773001242==--
