From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Tue, 24 Sep 2013 00:26:48 +0100
Message-ID: <20130923232648.GL21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <5240B07C.6080404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HFmY1QOi3uof3bwe"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5240B07C.6080404-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--HFmY1QOi3uof3bwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2013 at 03:19:56PM -0600, Stephen Warren wrote:
> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:

> > +Required properties:
> > +- compatible: should be "linux,simple-codec".

> We shouldn't have any Linux-specific bindings. It might be reasonable to
> define a binding for a "simple CODEC", but there's no reason it should
> be Linux-specific.

What's the vendor prefix to use then?  The same thought did occur to me
but I wasn't sure what to suggest instead.

> > +- dai-name: name of the codec

> That should be internal to the driver; it's Linux-specific.

I do think it's reasonable to define a name for display purposes however
this binding doesn't say that, I did say something to that effect
already IIRC.

> > +Formats:
> > +	"s8"
> > +	"u8"

> I think the binding should specify on-the-wire formats, not in-memory
> formats. For example, if this binding is used to represent an I2S CODEC,
> it's more important to know whether it supports left-justified,
> right-justified, DSP mode, etc., and the max number of bits (or perhaps
> a list of supported numbers of bits) per channel in each case.

I didn't query this myself since my expecation with this is that the
rest of the wire format properties will come from the binding that pulls
this together into a card (since this will need to be set at that level
for other CODECs which are more flexible) so I saw this as providing
additional information which would normally not be fixed at that level.
Arguably this could be pushed up there too, though it's not normal to
fix the word size.

We should really be defining things like signed and unsigned as well as
the bits per word since they do make a difference, though in practice
you very rarely see anything except unsigned and some of the formats
listed don't seem to have ever even been used in Linux.

--HFmY1QOi3uof3bwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQM41AAoJELSic+t+oim92dYP/RLX3XsgPH5/BRGHR+/WiZI5
Dp+yxiPFwtkA7KkPPBJ9UxbK82QFqc6o2W2/5t7753ZR80x0raFVnc9yCf1WKzb1
L8+uA+2vnUFx31MxPr61UVd7BZQj3YO6L+u/sAqoe1wklJg5XE6tpuD9Ww1kBBEH
PlP5I6OFiUCI0202F434T2tN1M5WOwH/zTTG/6yFM34CN0RCODoBQWx9gxcU5um8
rVagN2taYQ4fDX415OCnI11caGoOgg1n91qN989X9m/VmM3dMTiM0roSUM15BwGK
oHycBsxeR9JbQ0mI2MDaVBaDWkOrB4t5ggVZr3pkZppcEnv5nhCCD3NsUJEFK1PY
XdRz5W9HptU1mG1X83xLHLPNRVusfGubu5NNLJq9fXLZD83l2swCEExmF9SBQT+0
N5eYVfPuNZS/42wl7JIxUZRR5gNOp49Ehbt0jwLXX7+i2aBmwK2y2WQIu54qXLkb
QtjvtrajMFiNI9RPqhRk9fdOeWMZPhQaO2lpsNaMm7CtUHI37gHokSUC0lR3EBXn
aT0hX3SiKSRPKZDOvzbrmRiYqHQvUHrpD0hAk4eN8ojmWnx/RdOyKYbCW5c76+Cs
SdaKij+kuSc4ZcwHYJJWwcleyiqqrlJQG6SRBjW6H6FUm2gIOBgAwK3Nx9pqeyfc
ED5GyvMocx/1pH33pueR
=p3xX
-----END PGP SIGNATURE-----

--HFmY1QOi3uof3bwe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
