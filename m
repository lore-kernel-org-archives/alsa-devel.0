From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: neo1973_wm8753: Post gta01
 support removal cleanup
Date: Mon, 3 Mar 2014 10:35:22 +0900
Message-ID: <20140303013522.GJ2411@sirena.org.uk>
References: <1393687023-17584-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6121382381493244946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C14E42654BC
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:35:34 +0100 (CET)
In-Reply-To: <1393687023-17584-1-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6121382381493244946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 04:17:02PM +0100, Lars-Peter Clausen wrote:
> With GTA01 support gone from the driver there is no need to keep a separate
> initilization routine for the GTA02 specific bits.

Applied both, thanks.

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9xWAAoJELSic+t+oim9CBQP/3P4KQ+U8uRgAcq8wyhxZqcH
CQHaweWWdYtFDNCxiG8QDcmdoM0ZtrdesH+G74ZP/aB6LZlZSXKQgwsrSisNQ/7T
Hr0sN9h4Kz3k1hCbjLBkUU6Mwrui6dPOTRd8IYMFf/jmAE0e49I8hdZkSaTjtnaB
NZxwVQo8y7G6kCSCrEUKxRRFTF1yalJUXuDvlqOmJRMpvESi5aDur63NGYjAn1P+
E8Sqo3vKr6f8noBNv4IWX2CKUKiwdNRK6djmvd1+WYFgxyF5D+GzRDqWRT4HVamT
oNfAHZZvwieXW0Pm2qeTcrjA+zQFwOpX4q3twgaueBhBFz4ksxtMne6uabBJfZ74
haXVy893JC7g/r35aScxOz4yBIIfJ744o7j5DT3lmbImbmiy52B3rwMsnGG4TzDq
u0Mxfabc6vOSpjVFF7iT1Tw/n2k0Ng+zH/IR/Fup3EMeIIAt8iNjjs/l/UWD4K2/
2GJWGiJREGY8DKeJBCICXmGeZ/bmH7jd89cDy/pOa+IgM4hGxp5ii7by6beOqmx+
cjb8pzlaNcGsS0688vzhqIxtuuAhjBSbbIAKiZPe4NoGqbY+PRsxiBrT8QJAbIKo
fJeloP1IetQXV7PwkSqGLKJ7ZGm9aJC/QrCSHtGhSVMMr2aZQEDyZTd1ugLcZFGM
RBkeCkEsVUrL1EZYRIsG
=ILIF
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--

--===============6121382381493244946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6121382381493244946==--
