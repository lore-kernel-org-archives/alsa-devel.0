From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/31] ASoC: wm8776: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:32:19 +0000
Message-ID: <20131106103219.GR11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-10-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4168746739044013008=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D0D312616AC
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:32:21 +0100 (CET)
In-Reply-To: <1383673218-18405-10-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4168746739044013008==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TDVcAd+kFgbLxwBe"
Content-Disposition: inline


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:56PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--TDVcAd+kFgbLxwBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehqwAAoJELSic+t+oim9BWsP/jmEAxp7WHEdYG55BShbnY9x
FjdAPTnUr0y2DyelRnwBv/OkAvoZweXzeE6+LkQU8SE/iTMSwheCAbjhI3V+4OS3
zwlOplPfg+IU5y4lZxsCS9tpk3MOggeqHMaixpZBqFpIOm2A+pyjTWE8LL5jyPAj
CixNqOdL6ELyOdgrigacD/qj9qicPpNm/eQ/gsQg7BD1evWHAT4pMikdu8HyP9oG
Ze7RH7bGUqexJxjHnybNR8sUiLBko1pSSlV2evMjjQiFh18oUefvZ/cA4fxGM/4P
Xe0WZ/w+ShEAS3TO88eBhVWeRpRdFA7Uv5I1sKQgqrtL2IW0jLuLW7rfHm6d+Nte
Yo4wy91EsjV37L46MMLCoSaLQUEJ1xnuKNsUqIbf2pKExSxNGu+tG9ULjUnR96Df
97iPSrW4bv12zXL+uRO/Hl3X3hlcbBYEwILZ0iMoRo3avi5dZt58quYxGPlydupl
XfRTgRGOQUdPvgX/xL8IWoNv87A4DV6O4bbz+bMCKk/R9mxSHKmCDMvG3leAfwcu
vWeanxr579Uyq09PIvbMaFCP5BiUDg9XvoXhaJ6iF7APlpk5JYYU30Dso6aBuNvI
WEwYjdHelAEYsvmRp2PZtz2T2ekV+wopgou0q53MbsF0YY/qSsEnYCMKExXAnhXZ
+pw6grGoe26FW4jt1485
=mOOi
-----END PGP SIGNATURE-----

--TDVcAd+kFgbLxwBe--

--===============4168746739044013008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4168746739044013008==--
