From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 PATCH] ASoC: wm8904: add CCF support
Date: Tue, 25 Mar 2014 11:27:16 +0000
Message-ID: <20140325112716.GS2269@sirena.org.uk>
References: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjXtncIm5b3tWrFJ"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, b.brezillon.dev@gmail.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--qjXtncIm5b3tWrFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 05:56:56PM +0800, Bo Shen wrote:

>  	case SND_SOC_BIAS_ON:
> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
> +			if (wm8904->mclk)
> +				clk_prepare_enable(wm8904->mclk);

No, this shouldn't depend on COMMON_CLK - there is no reason other clock
API implementations shouldn't be able to use this.  Providing a clock is
something you can only do with COMMON_CLK but using one doesn't need
that, generally using a clock is done unconditionally.

--qjXtncIm5b3tWrFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMWgRAAoJELSic+t+oim9jqYQAJ5XEBE3KqJnVT5AXdHY6ADi
Tk77VY6CILaH44b3BSFervE8d2OR0T5cxCWNxcIIKc660OUoejLK1j3f4HTlrer/
NE230e3IUpuVIivYZCMcVwwx1lnt3VPPYVjuD8YxtfAqcX8MYAHggDDIQTljPLwE
FmAqcsnWTxCv1eugKDS8ZwWCe65niQHIHvoM+i/KoF2ggZYoa79Ap9SPRyoYCgeo
beT+a7FUbfZU0nDhCzIjTDRDcvg17Q5pfQlacpiAlRPSshtKT7DrwemCwyRXd/DN
mfEP5DmQ0GWlGeEngdP9mbEt45s6MQsiIwc6OP5F432OgqhcG6hkay0zYEF/Wc5r
oiIkTtrg1cDb5ULDckLCN4wu3/mAAEwyHHVr1Ehca1WaTt7ATfy1qoN+pvNPzR6Y
vSr7bnlLjgG+K2uvJpg8VjHVB/RT01wDijtTM/5IpPwkYSEyvh0QTCl9A5T6D3VO
03aDjJSIDo+84RwDPcYMZs2oo/keujdveW5XDzUHm3aGErucsvit1V638MEoi19g
jnS7eQ0BD1exPPFNopGKXkPNpeHrRQbFbJbKQ/I2M6Qhl1LKAeR5lN+zbLEGW9Jz
wpcyJTdCEAgENj9K/6JK9I72eKlQAeTnzj7eX1dz+SQzlV3NGtWUj1GM6Ko9shzk
Hvx3DdTz1PEfcVzw4iV1
=MhRW
-----END PGP SIGNATURE-----

--qjXtncIm5b3tWrFJ--
