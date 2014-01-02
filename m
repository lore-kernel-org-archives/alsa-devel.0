From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compound card
 with DT support
Date: Thu, 2 Jan 2014 18:35:53 +0000
Message-ID: <20140102183553.GG31886@sirena.org.uk>
References: <52C466E1.3030302@metafoo.de>
 <20140101210814.31e3f3a9@armhf>
 <52C4766B.8080000@metafoo.de>
 <20140102102647.6efec89d@armhf>
 <20140102111056.GT31886@sirena.org.uk>
 <20140102124331.2bcfc172@armhf>
 <20140102115618.GW31886@sirena.org.uk>
 <20140102134437.1e39da55@armhf>
 <20140102131045.GZ31886@sirena.org.uk>
 <20140102185055.76eb576e@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rrTeYcb7ueXzDtg5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140102185055.76eb576e@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--rrTeYcb7ueXzDtg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2014 at 06:50:55PM +0100, Jean-Francois Moine wrote:

> No, the 'endpoint' <=> 'remote-endpoint' is a point to point relation.
> Even if the sources and sinks are not explicitly defined, the way
> the stream flows is easy to find: the main source is always in the
> 'audio-controller' node

But the links in question aren't point to point links and may be
bidirectional...

> Usually, the devices don't have to know to which other device they are
> connected, and, yes, the reverse pointer sink to source is not useful.

This may be the case for the systems you've looked at but other designs
are quite common.

> But the way (link) the audio stream comes from may be important to
> know. This is the case for the HDMI CODEC which must tell the HDMI
> transmitter from which hardware port(s) ('reg') it may get the audio
> stream. That's why, the HDMI encoder has two endpoints in its audio
> port, each endpoint being a different CODEC DAI.

Obviously if there are multiple DAIs on a device then it needs to be
possible to represent them separately but that seems orthogonal to the
rest of the discussion (and resolved already)?

--rrTeYcb7ueXzDtg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxbGGAAoJELSic+t+oim9ON0P+gNywqD27n9koJRU7uqcOyLP
AsSKs29GSD0iVzSZ+bovw90olKw1uQK5sfufL7697Wb7iB8LGuNnoNBenbCGKNBl
llUWgZYHFB7FHO47DkKBKXGCPrhCfoVG+C/DKyAicS83onoHt098TUMhU+gt0dWH
d696KKLrDXBpypk39kG7C53eHBNYrX2ZgAFOBKiMEJVezGvQVFzQ4HmOddqFcDd2
sNyuA1YEDgqIICeOCyhmyze45WWfX/0kCL4uWGI8rBUwfEtjExmxdWueX5loKaYX
o4bx56BwJSecQm3N7F8d1v07OK8qj5zfCSjT1GPFvol5vW9DfywviYJx/GZJlGot
c8E4Og50pJXGyEW/+MvV++/YlWrCPRI1ciEFCBRoWuzX56GGh1mMGelAL403Zl8/
+YSxniTRf60CLptoQmw3l3Kw71viaOrh8zw1anawYV0VnGwncDMxJf2oEMZ2jXXK
Vrq2CY3ndmL7ku50v1sJh4oVbaXKSdbO985vfHqMdR2Qs41kHPX8oDhgjkXpcOZ9
pbIJQlQFbzy7FzU9/+EVsSOuxvdtDKt2bg+BBlnesg3ABbFVGStPS/fNoGVf8geX
Ch6V1RWM3pvH8FoB8R7LYYP6nc5oipWWkxWS4KkSSvrlQw/AruEEm5Vsvky6kq6q
T/byhsoSHiE2JBZr52eY
=O2JJ
-----END PGP SIGNATURE-----

--rrTeYcb7ueXzDtg5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
