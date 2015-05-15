From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Drop unnecessary bias level check on
	resume
Date: Fri, 15 May 2015 16:50:16 +0100
Message-ID: <20150515155016.GB4637@sirena.org.uk>
References: <1431686490-13204-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1732568521475527341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2956B26650F
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 17:50:28 +0200 (CEST)
In-Reply-To: <1431686490-13204-1-git-send-email-lars@metafoo.de>
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


--===============1732568521475527341==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 12:41:30PM +0200, Lars-Peter Clausen wrote:
> The suspended flag will only be set if the CODEC bias level was either
> STANDBY or OFF. This means we don't need to check for that on resume since
> the condition will always be true.

Applied, thanks.  I've got a feeling that's bitrot and wasn't always
true...

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVhW3AAoJECTWi3JdVIfQaUUH/1gdULchuk1bmRyuwqwTqTRL
8lp+SGaDr4wZ7ylS75CRt9uyUJf8VoP2dh4/xBKBG81dEUDrYbFSTShWkobrDh4M
b7fr/b8aMrNuD7KFF9LG6aUTj58K1dTIL5HbLkQwCLUYIBFWar9wTssemelpDT3l
SK0jvDFv3KPXqvAgwiuRzIVoav/VUm4GeRIlbYT0olJC7eH7cPKdHsncubtbQyOW
e2okq20cI4nSR2IEu6Vc9PhpLknjGlqu34a9gvuPnHWYtb0gUggk1aCfH6onH5SC
XZDx/xS2OZjz54LqBzjXywQ5I/E8UOJE+zSqEfL1D45b6pSELEYKqoqDK4eUwA0=
=B+UQ
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

--===============1732568521475527341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1732568521475527341==--
