From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings
 file for CS35L32
Date: Thu, 31 Jul 2014 21:21:49 +0100
Message-ID: <20140731202149.GX17528@sirena.org.uk>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <1406664163-10506-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bYrG818GTFYOcDzy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406664163-10506-2-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--bYrG818GTFYOcDzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 03:02:43PM -0500, Brian Austin wrote:

> This patch adds the devicetree bindings file for the Cirrus Logic CS35L32 Boosted Amplifier

Word wrapping in the commit message please.

> +  - cirrus,sdout-datacfg : Data configuration for dual CS35L32 applications only.
> +  Determines the data packed in a two-CS35L32 configuration.
> +  0 = Left/right channels VMON[11:0], IMON[11:0], VPMON[7:0].
> +  1 = Left/right channels VMON[11:0], IMON[11:0], STATUS.
> +  2 = (Default) left/right channels VMON[15:0], IMON [15:0].
> +  3 = Left/right channels VPMON[7:0], STATUS.

> +  - cirrus,sdout-share : SDOUT sharing. Determines whether one or two CS35L32
> +  devices are on board sharing SDOUT.
> +  0 = (Default) One IC.
> +  1 = Two IC's.

So, this was all a bit non-obvious but I found a datasheet so was able
to figure it out.  The device is using the I2S input channels to stream
monitoring data back to the host and can do this in TDM mode.  That's a
bit fun, and would ideally mean we'd have to play with hwmon, but it's
possibly better not to worry about that for now.

Looking at the datasheet I also see a VP supply which is omitted from
the driver and bindings - in battery powered devices like phones it'll
be connected directly to the battery so have no effect but it's still
better to represent it in case someone wants to use it some other way
that does merit software control (eg, a system running off 12V batteries
will need to regulate it down).

> +  - cirrus,gain-manager : Audio-gain management when LEDs are active.
> +  0 = (Default) Automatically reduces audio volume once by 3 dB, only if needed
> +  to avoid thermal shutdown or current limiting the boost converter.
> +  If the condition persists, the CS35L32 examine s ILED_MNG and responds accordingly.
> +  Audio recovers to original volume automatically at the end of the LED event.
> +  1 = User controls volume (nonautomatic).

This looks like something that should be a runtime control.

--bYrG818GTFYOcDzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2qVaAAoJELSic+t+oim9wnQP/20k7m0/PxJuQufxO7VON+xr
TlSlumKqGXc1Dkv5Ld7MlRy6dPy0pjV0oox8hSvDCs4fC55v63it9QEjcYoULZu9
B9ToSKMOLvapKmCeFw3WpH/MABnJ7WlUxF7V9UIQbOPcsvUSnsH+/U4VH+n4VgFv
QLUxMjAvSc03X45hmtoAZklq+A5xM3VDnCrqs8yTb7G6FhY5crVfVBEPFi6JaSOR
apn5IE13pfH7Hkiq9GtW/5HUQm/H3Uu5ktHcHn2VTZtMj0IXUdXfoWWknroZVso+
jMVCGczvES+ZzaI80+/+CcY1IrGEv8i+bo0nB5IVPqLdqdbe8e+bPLmK8i9BBzAN
5PszsZEVKX5USzrBcv8uacbA7uy2YiTtyAJqRJVG2+hK+T+IoMRL/g0cez9n4Rb7
IFb12yijY9d/EytohWkmskkzQTFGMkH9Gk5zWEefKYiInhv2NsRQeCmMAwM3sh8i
cV/RUvKGAQj8OPk8SOtV/6ktH3CR2t75HEDnxi5lrEiAa3nNyWkBEVRPZDIh0p+r
ozj6KXKmpWsLGVFXdzYzDjfI5tQIl0qVUIoXfO3UFO3b3rXZSZv9T0gncjKQLhOF
fXhAObOXHD3pdGCn0vMokrApvtbckmmg6ZsG+PDJdQITyChHB10ws2dz9fQXpeRm
KvcShLPZCu14NOIRr7Dq
=zcJm
-----END PGP SIGNATURE-----

--bYrG818GTFYOcDzy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
