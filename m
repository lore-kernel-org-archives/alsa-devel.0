From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
Date: Mon, 20 Apr 2015 21:55:11 +0100
Message-ID: <20150420205511.GL14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
 <1429510944.30743.36.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n83H03bbH672hrlY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429510944.30743.36.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--n83H03bbH672hrlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 02:22:24PM +0800, Koro Chen wrote:
> On Sat, 2015-04-18 at 18:51 +0100, Mark Brown wrote:
> > On Fri, Apr 10, 2015 at 04:14:09PM +0800, Koro Chen wrote:

> > Ah, so the SRAM is directly memory mappable.  Nice.  But we have a
> > limited amount of it so need to allocate it to a device somehow based on
> > some factor I guess?

> Yes, actually SRAM is only used for the main playback path (which is
> memif "DL1") to achieve low power in real use case. Maybe you think it's
> better to not describe this in the device tree, but to choose SRAM
> automatically if memif "DL1" is chosen?

Since it's directly memory mappable is there actually any cost in
latency terms from using the SRAM in low latency cases (or did I misread
what the code was doing there)?  If it can only be used with one
interface and there's no downside from using it...

--n83H03bbH672hrlY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWeuAAoJECTWi3JdVIfQGVoH/1W+8st7XBLSp2QIzItCAppk
T8Dp5baU7pWKS5zwNwhfGf3i6a+bpb+G+k5ggS5ViiC0Gfic8AH7p6GeJP3I3fYw
gn+utp5mM/yt2kWUeM47GoNbGv1n6eEup8hiYcm9+KmUlT2i/sMb/OpOdv+BrTWI
kpclvGExdq/sxK+PYpDxzt+CIdjuye6LpcOu1TqumeZZ2YGcz6w7tz7JUaFihfCT
5S3JWRRlqnhquRzVHnJIMuWBEe3rSmq5+5qgyKNuFuIRwUVa5JbwOS1KTFmWhInj
i5H8oUEX2WVsPMYISy/pC88gxLVt3VDpEoe1473OyrjFXv2Bipjn2h8jQ+caztQ=
=FzKD
-----END PGP SIGNATURE-----

--n83H03bbH672hrlY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
