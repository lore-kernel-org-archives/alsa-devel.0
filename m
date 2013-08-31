From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Remove unused control_type field
 from snd_soc_codec struct
Date: Sat, 31 Aug 2013 12:48:38 +0100
Message-ID: <20130831114838.GE18608@sirena.org.uk>
References: <1377939739-14246-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1812550533155661844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7AF2608A1
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 13:48:43 +0200 (CEST)
In-Reply-To: <1377939739-14246-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1812550533155661844==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 11:02:17AM +0200, Lars-Peter Clausen wrote:
> The control_type field was used by the core to track which raw IO methods to
> use, but when switching to regmap this was no longer necessary and so the last
> user of the field was removed in commit be3ea3b9 ("ASoC: Use new register map
> API for ASoC generic physical I/O"). The field is now completely unused and can
> be removed.

Applied all, thanks.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIdgTAAoJELSic+t+oim9FEsQAJ2Tho762UgKW7qE738/DMWT
QJ8mmneAVCr1u8Pkbfe2As1bo+MlLO7gPZuYkhsVg9vgB1T91+vxxjzPvLOSPMAz
uHUOZGnR3wGXoOnxcZXQIvXnmN9iNYDwPzvG0c+kZ1WuK5pIUIqX8tSDQaApa4kC
aM/XbHAZfrxxuvEa9udE1BehKpIxZsMYOXindML4NC34Y51kLfA5liTNNGQmOXiI
0u/CgPJq93tY/kgL3JqvmC0w91Bk+sTEKgj/24PpVbYEOszdnoTXozJzxs6yO517
GbW6k0AV2XPTPaqANfG4GDVDcljZR9xRry4zD/b0LhSbf5+/o5EeSObFEvWXvCnV
zd8wtjjPpOEUMLqR5nHQeTbWvBB9p2lrWHtIIPd0boo1w4dpb/cWYSAzLd8jARKn
D8qMjCpNngP1oTB0dgaiyhCXYxsEXPZtaweJtKYlehhs/M8+x6ZDOeZ7GmU9FY4f
jm+rVKaFgh/Q1aQbmpjAmZ62KEVifMfXfu6GJmfy74zu/4BgeiFGhe38W0h7ogIv
tA5W1zYCx3/jqbSDvRBKDOOoe/mPSryuocFegrMWRJODy/A5WBtHaZqxYMKpqGYO
v18ihn9T0MO73aruKthLyTQBlkekoqCYKvgEzXCgX+aXjR/NgZTOpuljYoQ75f/l
gaY8TUzh2DkMoALFbhTo
=73RN
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

--===============1812550533155661844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1812550533155661844==--
