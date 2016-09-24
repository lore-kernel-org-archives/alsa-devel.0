From: Mark Brown <broonie@kernel.org>
Subject: Re: A small bug in soc-pcm.c
Date: Sat, 24 Sep 2016 18:56:07 +0100
Message-ID: <20160924175607.c2pmsitvvjs67bv5@sirena.org.uk>
References: <2427cb7f.ab0.15759e58bdd.Coremail.pengdonglin137@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pljyxinhmj7m3trw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2427cb7f.ab0.15759e58bdd.Coremail.pengdonglin137@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pengdonglin137 <pengdonglin137@163.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--pljyxinhmj7m3trw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 24, 2016 at 09:53:18AM +0800, pengdonglin137 wrote:
> Hi All,
> I found a small bug in soc-pcm.c. For example, we can see kernel logs as =
follows:
>=20
> [  518.707401]  SLIMBUS_0_TX: ASoC: trigger BE MSM8996 Media1 cmd 0    //=
 should be SLIMBUS_0_TX other than MSM8996 Media1
> [  518.707414]  MSM8996 Media1: ASoC: post trigger FE MSM8996 Media1 cmd 0
>=20
> Here is the patch.
>=20
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 60d702f..8c037ef 100644

Please resend this patch using the process covered in the kernel in
Documentation/SubmittingPatches.  In particular it is very important
that you provide a Signed-off-by - this is needed for licensing reasons.

--pljyxinhmj7m3trw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5r42AAoJECTWi3JdVIfQ2XUH+gMJJ/5vNFWRZfo9lnLnt9G3
EYpvZdJaTkolT2f3zka8r1dUv3lKcLJPwyHVtcxpGWaz7MrCMbvyHyDqX8jaFBK8
/2VSIIj0rIiy4n10dRVqYFmCsLYeTGq1HIu4AmoGIj29wcT00CknvoebYYpgo+qM
3DzkqWWqAZmfbLL8DVvqwz7+xarisw+1oKeTskfXzTji+dgWkWttqri8kMfpbOyR
YF6O+bDviRZ8udORjgPN4syMoPQB9vn9+YF1J+AIWbKioMMUPeHBHXpIJ+JBRTEW
AyWpc3Aydo6KU2a6pAPuMsiIY1YuTjfsCLB2UT/K6XzJgAtEnJ4OWGcKvYDKXmw=
=7rxM
-----END PGP SIGNATURE-----

--pljyxinhmj7m3trw--
