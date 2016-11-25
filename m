From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 6/8] ASoC: sun4i-codec: Add support for H3 codec
Date: Fri, 25 Nov 2016 13:58:19 +0100
Message-ID: <20161125125819.2tillw7khiu42epe@lukather>
References: <20161125123442.28410-1-wens@csie.org>
 <20161125123442.28410-7-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6665123836601225916=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125123442.28410-7-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6665123836601225916==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2cwe4dwuj7bfqjzl"
Content-Disposition: inline


--2cwe4dwuj7bfqjzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2016 at 08:34:40PM +0800, Chen-Yu Tsai wrote:
> The codec on the H3 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
>=20
> In addition, the H3 has no HP (headphone) and HBIAS support, and no
> MIC3 input. The FIFO related registers are slightly rearranged.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2cwe4dwuj7bfqjzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYODVrAAoJEBx+YmzsjxAgJNQQAJuM5+OLxQLU6/+henLp2cBs
FfbFBzIge/1LG+GOrI71q93U5D13fOD6lOYahanKzlLEI7MHXz+e9CcTF2N/8l+H
OXC+8fvnwlgvOKNy2+UQRQswOp7KH3EL0ZGFG9pclkemuDhqYIciaEYFnsKWYjWv
0K1cWIQ0IPpwlVerWrWn8iZIl+oRAM2qiuRNkv+1ysdwdEgmkbGpjZexz9xgQoqT
zO3EYG4zJJ/vZcQ97EXM0JiDhtqfTEcQVbszX0uJ/THBMKjGVwWi+cSH4vhvD/3e
5lGyfR2bGYJZx5aXPe52Sk0iD1YzfD5VPb643K8Ua1GVYOR/x4Y8KeLXKE/QB+86
68PnxGfLZ3Gp0oHANC2+3Plouey0huhrmfio52bcD2BQ1wnA9NEGoqmaFo3GF/vl
2n4O/7fR8INu9NX4NeBKBmhRjQx/FIpYGM2AOWZ+j/ZcDaan5CE0xxJOo//7wSK8
mSe23aFr2GVWsvWu4aSQlbwO9MDav/vuSCYddEL29T2RcSd/8D19GWBDrZuvMmBt
cTj0qeNtP3TCm0sArxfIuf+DUvzy2bJj2TpsGMwXHMGImcRGnYywQd/2pr5N833W
EZSCb8UPJFQRJ7yUGsPbvGO6b8mKzgTF7MaVQrMBKBcwwUZ9VC11QHJZGVdTEmfM
HD6GDPivwdUXuIFhYi3z
=L0Gh
-----END PGP SIGNATURE-----

--2cwe4dwuj7bfqjzl--


--===============6665123836601225916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6665123836601225916==--
