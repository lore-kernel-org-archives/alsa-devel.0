From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 008/102] ASoC: rt5631: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:56:45 +0900
Message-ID: <20140220015645.GW2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3730753598336687449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5C2265610
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:56:58 +0100 (CET)
In-Reply-To: <1392723148-12597-6-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3730753598336687449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8K5ySslWdOQpNfJE"
Content-Disposition: inline


--8K5ySslWdOQpNfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:20PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--8K5ySslWdOQpNfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWDaAAoJELSic+t+oim9OSsQAIPsCNz7E2DWahviAJqvs9fY
8dm1zD0N2bPkPl6oN8JUPsIiBy4k3VgEhWx1p2TbdvHturPE+MlCydiH+RGSQWsV
U6zT8hFpH8MIaD/W8UELqjemUthxC/RT/n1fQC4CiVBtHXEOe5/w7z57gG15DHOU
XLhX/hqsNx73C1HzTbblsMGdqoYd2Mt/U8Xd5g1meKUHgRXJGJelYGN5jDKPY0ud
p3MPLH6fRy5Vc+xuta5TKiWjx/PWamnY/vnAE8TW0fNH/2Jm4z3l0NNlFI3sdKTD
PczRrsD5TCm+3QJpKpppeB3Ufq1HoDexvq8kYL5Tx2GKurKzEes+FCq+nZstwnPL
0rQcL4FV2VyEUZFKTka+3yqGAbJtirTkAhc6w7sUdvWfLbL0AqKIHRyMwJbQXMW1
oaooAwRlWe3HbsdUmeqYemKQiLa+VmcOsLeRzrWZhgW764ivpqnkUbXWhdZjdata
rRkUpqXYWOF7sx5ttMkOvgRWO+kS9SgWBxT1u+gRst2bjS7JEP05UosRseCFUuIF
Xzg4iqU85GekX73wSTACRtuahdeer3ZVrHXDrZeja5aELTjSLrAc+xVJq0+SsNEn
1OlBtac7eW5I1rvuesDzCiYSYw03Lvun+V88rUuLiFY1Oj5jaqPyGcrw3PhpQomh
fKthen9KK9mvAJnNVXy6
=OkYP
-----END PGP SIGNATURE-----

--8K5ySslWdOQpNfJE--

--===============3730753598336687449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3730753598336687449==--
