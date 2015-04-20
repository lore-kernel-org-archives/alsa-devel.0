From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
Date: Mon, 20 Apr 2015 21:48:49 +0100
Message-ID: <20150420204849.GJ14892@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150420043747.GH6325-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 06:37:47AM +0200, Sascha Hauer wrote:
> On Sat, Apr 18, 2015 at 06:34:07PM +0100, Mark Brown wrote:
> > On Fri, Apr 10, 2015 at 04:14:07PM +0800, Koro Chen wrote:

> > > +Each external interface (called "IO" in this driver) is presented as a
> > > +DAI to ASoC. An IO must be connected via the interconnect to a memif.
> > > +The connection paths are configured through the device tree.

> > Why are these connection paths configured via device tree?  I would
> > expect that either there would be runtime configurability of these
> > things (particularly if loopback configurations within the hardware are
> > possible) or we'd just allocate memory interfaces to DAIs automatically
> > as DAIs come into use.

> There is a crossbar switch between the memory interfaces and the DAIs.
> Not every connection is possible, so not every memory interface can be
> used for every DAI. An algorithm choosing a suitable memory interface
> must be quite clever, complicated and also SoC dependent (the same but
> different hardware is used on MT8135 aswell), so I thought offering a
> static configuration via device tree is a good start. Should there be
> runtime configuration possible later the device tree settings could
> provide a good default.

What exactly do the restrictions look like and how often do they vary in
practice (can we get away with just doing a single static setup in the
driver)?  I'd have thought it should be fairly straightforward to have a
table of valid mappings and just pick the first free memory interface?
I'd rather not get stuck with the tables in the DT.  It's partly to
avoid setting bad precendents, we really don't want everyone coming
along hard coding this stuff, and partly because the hardware you
described didn't seem that hard to handle.

> > > +- mem-interface-playback:
> > > +  mem-interface-capture: property of memif, format is: <memif irq use_sram>;
> > > +	                 memif: which memif to be used
> > > +			        (defined in include/dt-bindings/sound/mtk-afe.h)
> > > +		         irq: which irq to be used
> > > +			      (defined in include/dt-bindings/sound/mtk-afe.h)
> > > +		         use_sram: 1 is yes, 0 is no

> > Again, this looks like stuff we should be able to figure out at runtime
> > - the use of SRAM in particular looks like something we might want to
> > change depending on use case.  Assuming it adds buffering then for a
> > VoIP application we might not want to use SRAM to minimize latency but
> > during music playback we might want to enable SRAM to minimize power
> > consumption.

> That's exactly the usecase. How could such a runtime configurability
> look like? sysfs? Or something based on the buffer sizes?

Yeah, one of those :) but probably an ALSA control is going to be the
easiest for applications.

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWYwAAoJECTWi3JdVIfQocUH/i0YtpgbDbRUlDhK+nQdG44T
sGKcAMHbptmWZFydNlmNwmo/d2ldEB0Dy/G5KLvTj879sHGEUVYOpHGcH1/e+cTq
0PwuL6n/Tpm4mKhD8GNSLk3II7LuNmN/DsEE3o30BNpKbpaKdaruVDTRg6tJ3g8s
WVdKTthsJkDSI0rh/Kx2N6+/Li/o8LLPjUonmzcECbuOU2d2N/UWE+y/dskRKxoD
LH6p28k9wPf1cEq3EVSRrEqgFOADqiU1sCqAlp7xFIDGdiiYz/C1CCLT9tISzfJ7
HlvurW9Dde0KBUocdo/j5IPqCjnIDAVRLipoO/fB4taT/cYBiC5LV3DHMEE6iY8=
=VzDC
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
