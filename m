From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [BUGFIX PATCH] ASoC: imx-sgtl5000: prevent module from being
 unloaded when in use
Date: Fri, 23 Nov 2012 23:42:15 +0900
Message-ID: <20121123144214.GS4529@opensource.wolfsonmicro.com>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
 <1353587470-11994-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U8v/hV883cEE9JJG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353587470-11994-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--U8v/hV883cEE9JJG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2012 at 01:31:08PM +0100, Lothar Wa=DFmann wrote:
> set the 'onwer' field of the registered snd_soc_card object to prevent
> removal of the module when its resources are in use.

Applied, thanks.

--U8v/hV883cEE9JJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr4s/AAoJELSic+t+oim98JkQAIAGDHFBlEAQmf4PbrW/H4yk
iOgHmxRqKtR6bZD2gS24krZLiw5LIsfyp3YwB6+RV88KL4+ZlQ20V6YqSKSQZV9M
rmXE2CiYGi77llIzfnezpqEvRwZXHLz0GDbpPG7dAmz7vXnM5wKHMBf4BYFVh04k
1Cfg1+NK7JKToekQEYTErkikAf5I3Z4ChGfNYCohfZ40o5m8tdbOyXFhB18DQL4t
HX7gp+eRAC4iOb75zCE8qgBAi0TGfAkMgra2h4w4cjSXMCKgpZYnO3MOAk7b0Nek
ThaGnOyF6gNfEHePr1PnLRm2UPHEiG33h2zx85l9F602PMYDTeMnRsLxC562gqPr
z/l+fMSby7EWVr4gfZMZ4jzS6esMmW6QS8WsuCnGYTlxhafGqn4OEY77TyZqab80
+11IyKN8M7HTH+OPIHYcRvS8Su9LOIAKERDAyFNnGbmy03eFhS7zffEfms+dRyh8
Idb6xMEDr+YgWBEolnLodmtyyaZtkHufk/x2RZamt1wQ6J1A2GOuwT/tgnSJqx3K
NFhIBiRMj/IEMfX+iHg4yq+EmFbwo34xj1dx8stOesnW9mt1k9+xNZEGlrv5orkY
E5qrBpCz/eCdFUsPws+/h+SKWNGEfDfTHFyjVjoW6+HKgTGpkA46k1ujdFr03Ill
SfLNn9ZD3JH+F+FKzA0P
=UKMW
-----END PGP SIGNATURE-----

--U8v/hV883cEE9JJG--
