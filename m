From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Tue, 30 Dec 2014 17:00:01 +0000
Message-ID: <20141230170001.GO17800@sirena.org.uk>
References: <cover.1414053169.git.moinejf@free.fr>
 <20141229165246.GZ17800@sirena.org.uk>
 <54A19151.3090506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sv7CUYPyUbxygwr6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54A19151.3090506-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--sv7CUYPyUbxygwr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 07:37:21PM +0200, Jyri Sarha wrote:
> On 12/29/2014 06:52 PM, Mark Brown wrote:

> >So, I'm not seeing *any* interest here from any other HDMI users.  This
> >is a continuing theme with HDMI patches and is really very concerning,
> >everyone appears to be working in their own bubbles coming up with their
> >own things and ignoring everyone else's work - what little review I'm

> I have not seen any significant new development since v7 of these patches.
> My comments for v6 were mostly[1] addressed and I can live with these
> changes, even develop this approach further if it gets merged.

OK, so this sort of feedback is really useful - even a qualified
Reviwed-by is useful.  Total silence could mean anything.

> However, as a general note I see a need for a generic ASoC hdmi codec
> abstraction and I don't think this is generic enough. More of the audio
> specific implementation and HDMI standard specific things should be pushed
> away from the hdmi encoder driver (tda998x in this case) to the generic ASoC
> side hdmi codec driver (or library).

This is something I'm expecting, yes - what I don't have is a clear
enough picture of how consistent the different hardware is in how it
models these things.

> [1] I personally do not like the hdmi_get_cdev() approach. I would rather go
> with only a library for registering from ASoC codec component under the HDMI
> encoder device or a completely separate device with only a reference to the
> HDMI encoder.

It does seem somewhat complicated, yes.  I don't know if matches idioms
for DRM somehow?

--sv7CUYPyUbxygwr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotoRAAoJECTWi3JdVIfQkfAH/AvhxX4Sb7Mf5MMIWLdFevna
F79I11qORhxkOPMVUrccJPrN6wzkSqbecH8N3b8wkjqBhlO9h3hI0rfXXKbmqpCd
RTrTBRhQYYHm0zlpy4LhW0HLA11icoj+vTeYEonjn/gr9Vnz3f9bmgDSKfIKjZzr
+j9uyXLGTDCIWG6AkwvAjVq3MZ0H8TtWoNLd/jlmxFJG8tURcW545WQiECUJyzMo
y0eC9j3UWS4oPGxIVx9wjDoBVelY/rtJICYqmYEDkcNOReS/TtZ2JFqQff5RvvD4
fSGao+eEaK9MpkfvEZb3+gRUXt/wznP06wi5FzXCYH0/BD9sHCXMlhcrhUqjeWY=
=uivE
-----END PGP SIGNATURE-----

--sv7CUYPyUbxygwr6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
