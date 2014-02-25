From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cirrus: Remove excess dependencies
	on SND_SOC
Date: Wed, 26 Feb 2014 08:57:10 +0900
Message-ID: <20140225235710.GK2927@sirena.org.uk>
References: <1393351314-23006-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2528402095131978624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0700265357
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 01:32:33 +0100 (CET)
In-Reply-To: <1393351314-23006-1-git-send-email-shc_work@mail.ru>
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


--===============2528402095131978624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 10:01:54PM +0400, Alexander Shiyan wrote:
> Configuration for Cirrus Logic audio support is included only
> if SND_SOC symbol selected, so no reason to check it once more.

Applied, thanks.

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDS3TAAoJELSic+t+oim9Ys8P/24w8wpA/wjCSIH6kXcWcKXZ
fA5a8vVhC4V48kQCFtUWdTvzQvl6bEuE+WwkEQZInAH+LGiDCquGDIUwZGydNg9W
lJBsOBnBFyBQ4Pk9dPkObGfyH0WXlYOc/kS8x7thlMkxT+7udF4FXDpfW7HH9Ypn
bGmOfc7WlgYWM0Lr9LteljAhQA1xiu5MwXgSyQimrjF9nuJXF8lg3ihn9Waj4deB
+59f8umilnzyj/Ix4vqy95dgEwNfM0sEYMTAU+0vVVbgfeZiMPSz9OU88qKbhbW3
Agcso/uQDVjQ5N/XPmKfWjuYkyOIsgYqOm5PoRcNYsd/kwpYpGAVkogHmoyDz7rI
sb3tC4Ks702a34W8sbX1jBQIpEYeWAx1Oar0j4MC+B9i9xI6RLSJhff6a/DnhjFB
s5N60AOWE0qxxbT9RP/e/ivKuA3uKUiFYTFhO6S+Czcha9+RiqU1NXG4/xqrp+bN
FAn/pP2/ttOJ2bUwSyJCiNKe3TDBKHeOwlTWt2CTc/SF8ez35szhwHdSyK/hoGfw
HMqXm87j0eWfm6/ZhA+tLEJ9luYbdoiYK/Mis88ST7rEcyWSo16tyar+7GHMqEKK
kadVMCIflOJx2HHMi8Vy90O6zBZ6G2rJjAY27d9+59EA9wpbWJWkdszlFFQRPLr0
XY/0tymhWIMjvaJtiv0w
=hcOq
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--

--===============2528402095131978624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2528402095131978624==--
