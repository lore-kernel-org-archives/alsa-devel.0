From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Thu, 5 Nov 2015 10:26:55 +0000
Message-ID: <20151105102655.GN1717@sirena.org.uk>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
 <20151104183322.GD2549@ck-lbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s8J8qjRpxLkp1Gun"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151104183322.GD2549@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--s8J8qjRpxLkp1Gun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2015 at 06:33:22PM +0000, Charles Keepax wrote:

> You should probably make a seperate driver within GPIO for this
> and then tie the two together, using an MFD. I appreciate that is
> more work but it is likely a nicer solution overall.

GPIO chips are small and simple enough that we've not worried about it
historically.  However my question here is why this is wm9713 specific -
the GPIO functionality is part of the AC'97 spec and present on many
AC'97 chips so it seems sensible to have something at the AC'97 level.
Unfortunately a quick check seems not to show anything indicating this
in the AC'97 capability information so we might want to make it opt in.

--s8J8qjRpxLkp1Gun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOy7uAAoJECTWi3JdVIfQIpEH/1fq3vyS2WZ8Dt+sdu2PECxV
J8S9/6sxGCaBNz125tQcngKmPc1VxqMVagaDys5aZHykmyVQbs1qM6DVQFvtf5LD
zX/m8gwxJWu/OE6FivKgj4GLJZzcUwZvRSYwVjz9vb8iONUyR0dN2vp1uEIz2gD+
vzU4FjdFkuvDf8WW0sXDV0Tzfnvd4U9Mese0qKYVf2ZaYt3dGD701FYFxNYLz1C8
6+w9UZUu8RNaf3A2ZYf3dBBpnTDBYyCNMZvT5J01pgPz/lejipUKKcekATRoB6ki
+GDUoKu2+Hv2Tpco0H2X15Q6doSrjaktztUT1/vBupmf2x1O88gxnA3rGAGbvIM=
=QWx0
-----END PGP SIGNATURE-----

--s8J8qjRpxLkp1Gun--
