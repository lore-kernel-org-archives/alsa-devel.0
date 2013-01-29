From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASOC: wm8962: add some operation in
 wm8962_runtime_resume()
Date: Tue, 29 Jan 2013 17:39:29 +0800
Message-ID: <20130129093926.GD32597@opensource.wolfsonmicro.com>
References: <1359445810-2105-1-git-send-email-b13634@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847182293773443636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8BCD265D56
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 10:39:39 +0100 (CET)
In-Reply-To: <1359445810-2105-1-git-send-email-b13634@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gary Zhang <b13634@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1847182293773443636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 03:50:10PM +0800, Gary Zhang wrote:
> 1. in this function, after wm8962_reset() is called, WM8962_SYSCLK_ENA bit
> is reset to 1. make sure it is off so we can safely write to registers if
> the device is declocked.
> 2. add bias level management

Split separate changes into separate patches; obviously there's bias
level management in the driver since otherwise it'd be totally
non-functional.

> @@ -3721,6 +3721,24 @@ static int wm8962_runtime_resume(struct device *de=
v)
> =20
>  	regcache_sync(wm8962->regmap);
> =20
> +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> +				WM8962_SYSCLK_ENA, 0);
> +

This seems like a bodge to work around some other problem in your
system.  The device should never be runtime suspended with an active
clock, and this seems like it isn't going to work as most of the
register cache restore will be done with SYSCLK enabled.  We need to
figure out what went wrong to allow the device to enter runtime suspend
with SYSCLK on.

> +	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
> +				WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
> +				WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
> +
> +	/* Bias enable at 2*50k for ramp */
> +	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
> +				WM8962_VMID_SEL_MASK | WM8962_BIAS_ENA,
> +				WM8962_BIAS_ENA | 0x180);
> +
> +	msleep(5);
> +
> +	/* VMID back to 2x250k for standby */
> +	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
> +				WM8962_VMID_SEL_MASK, 0x100);

We already have code to ramp VMID when exiting _OFF...

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRB5jBAAoJELSic+t+oim9Hu4QAJaEKGQu1zH1Ne+9eRNBdJUr
wZ1U5ga7OeYNLUcyksuZhepV97tKGYQhQYPkNXD+CLT7e4oHbMbYk6/E3tPRHozR
GMbFAaa80uWsxQUERaAvEL/2dNmC3M30PraWPTICZcGnbJr8jeE9QhNLRZLTQX4N
BsMJa1ZhfGjit5d+U0lHvp3Pm9uiUW0Vzpp5luSshWZlRr3k523N/aTsdy72ow+B
W6NldaJl29mSj5cy3l2NfF5gNt8/l49kIafeCSCvxCIqOIC160/LWKl/r1MtJJJ+
NtIc2CT0Da0EhARlZiBpyZR5AhGbpWyhINY1H6guBLJEHj60gq//uflkAQ0ahbHT
z3Mh2Va/EPgw0qlMiewrSB8SydhblI548KkE+helK4AMMfwiauNwj+OaePrfo6mH
rQS8DazOMetBD3nbXr5/QWmuoUa25dnj+gZMRzP8bwSq4H83kZMoIdX5twPnEy05
nHTJokFD8VPR5sHgcRlygm7Kgta6F1lzhczNwFGpPwqBPK7oJiTyyqLpFHAt31at
IUzMiH76QQEp2zwlWRtZ/ERv8u1f0UM06hG+FulddWdmjIfJL2Twqkxak1eejvrs
h+fwTC4rpdF+9WQzDb79FYSIQpPz7uTnNelcibRdBQorxjDErVW4MbwoRQB3R6qz
+ipPicCBxCoRtmr7OUTX
=1baw
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--

--===============1847182293773443636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1847182293773443636==--
