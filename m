From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: txx9aclc_ac97: Fix kernel crash on
	probe
Date: Sun, 16 Feb 2014 08:38:10 +0800
Message-ID: <20140216003810.GP4451@sirena.org.uk>
References: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5913226459924255400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C07C3261673
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 01:38:16 +0100 (CET)
In-Reply-To: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5913226459924255400==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wiP8eU6Yj5r7oh2+"
Content-Disposition: inline


--wiP8eU6Yj5r7oh2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 15, 2014 at 11:28:29PM +0400, Alexander Shiyan wrote:
> This patch fixes a crash caused by commit af5b2d7519
> (ASoC: txx9aclc_ac97: Convert to devm_ioremap_resource()).
> This is an attempt to assign "drvdata->base" while memory
> for "drvdata" is not already allocated.

I don't know where you got that hash from by the way, that commit isn't
present in mainline?

--wiP8eU6Yj5r7oh2+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAAhvAAoJELSic+t+oim9kWIP/0MpjQovyJCSdwDDnx93h4OK
VIqa9W77DeQgN4nxhnTlQG9WtI4oSjWCSysemAVMsBIhBjrSMgdqyweNl5lw5EmX
A5BtRJGhcYdCSuXxcdCihnLxVH5wAlKbgTi1MBuMPgIhYY5hBZ9GOGtwteIKwrN+
fo+2XrzVsH7oBLbnZkPqwR0vi0GheQ5Kdf3Qaff7xTd6QWY2SR/UPo5mFTrj1C3j
doYw2HnqpSDEjywYmSQZDS6BtveOQS/2xcramuVjEv695Y/dm1TEcQ0omJK1HJ+l
sWDsiH+lxzluGklzMDru14ON1/nRAPtQMzZGNLB75kC2qQ13ginLf6GkUbGrCcqH
cvgDs8NCuqBGruxj0S5o8R/1w6KI2KbYGmruncFPLbtbleSwD4eAU9esKUg38V62
QNGyoUxGkNnWF9rEarUBOc2WftWWTevkiOt5sx+exyAKBd7OYLNjzTHyIDXNFmlL
PuS/0hnSy10854wiNToLNJ67iw+PoC5qkSf7tRJLicY1Yxg8FDdOtQffyjZNedLD
FgWtV24TtftcyX0VGotBBczDZc5pujHyJYqb1gPGXkn6nujP9SD29KMO2OL9BFqu
Q8FiwnRMMUjpozn4Y+u0eiUesums/9mKG16Mn1knFCSjKJF7aYTuxySX58nMHjgR
GNYgV3JQR+0deSVko97a
=jD/v
-----END PGP SIGNATURE-----

--wiP8eU6Yj5r7oh2+--

--===============5913226459924255400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913226459924255400==--
