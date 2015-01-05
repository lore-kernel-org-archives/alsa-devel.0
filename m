From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5670: fix bit definition for
	ASRC control
Date: Mon, 5 Jan 2015 18:17:14 +0000
Message-ID: <20150105181714.GA2634@sirena.org.uk>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7217415139279486479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C3B260426
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 19:17:30 +0100 (CET)
In-Reply-To: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7217415139279486479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 05:48:15PM +0800, mengdong.lin@intel.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch fixes bit definitions for two ASRC control registers 0x84 and =
0x85.

This appears to do something more or different to fixing definitions -
if it was fixing I'd expect to see equal numbers of lines added and
removed in blocks identical apart from some numbers but this appears to
be adding some new definitions like these...

> +/* ASRC clock source selection (0x84, 0x85) */
> +#define RT5670_CLK_SEL_SYS			(0x0)
> +#define RT5670_CLK_SEL_I2S1_ASRC		(0x1)
> +#define RT5670_CLK_SEL_I2S2_ASRC		(0x2)
> +#define RT5670_CLK_SEL_I2S3_ASRC		(0x3)
> +#define RT5670_CLK_SEL_SYS2			(0x5)
> +#define RT5670_CLK_SEL_SYS3			(0x6)

=2E..among other things, and this block here:

>  /* ASRC Control 2 (0x84) */
> -#define RT5670_MDA_L_M_MASK			(0x1 << 15)
> -#define RT5670_MDA_L_M_SFT			15
> -#define RT5670_MDA_L_M_NOR			(0x0 << 15)
> -#define RT5670_MDA_L_M_ASYN			(0x1 << 15)
> -#define RT5670_MDA_R_M_MASK			(0x1 << 14)
> -#define RT5670_MDA_R_M_SFT			14
> -#define RT5670_MDA_R_M_NOR			(0x0 << 14)
> -#define RT5670_MDA_R_M_ASYN			(0x1 << 14)
> -#define RT5670_MAD_L_M_MASK			(0x1 << 13)
> -#define RT5670_MAD_L_M_SFT			13
> -#define RT5670_MAD_L_M_NOR			(0x0 << 13)
> -#define RT5670_MAD_L_M_ASYN			(0x1 << 13)
> -#define RT5670_MAD_R_M_MASK			(0x1 << 12)
> -#define RT5670_MAD_R_M_SFT			12
> -#define RT5670_MAD_R_M_NOR			(0x0 << 12)
> -#define RT5670_MAD_R_M_ASYN			(0x1 << 12)
> -#define RT5670_ADC_M_MASK			(0x1 << 11)
> -#define RT5670_ADC_M_SFT			11
> -#define RT5670_ADC_M_NOR			(0x0 << 11)
> -#define RT5670_ADC_M_ASYN			(0x1 << 11)
> -#define RT5670_STO_DAC_M_MASK			(0x1 << 5)
> -#define RT5670_STO_DAC_M_SFT			5
> -#define RT5670_STO_DAC_M_NOR			(0x0 << 5)
> -#define RT5670_STO_DAC_M_ASYN			(0x1 << 5)
> -#define RT5670_I2S1_R_D_MASK			(0x1 << 4)
> -#define RT5670_I2S1_R_D_SFT			4
> -#define RT5670_I2S1_R_D_DIS			(0x0 << 4)
> -#define RT5670_I2S1_R_D_EN			(0x1 << 4)
> -#define RT5670_I2S2_R_D_MASK			(0x1 << 3)
> -#define RT5670_I2S2_R_D_SFT			3
> -#define RT5670_I2S2_R_D_DIS			(0x0 << 3)
> -#define RT5670_I2S2_R_D_EN			(0x1 << 3)
> -#define RT5670_PRE_SCLK_MASK			(0x3)
> -#define RT5670_PRE_SCLK_SFT			0
> -#define RT5670_PRE_SCLK_512			(0x0)
> -#define RT5670_PRE_SCLK_1024			(0x1)
> -#define RT5670_PRE_SCLK_2048			(0x2)
> +#define RT5670_DA_STO_CLK_SEL_MASK		(0xf << 12)
> +#define RT5670_DA_STO_CLK_SEL_SFT		12
> +#define RT5670_DA_MONOL_CLK_SEL_MASK		(0xf << 8)
> +#define RT5670_DA_MONOL_CLK_SEL_SFT		8
> +#define RT5670_DA_MONOR_CLK_SEL_MASK		(0xf << 4)
> +#define RT5670_DA_MONOR_CLK_SEL_SFT		4
> +#define RT5670_AD_STO1_CLK_SEL_MASK		(0xf << 0)
> +#define RT5670_AD_STO1_CLK_SEL_SFT		0

removes a lot more things than it adds, with different names too.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqtUpAAoJECTWi3JdVIfQPtIH+QGjSe4Jz05qqTU6av/EIGko
wrSDzp72uEPwdTD2EjzGaUxJjQTk5wbgEp9/gy6DHa6u5lG2grVvnSOwhwTKHGxx
aa3lqrtyjVYU6XZwxu0GiEaUqYxAvlOOuHdFlRznoAs4h7UXm11/cnp7d4Reme2D
bn6wXw6ZthOjHaEXPyBD1Pc3gMulkuyCSgXI9y7ZSWb+gzHgXAM5N5Lr0muG3ymy
fE5pVGWGgT3NySUkScYmBDZGepCYQ7nKwPl1LvlgR7ZAz38b8IHdDdmpn07cAApw
kmaIKWmSSj+7MPCj45b9pXFalcEWjM6gtU8ZSl5zMyVFWU/vC07Snj/6MUMg7Mg=
=5M+I
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============7217415139279486479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7217415139279486479==--
