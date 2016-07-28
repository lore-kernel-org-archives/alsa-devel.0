From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 28 Jul 2016 19:55:10 +0100
Message-ID: <20160728185510.GK11806@sirena.org.uk>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TOmSpbqtysumMR8M"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728181419.GA4742@Asurada-Nvidia>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--TOmSpbqtysumMR8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 11:14:20AM -0700, Nicolin Chen wrote:
> On Thu, Jul 28, 2016 at 04:57:32PM +0100, Mark Brown wrote:

> > This device seems to be used on x86 systems so we'll need to ensure that
> > they register clocks for this.  They really should set this up using
> > quirks keyed off DMI information or similar so it's hidden from other
> > systems.

> Hmm..the change defines this mclk as a optional property so I'm
> not sure how it would affect x86 systems. (Would love to refine

Ah, clk_prepare_enable() silently ignores NULL as an argument?  It is a
bit messy to do things that way but might be the most practical thing.

> it to make it impactless.) Since it's literally hidden, any way
> that I can manually ensure it? Or just wait for an ack from x86
> developers?

Hopefully they'll speak up - we're in the merge window anyway so it'll
be just over a week before this can go into -next.

--TOmSpbqtysumMR8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmlUNAAoJECTWi3JdVIfQS1AH/jeGgAeHfelIpv3tYLOsD2io
07BRxA0nw3CDO9PdU3/ue75D0PssZ6SDL2g++5EDhd/us3xMbT8XhvciGnGIDFXa
HOylb297yCqQnTQHVc7YW1YgyrPtj/xdnZ4W1Bst6eyzDG/xxuEeHaD7JV4jpsFG
q58h/lplY1Bfvs2mGHg8/ES+ZUH87K7Z+1EXdFZPKTUyl6Pe50lNUY4xp/y1s2Ou
O/aHwyYUBTYRdFJO9hbAJHIkef2DFO/QA+UgOo+vGUVelD83vvbjMXJICVj2ui2y
mtTYD1B2ng8VGpuswgN/WP5GUIP1LqoM471Hzs5S1CVOJuklBmweEAMU26rZWGs=
=/irv
-----END PGP SIGNATURE-----

--TOmSpbqtysumMR8M--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
