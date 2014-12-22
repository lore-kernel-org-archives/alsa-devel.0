From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/5] ASoC: dwc: Add devicetree support for Designware
 I2S
Date: Mon, 22 Dec 2014 14:28:02 +0000
Message-ID: <20141222142802.GU17800@sirena.org.uk>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CYcXvPfqKSDi0QhV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9699e11a566938b8d1821f9be3df3276d57cd979.1418826016.git.Andrew.Jackson@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--CYcXvPfqKSDi0QhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2014 at 04:18:08PM +0000, Andrew Jackson wrote:

>  	if (IS_ERR(dev->clk))
> -		return  PTR_ERR(dev->clk);
> +		return PTR_ERR(dev->clk);
> +
> +	ret = clk_prepare(dev->clk);
> +	if (ret < 0)
> +		goto err_clk_put;

This isn't adding device tree support, it's adding use of clk_prepare()
which is a separate change and is normally better done by converting to
use clk_prepare_enable().

--CYcXvPfqKSDi0QhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmCpxAAoJECTWi3JdVIfQnIoH/3TX0VwA90dSlaGB+Beh+Sld
t2FE+Ztj5h+elSIOKE9S2eU0BmnDWT80Vp3RXeV+blAs0juhbRx7H4IPI2pTywtU
EQf8K+R2nuXQ7eCjLCu2+sT1I4S/7QgzrBbcld7xms1OxNvXbW0EC6wuGYlyCref
HLSNu8gB0f1lN/MVbQJeg7GihCvXvScvVhgseXtpRScHzettwbDqvFm5FDnv00OG
l8M5RDpXZYLMwQ/J//EBW31+eEe7Dw7I5t3DxQInBwGm39u5gC15jOA4ueFV4koV
Ff01bBed2f+w47o885FN7lsdAHnoZiGcHwg1Z+++kqjOswfVn9yxYp8zpaGQMO8=
=HWsU
-----END PGP SIGNATURE-----

--CYcXvPfqKSDi0QhV--
