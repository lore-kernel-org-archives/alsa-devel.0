From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Tue, 11 Apr 2017 15:32:50 +0100
Message-ID: <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xf4hkaj5rntmryw7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--xf4hkaj5rntmryw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2017 at 02:48:32PM -0500, Rob Herring wrote:
> On Thu, Apr 06, 2017 at 05:40:35PM +0200, olivier moysan wrote:

> > +Required properties:
> > +  - compatible: Must be "st,stm32h7-i2s"
> > +  - #sound-dai-cells: Must be 1. (one parameter)
> > +    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
> > +	index 0: playback DAI
> > +	index 1: capture DAI
> > +	index 2: full duplex DAI

> Is this still needed for graph-card?

The graph card is blocked on your review...  I'm also not clear how
without something like this we'd be able to identify a specific DAI
within a device if we don't have a way of identifying them.

--xf4hkaj5rntmryw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljs6REACgkQJNaLcl1U
h9DvSwf/SV5fjMks9E8EZVSVPm1PW4Dz7TAWARzaXB0ilz1afkWEHBpLMWrhVey5
IVsgFpoIfLvukv75HdYpSE2dK61unHag+SyiO1DhrBA93gphwDYFP8b46ttOSCwE
U/z+aSosVbTFMcEb5MdWzmo5TTDLadhRhgR3GN0YCCvjFzJi5lCJJYYhUa5exgaL
PrOBFT3aJ78clhMbq41WGPoYX9nUy8/121JZxGMyIMqjIn0Hmsgxe0qXJA9eo5Eo
2yXIpjNBDLYxAewi9K8dUtk+k6jGgBdksKPeT3W4prmlenSlew2pv2HM6cpfDUzV
nIeAr5VSJSmUy+VrjCk6metO5t6B8g==
=+XnT
-----END PGP SIGNATURE-----

--xf4hkaj5rntmryw7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
