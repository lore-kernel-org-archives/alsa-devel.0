From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compound card
 with DT support
Date: Thu, 2 Jan 2014 11:10:56 +0000
Message-ID: <20140102111056.GT31886@sirena.org.uk>
References: <20131231113138.102044cf@armhf>
 <52C466E1.3030302@metafoo.de>
 <20140101210814.31e3f3a9@armhf>
 <52C4766B.8080000@metafoo.de>
 <20140102102647.6efec89d@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80TIu+lzzbJOSSak"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140102102647.6efec89d@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--80TIu+lzzbJOSSak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2014 at 10:26:47AM +0100, Jean-Francois Moine wrote:

> 		/* audio */
> 		port@1 {
> 			hdmi_i2s_audio: endpoint@0 {
> 				reg = <0x03>;
> 				remote-endpoint = <&audio_hdmi_i2s>;
> 			};

I think we want an explicit object in the card representing the DAIs.
This will both be useful for making it easy to find the configuration
for the link and will be more extensible for the cases where multiple
devices are connected, you can't just assume there's just two.

--80TIu+lzzbJOSSak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxUk9AAoJELSic+t+oim9ZoQP/32WdN9fvE4C0EOXvdX2OpIt
yk7u8N6LPu9kRMHnCTtPkhLSFNLEHdV39TIABCnVXCPIwi/o+l2pJkkn/n5dvWqE
XgLXaX7mhjuMZv46u/PDAonHu5uWLHk415WJ3pQHMHVQ/ppfO/wisLhVQuiIWRZg
Ec6E59MuUmqiys81QsYvB1qaq/+FCdUjt0b7KcAPUa7Y2r+CL3wNeY4Vq6gSersi
QitXbOCIl/53r6AN7bRSBIgKr0VcYXWXZfoXpaW8k2ivs+J6ELXJN3+qbSFEol48
ybj1+WBRhMjFmQSrIysvJLgqOISCqasbiotWd5iYzc4FJUNvcYOHDXHJZcdHX2xO
/DVmXXnG6KgBGPV6q2i8IY+IUXXyctC4MsxE07l0btSlfhgaAquZwxtNYUITWXXs
0CW2XQ2X3JIYshTw1PPAjgIFbP29AplWlqmnkbHr9tfRzdrvJW8E7bjO3y0QzYnn
KWSeofC1k7sZxDtZSQMZUm3RT+1ET28C4xRz5ZmA2gjwAFcbw5RQUYbbjz8UDkA+
oDngL1z3Iw9hQjVaXC7ZSYBZXPDHb373xRT0tCheE5c0BNbiQVW4WQlOmLYRj5Og
ippuvWmcWBKidQ7+Mha8/3R/Tiw96xTEWcr6YtdqnSNuKoZXLw9P8nE/VezrdpsP
z0F6KWUMn4ITLNFYf2pQ
=x2//
-----END PGP SIGNATURE-----

--80TIu+lzzbJOSSak--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
