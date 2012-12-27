From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core: fix the memory leak in case of
 device_add() failure
Date: Thu, 27 Dec 2012 16:16:41 +0000
Message-ID: <20121227161640.GA5005@opensource.wolfsonmicro.com>
References: <1356454565.21958.2.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1356454565.21958.2.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 26, 2012 at 12:56:05AM +0800, Chuansheng Liu wrote:
>=20
> After called device_initialize(), even device_add() returns
> error, we still need use the put_device() to release the reference
> to call rtd_release(), which will do the free() action.

Applied both, thanks.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ3HQBAAoJELSic+t+oim9X4wP+wbauVBffXRq52i4ihkUj8AW
g32Xbt5HCzQyu/UtSsVzEeGB2QQt5sShsQvngF93I2ihX3RuRvPW6fg/Y4YVXu/5
tkB+zZwQXRmFdogw5WSUuwCs0TDyqGIYBArQ9e1zx5J0cha2KKkTUXHjEXsC3B0x
OsAWtOROKQkUWD0ezY0Hnz39avqZEa3uKBOKK6BPCfHIcdjtVMoURCFka5iqDKfB
9o0+Ed1Qwny+AFtoXGIlhqwVZCXEfdM1cs88Np3+BsK9vJYevKovzDhHuI8yO78P
2uC9dAJuBH8taLtty0KpIm+WVh5XdYi75LSESisMOR4GLicOs/N5uuQepdtYOefb
s3ahtPDXboXbRy7bV9UrCm5vDcnG+WALwyKtSu878wPyDcoe2blNIPPCov7THhMK
9hN8tNSwPt+xkUt8e7mHj1nqTFiSjMmbyo4P15jERK25xPhdDSdHffPIBrr5o4/C
xYAQc8Z8HDibpt2tHPVvmdNd1uKjhPiu5B8tzO9HU5fjBUXI0EI8dFqjHDzN6EFB
geZ6i41lqN9T2VLSsA4jjJri3o5Tb92Jffg8ZMstaYCVMKIYO2sSD2so3/k68sZL
5ArSG5GeMKFhPx51eq5btdZYeoR/F6+7/oxh3J/BuJs7cngKYvq12z9Fgbaf14BL
nB9gxWuJtlBl/raW7clr
=WQ68
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
