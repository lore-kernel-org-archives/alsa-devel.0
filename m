From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: zx: Add ZTE zx296702 I2S DAI
	driver
Date: Fri, 22 May 2015 13:36:57 +0100
Message-ID: <20150522123657.GS21391@sirena.org.uk>
References: <1432119972-6934-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4282606926232080845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CCCB3265AEA
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:07:39 +0200 (CEST)
In-Reply-To: <1432119972-6934-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com, zte-lt@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4282606926232080845==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLfVvEQOBD/VeTNx"
Content-Disposition: inline


--yLfVvEQOBD/VeTNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2015 at 07:06:11PM +0800, Jun Nie wrote:
> Add ZTE zx296702 I2S DAI driver

This looks good but depends on the DMA driver and a couple of small
nits:

> +config ZX296702_I2S
> +	bool "ZX296702 i2s"

I see no reason for this to be bool as opposed to a tristate - why not
let people build it as a module?

> +	default:
> +		dev_err(cpu_dai->dev, "Unknwon master/slave format\n");

The driver consistently misspells unknown.

--yLfVvEQOBD/VeTNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyLpAAoJECTWi3JdVIfQ3lYH/jGVN0ZzwI7x+tyEO2fvbx6d
KWi6IZOocjHbDuP5r5R2KKEgrVqo79NkJQ3+lmuUdFTunoob2CB1VrJ9aiTlEPcb
pH3Sbf+wRy+mLy0JNIEvMnZho9JR9mB1Lbqao3DtJsm8jGNx+k7P5M4C4ILVY3eC
UdqBzsW3qFue4Xt8NcshqfyVViLTDSo5mDqbUobrX2BXIsmpvVnHiclm5dtunuGr
g57b5AkTil4hRl8XH9RMrOevDX6U4BkbD52Uf92fyLVeVQNCFEd3viZLNGOF1IMX
YTvcTeaOZNRmyBN+yZXfyIMcbMPHyRuyx7v7ZvgH747/J6utDijPi+FNgM+AyQE=
=jOcM
-----END PGP SIGNATURE-----

--yLfVvEQOBD/VeTNx--

--===============4282606926232080845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4282606926232080845==--
