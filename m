From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Wed, 11 May 2016 21:50:52 +0100
Message-ID: <20160511205052.GU6261@sirena.org.uk>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511150937.GK6261@sirena.org.uk>
 <65bdbaea-fe4e-bbd5-335d-a8d594936cbe@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JcGvecxLhm+LytDG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <65bdbaea-fe4e-bbd5-335d-a8d594936cbe-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--JcGvecxLhm+LytDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 11, 2016 at 10:12:56PM +0200, Peter Rosin wrote:
> On 2016-05-11 17:09, Mark Brown wrote:
> > On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:

> >> This driver does not support sidetone since the DVST register field is
> >> backwards with the mute near the maximum level instead of the minimum.

> > Why would that be an issue?  We support volume controls in either
> > direction.

> I asked about this last week (or so), maybe that question explains the
> situation?

> http://www.spinics.net/lists/alsa-devel/msg49675.html

If you don't CC maintainers the chances are your mails just won't get
seen...

You should change DAPM so that it understands what your control is
doing, possibly by using custom accessors though it seems like something
in the vein of the invert flag ought to do the trick.  You don't want to
actually use the invert flag since increasing values do mean increasing
volume but something along those lines.  Possibly doing it by parsing
the TLV for a mute value at probe time might make sense?

--JcGvecxLhm+LytDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM5srAAoJECTWi3JdVIfQSlwH+QHYeaXljwmyRmDYmlAWP9Eb
QXi7Gk+LYSlR0vh705aOGdi9oK3cWGEK7MA9yzex9hSB6gRMQsXLdSgVoHU92WWJ
E9WZSeTXuszSMEvqIOCGp6QaSA8HFMeH9ZzwOgOS9CP6pR+KBvJ/BZv4maUbcCw5
l0dYUdwSaR+Hrm2iwcpTpllIlRvXtjryYJSIYATGMChs73o67GUxnv5YR9NH9x8I
79HnhjOGTV77SHwJIRrdOgIxIk5I6hbsjCClr8y/vm/AHsoj/ROImVaL14Qn+OCD
+H6nGgTdzDQQUl0LcHnnU4wVFx3tsJhpopjtLkXlZN6HdS1IiKyLQ1UHRNVAWCU=
=oSLw
-----END PGP SIGNATURE-----

--JcGvecxLhm+LytDG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
