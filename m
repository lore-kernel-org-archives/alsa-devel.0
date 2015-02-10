From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: atmel_ssc_dai: Allow more rates
Date: Tue, 10 Feb 2015 15:12:51 +0800
Message-ID: <20150210071251.GJ2593@finisterre.sirena.org.uk>
References: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Peter Rosin <peda@axentia.se>, Bo Shen <voice.shen@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2015 at 04:08:25PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>=20
> When the SSC acts as BCK master, use a ratnum rule to limit
> the rate instead of only doing the standard rates. When the SSC
> acts as BCK slave, allow any BCK frequency up to the SSC master
> clock, divided by either of 2, 3 or 6.

Applied, thanks.

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2a9vAAoJECTWi3JdVIfQcQgH/2AVc77z7f6hlgzEPJdRPJDE
0Wkw5srsWrwsLdNZKBOb0AdMmElw5wp21acavoFG0G5RBzs8sEZsVZ4Qo+pFgDZT
KkUuEiDB9jWH0h9EbKMvILehiJZQZFVcxvXBMtiXUYn1GA9dF9LxJ8m3IxKVkl8V
lngokfC+3ppvMoDZU2xIFZvP8mKlnWPsyP4w3JguMAknGue5wvT8DXc1JSycBB1Q
gMHhiaYshQVEHWrBoWJLmOB4934oAvyykl9I0iCCApbHP8pi/gfsUfUBmbMmMOx6
5Ss8/g9+miAxKMO6LYrEJypOxK68uyIvo1IjgucaLcgG5Pc/0ruzfDUcyZATH7w=
=9m5c
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
