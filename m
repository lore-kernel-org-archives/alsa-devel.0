From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 28 Jul 2016 16:57:32 +0100
Message-ID: <20160728155732.GG11806@sirena.org.uk>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hX3v94LCWtOgt2h1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469660568-3511-1-git-send-email-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--hX3v94LCWtOgt2h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2016 at 04:02:48PM -0700, Nicolin Chen wrote:

> The codec driver should control the mclk. So this patch adds this support.

> +	/* Check if MCLK provided */
> +	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(rt5659->mclk)) {
> +		if (PTR_ERR(rt5659->mclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		/* Otherwise mark the mclk pointer to NULL */
> +		rt5659->mclk = NULL;
> +	}

This device seems to be used on x86 systems so we'll need to ensure that
they register clocks for this.  They really should set this up using
quirks keyed off DMI information or similar so it's hidden from other
systems.

--hX3v94LCWtOgt2h1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmitqAAoJECTWi3JdVIfQpp4H/19ATmfl1VRcjaF7lc14wijU
bFCBPOLgOTZLlYWp5hY6Q+5ppTZxbheQ0X7uVzXMGt2Sh9OarDa+/J2wZ3XSDfFf
ENQ3FdNab2llVZns0qw/nuEhQyVQnJnJndD6KGlY5l5ESXUUr4Emy7Pi8Z95rTXG
TBc1vpgNFN6PA4UsugDdGO8Zwn10y9cAVYZnQ+6R4cb4Otic+emugOlgN1K5WxXd
yN9LqJoRynOj+b/a3AuSe2Y++4pHD7jmGD+gf0MeLz5nz6QhPYyuvx2lSSXhhcC7
/kIZ1WcusOs1WzyI2PAt6Dwx6NzFoKpe6m0/LrR0ORB58pL2u6y94SFh/HIa0Aw=
=t2qj
-----END PGP SIGNATURE-----

--hX3v94LCWtOgt2h1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
