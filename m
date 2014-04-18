From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] ASoC: simple-card: Support setting mclk via a fixed
 factor
Date: Fri, 18 Apr 2014 17:38:49 +0100
Message-ID: <20140418163849.GJ12304@sirena.org.uk>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wclo/YjJlGo4VkIX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397749994-24983-5-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--wclo/YjJlGo4VkIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2014 at 05:53:13PM +0200, Andrew Lunn wrote:

> +- simple-audio-card,mclk-factor		: Multiplication factor between stream rate and codec
> +					  mclk.

The normal name for this is fs rather than factor.

> +	if (priv->mclk_factor) {
> +		mclk = params_rate(params) * priv->mclk_factor;
> +		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> +					     SND_SOC_CLOCK_IN);
> +	}

We also need to consider what happens in cases where a clock is
specified via the clocks property.  I would expect this to be used to
set the rate for that clock as well.

--wclo/YjJlGo4VkIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUVUWAAoJELSic+t+oim9FngP/jVTqF60anxTwol+iyGD2syf
bzMQhon39+z3dPh76NR/jpbgWjQRRjW0OWJIrvCV5ype9NAPHoibx09J0gZ4Dhbw
fpL3F7zyACRSRVaTQIpNWCXb4oS4tND+ellK75ydhDL99b03/XuRskj0jqVOe9JZ
Fq9uWF65rcX5u7RQQVfzKbxTTmIB/STlaZ22xK9RTrnLcAaSu99ewK+57tRpfKW3
yLIISbDdIqcBtw0KbkDiYSXJk5yjRUb3MXN2Tc9St5LRCJMGSCHSGrSEM+wUxm3A
tqN2X/4AqO9vJbkrog01WfvyzoqNDyFzehU6PjTDSM/oDJoXPyjj4Y5MZSCfcyZN
s2xgfH9NJxFaK3pZA8VtHWAqdwalImxmNxECF2FKQeVFHvfSd6WrBPbPFi+LlISq
3I7Gd3x6TW3SIX1kkoPdX3SHvd5oeJRptb6tUoefM8xT+qupUb2BgB2pw3UEXGED
a4KKx/3YcO7A84lDMug/NHPj7c0Y4he2a86u/STNxOC2kydhtbX2TC1EEnkdY/m1
lxy7oykwr/p2IM/QuQZXdApYOWkOitEINDwfkttbrXCc70NBG9rnVDFqgS9G4zri
o1snvpBq1hyQ/wgaDNIEfrdA475LTq3nvQm7po6AJgYFl68e6Hbi3YEjoFJq+ZYq
5bLDCiqPJotOBQ1WZJj1
=yAvg
-----END PGP SIGNATURE-----

--wclo/YjJlGo4VkIX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
