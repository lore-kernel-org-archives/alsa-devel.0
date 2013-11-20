From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: simple-card: add Device Tree
 support
Date: Wed, 20 Nov 2013 16:02:03 +0000
Message-ID: <20131120160203.GI2674@sirena.org.uk>
References: <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g@mail.gmail.com>
 <87li0ldso8.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+ZsrU5S6B_V8ruLK141LxTR2fd9Re5EWmp47LY+ALDow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N9w8F9fpXfXEoJS4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ZsrU5S6B_V8ruLK141LxTR2fd9Re5EWmp47LY+ALDow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--N9w8F9fpXfXEoJS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 08:20:19AM -0600, Rob Herring wrote:

> Second, you need to define in this binding document what simple means.
> What properties of the audio subsystem make it simple? The h/w has and
> doesn't have what? How do I decide if my platform can or should use
> this binding?

I think it's reasonable to just say that a simple device is one that can
use this binding and that if that is not possible we need to make a
taste based decision at the time between extending this binding or using
a new one.

--N9w8F9fpXfXEoJS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjNz4AAoJELSic+t+oim9r2UP/01+tI0TXW3mSkKqWrLlaE5c
LoBz6+Z34jcITekHjX+sXvgRhFYV6qmBsnQoB664vXpmMMXQ8mIki0oiepX/++hk
TgJdv1vRdsEA/sxkf5OMmSSq0qAJlEMv7IwLbSGBmyIfNuFgQOZrHAe/WgBIdgz9
2Wo7lnrDV3CYSUG8LtwU9m7otU0dUZrquoRGUMklyLTw14tM8FmyQZ0HIMl3GtzN
ezPmF6/Xvd+L+JxdVG8XoMtZCPjMW+BQRkceLwpCqw+v33gN+oEjcXv0pVOwHogM
EKRRNcImJIvO3mLnSgiHiFE2XYCl/kajUylZHKIVblYBke2bT5ldqaApuWJ3Dw9u
WNj9jDpqPTd/XluH7GV9nX3ylyZOeRibwQPR+8///a9X4676OXF9AAB6gQji98dp
E/b9zknEwG6kcMSoUZCyc3doCB8H7vgdAIhqbyz675AGAIEXp+jVtYUWeFAPPWze
1arFZW7ZMEzfQgOrKlzpQHPsDYanyAYrlA5hgNkYA6yB095V9pZzC2MJ471a5Dws
JTYeGUfjgj5hwaC3ghNF3WKYCUa9H6Tv8hbO4fODaTUO6W1XSzl927mg8dcpTl9S
pvZKbRnarIGh1qtJYxSdllIuYT274GFWLYgGalLj/jQuQatFmem7RwPA+KJhu0yN
R27prZjTtOA2tcb6P6Kj
=PDlk
-----END PGP SIGNATURE-----

--N9w8F9fpXfXEoJS4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
