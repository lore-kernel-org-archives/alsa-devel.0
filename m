From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
Date: Mon, 26 May 2014 14:29:46 +0100
Message-ID: <20140526132945.GY22111@sirena.org.uk>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQjj8pZWZgZH7jIp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400772710-23523-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--XQjj8pZWZgZH7jIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 05:31:49PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.

Applied, thanks.

--XQjj8pZWZgZH7jIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg0HGAAoJELSic+t+oim9whQP/iY0xc7b2E9yOASL0vHUehIU
QJFfRKg0DIi+hJ5dPL7ri4tvmQwQkp9B0JLsyQxOSN3uPlVdsH2s85fRIKW4PO/0
WsGadCAg3kQOlFYLYUPkbGsFdmFQ1iFvUCkRvRunOEllQXiRPSWSsxg9klt8XioB
bGreT0Jm8ZPRsCnfPgP3ssOmGb+ZIaJLpruk2Rq+dfy0k3wiN5QoIQ1LiMqlvq/L
QIV1Oz2yvKsjs2hWYysCOzS/rC3r50O9Q/M2Ly14FuDVyw9e8XIg4zdq5XGrgA7h
1rlSjuFvjkwJMt66h0vKcobnj4HMuEpNMgVykELXHA2LQg1sfG/+IlxteZqzVzGm
qqJ6ckK64Voq/MgD1bobciqUlpm0bnHfoh3rpaQwRs+7gukOfAIQf8c40hiBXEAA
2SVYJ4wX+Ed9Pi+zi1W4JDwpSnXMZUWWM/hYU97m6qUNXOaK1w6ABKsxesT03Jxd
ihsWDp7YkAfT0TaZCgV0hxK3cmwOMkDXoqWSdpP05W5yXYcO4BG0ev/bA/mtPDT8
jEE10Td2MmHzQk0uu4bCnE343x/5F3iElprce1UNefweH0Q3ULu4VrvHY8mDnfYQ
+IqjD6WWj0tGbVkQ1PHsc7qBamvaNgQi9npK9HMc/LTOil4QjvRhy0O5qStS1MxY
N3SmQLWXzHyXw+FAzZKW
=Wcmt
-----END PGP SIGNATURE-----

--XQjj8pZWZgZH7jIp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
