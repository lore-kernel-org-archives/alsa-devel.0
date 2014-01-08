From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: utils: Add internal call to
 determine if DAI is dummy.
Date: Wed, 8 Jan 2014 12:08:37 +0000
Message-ID: <20140108120837.GR31886@sirena.org.uk>
References: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1720051925578858667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8D5265149
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:08:43 +0100 (CET)
In-Reply-To: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1720051925578858667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGLwo6UH3inn357k"
Content-Disposition: inline


--OGLwo6UH3inn357k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 10:40:18AM +0000, Liam Girdwood wrote:
> Provide a quick way to tell if a DAI is a dummy DAI or a regular DAI.
> This is for internal DAPM usage only and is used to determe whether to
> insert a DAI link connection into the DAPM graph.

Applied both, thanks (with the spelling fixed).

--OGLwo6UH3inn357k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzT/CAAoJELSic+t+oim9JQQP/i6l+S/0Ch2z13kVgy0oM8g8
99RfCkpDl+QOmo4RFOfBOrwamRkcwy920o+mfU+0+AHH7ejx2ziQIcmwrfVuVKJP
trcaN2WjLEYNJTf4U/kZ0nvK++Uj1EzTtuDkpN7rtawRzQtufvbBXJhOxpmd/nud
N9mu/ito2mRBb98zpfwZXcUPRSakt2ylCgYLRGtQBiHRSUZuuzLU7UF+WLf1dCpf
zRxgsTGbrWHXwa8D91nFVBsFoWZrOegdiyzyrzZiOYKDSOz6S8qwv2hM82Lodr85
c2J3B4AQkYF5ZCz0sjkwq+skg6nZ7O0FfRYp6aI0mbuzkohloi10aFp8n9fpLDxT
s5Y8xAvE41tzqcQjVlczaDCi9lrYAWeQfHyL6yLutkbEVVfjEpUlWogF/dymiuE+
fFgX+E04m/APNEpLGmIEz7n0WTq3fn9Zl+eIp1CU+BKsV+giPsW6+x/oNWvAL5oH
FigsO6s/bVCF4Ji1YGysVnQUuF0+1rAl4ds8Mb1yMgAVQpAG8rtwP7Mc2vO+zQfn
eCVBxqwx1H7iUA15XS9zSwcVZJVfIQfFFQCCu51h410m55a9QVXWAXfONgXKJ3Xg
VFbY3nnLrpgufhoEagCetf9NDAdQ4siMyRb9H0Ey9Npum+VdNftP5mJ8dJwZdYdT
FuoMO3GRVgXTZT2qyyqO
=HUNF
-----END PGP SIGNATURE-----

--OGLwo6UH3inn357k--

--===============1720051925578858667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1720051925578858667==--
