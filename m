From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] Dynamic routing for compressed
	streams.
Date: Fri, 17 Jan 2014 17:56:44 +0000
Message-ID: <20140117175644.GY17314@sirena.org.uk>
References: <1389978145.2353.29.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3402010759748689418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 256192610D4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 18:56:51 +0100 (CET)
In-Reply-To: <1389978145.2353.29.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3402010759748689418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ELMKpCVvjiB+uwRu"
Content-Disposition: inline


--ELMKpCVvjiB+uwRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 05:02:25PM +0000, Liam Girdwood wrote:
> Changes for V2
>=20
>  * We no longer copy the compressed params into the BE hw_params. This
> was bogus, but didn't show up on Haswell testing as the BE params were
> never used. The DSP ran the BE is a fixed configuration so all BE params
> were ignored.

Applied both, thanks.

--ELMKpCVvjiB+uwRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2W7ZAAoJELSic+t+oim9NQkP/irEhu0/d0ML1+sxUETlI8aD
57QmfpL5xxvoskXFth/IW4EbYLe/hy7Jl2zalK0gRAB4pNYjsBP1CENX5msHYjC0
tDwBpKAnnymK7bfqiFOLblWY7dcXatsZ1+VrMnZ73C69xCjxm2NNdoXBb/82eOdz
oDFLKmNac2TyJgTKAredKTMSAfyGAUUX6ZJ7PYocoJcvHtSNvMLxOGGy6FYHjZkY
5WRWdjKiMOik1l2PMPaFy6uu6ieHeAAphR/E1YNYO4vaSpLfBb0ZiFaZDLWibytb
fNGOecWFuKw1T15JxSZSIPgjyeISvpfpMWBbc5mCK4niikmbLI5NljGQ0Dx1Cf5b
3tTJKmQyZ2tEwBxYtKK+0kMks7fp35RZWwWDrKFk5xxBO6hvBkjjK69p1Kd+fToP
7jpJujX2G/7+L6vFh/weQ863oCphp2aoetKTTqCR0kAd9w0n+PkBzfTJgmN38SwR
GddKO/YZrds7hCBu4u7L5jb2aInEwvYIIohXfKOuD/Z4YgsfMmM3Mpeymvw6RWcC
o05K6/cNyDbI5cIxOxwmOEu3aiCrIjDcWRLeSePCiLwchlqsFY4Hlgo5Pq6r6LA6
jbDPoX/oYkrOam92NwxIwaOrerHumfsNShGgEzoEOzDbK/2NPdSH1c3tPPAkhShb
Hvo0QF6nGCs3fixUyNqQ
=8qRV
-----END PGP SIGNATURE-----

--ELMKpCVvjiB+uwRu--

--===============3402010759748689418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3402010759748689418==--
