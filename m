From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 18:22:14 +0000
Message-ID: <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0754935007=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171108181841.29332-1-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0754935007==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntd73vxin3ez563k"
Content-Disposition: inline


--ntd73vxin3ez563k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 01:18:41PM -0500, Alex Deucher wrote:
> From: Guenter Roeck <groeck@chromium.org>
>=20
> ERROR: "__aeabi_uldivmod" [sound/soc/amd/snd-soc-acp-pcm.ko] undefined!
>=20
> 64-bit divides require special operations to avoid build errors on 32-bit
> systems.

Like I said in reply to your other mail please don't resubmit already
applied patches.  The current tip of my topic/amd branch appears to be
this very patch, if there's anything needs changing please send an
incremental patch.

--ntd73vxin3ez563k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDS1YACgkQJNaLcl1U
h9DRNQf/fM4SKHjSjCwvb/KtlSFw0oG0oYOoMfl7EbQjS1pK84r3cKkh1Z7sQ9T1
xUv7XL3bVeZ9Id/874Iok9xT/GcUbkhFKV3PotAOhfgcumA8AzA3DFiMxlTdfH4B
CBasyJE7U2b1/DaRNbWrgt5LJe7XlTpmVdvCuEKT1jzk1DLpP13rsELumSZ3Uup1
/hAHOiYdjlofvVd7NencK8aqiwn9ZaaKGBn3sSuNijMHglwKMvtfRNVp5Yfv57PE
m2q1RlJjVJNfSfjESDi6TZv9CYZSDliO0X1KT1ejLoAYYsnl5axGHLIQbftUVUng
IVuL2BFJ3TrjIZDXPkC/8VEuH95/HA==
=R5iY
-----END PGP SIGNATURE-----

--ntd73vxin3ez563k--

--===============0754935007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0754935007==--
