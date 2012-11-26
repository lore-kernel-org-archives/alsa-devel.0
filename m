From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
Date: Mon, 26 Nov 2012 11:45:11 +0000
Message-ID: <20121126114511.GE9411@opensource.wolfsonmicro.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, perex@perex.cz, nsekhar@ti.com, sudhakar.raj@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, rob@landley.net
List-Id: alsa-devel@alsa-project.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 09:34:58AM +0530, Hebbar, Gururaja wrote:

> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			"pins are not configured from the driver\n");

Since the driver is happy to continue without the pins why is it
bothering requesting them in the first place?  In other words, this
should be a hard error.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQs1ZAAAoJELSic+t+oim9TzsP/0nbB4/m1COerA5f7PpBlxaO
e4hGMgicqIUNXz7JoBJrmHqmo/EbWrHe2b73moOr1D0sgNpFknFRQF9OAlc0oja2
+y2h0ZwqDhHfXMLGvALUctnHQKi3iDjZiNjQWvYx3InWe2Nsw8MU0z0cjtm7JEnb
qnX3KvTGTGNWolkppLteS2dq9qJ1tpAygN7bsAu5JeoQFapChouOVCvxMCHbMxei
bB/nK7LYlliuCmBr9Ngab0n1mfjaRhJltB+HKm27WzBz2N2N/8pLQ/ULzBIOAbJF
s1LMAYQ+zDQNcBN1B57bVnGoUqNao0qr440HJISc6NfgFFzR+g1C/HIPctmEcyBJ
IFaK5KPLNwu6JZU3qWttEzg2pEE889Sm9EHdeHUmSXYT8ney4TZpmIKJpi0Hqw3i
t/ztysorhTySBold0VJj9CmORJnhLaiSfwZeKG8PtHplDm/sSD1g7x/H29lZ70Kj
VNzyp8asi7SKDcHhkjRLbP2CvsMCt/rTWV8CRxMI+bDgKgExdvg6gL0SlC9/O6vG
T0qMwPKyefqF5r3aQpGyRZ67jCjw19jQ9ExdSBzaOfAHYGFBTEgC4HP4h8tr2GhP
jDOdQrPwCxi0JZQ5eiiqirEqwWmwJfLS32TGVfJGu016WpKQ7he0d4zQeWSaVHcw
m1T0YLVDgfrZgaUsQBqD
=ep/H
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
