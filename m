From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add A10 I2S controller binding
 documentation
Date: Thu, 9 Jun 2016 19:15:59 +0200
Message-ID: <20160609171559.GF5242@lukather>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-2-maxime.ripard@free-electrons.com>
 <20160606130818.GA6952@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160606130818.GA6952@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrea Venturi <ennesimamail.av-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gianfranco-25KmuZRQ+wx0ubjbjo6WXg@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, Jun 06, 2016 at 08:08:18AM -0500, Rob Herring wrote:
> On Wed, Jun 01, 2016 at 07:54:27PM +0200, Maxime Ripard wrote:
> > Introduce the device tree binding for the I2S controller found in the
> > Allwinner A10 and later SoCs.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  .../devicetree/bindings/sound/sun4i-i2s.txt        | 33 ++++++++++++++=
++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.t=
xt
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Do=
cumentation/devicetree/bindings/sound/sun4i-i2s.txt
> > new file mode 100644
> > index 000000000000..365ca4eede5f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > @@ -0,0 +1,33 @@
> > +* Allwinner A10 I2S controller
> > +
> > +The I2S bus (Inter-IC sound bus) is a serial link for digital
> > +audio data transfer between devices in the system.
> > +
> > +Required properties:
> > +
> > +- compatible: should be one of the followings
> > +   - "allwinner,sun4i-a10-i2s"
> > +- reg: physical base address of the controller and length of memory ma=
pped
> > +  region.
> > +- interrupts: should contain the I2S interrupt.
> > +- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> > +	Documentation/devicetree/bindings/dma/dma.txt
> > +- dma-names: should include "tx" and "rx".
> > +- clocks: a list of phandle + clock-specifer pairs, one for each entry=
 in clock-names.
> > +- clock-names: should contain followings:
> > +   - "apb" : clock for the I2S bus interface
> > +   - "mod" : module clock for the I2S controller
> > +
> > +Example:
> > +
> > +i2s0: i2s@01c22400 {
> > +	#sound-dai-cells =3D <0>;
>=20
> This is missing from the property list.

Indeed, I'll add it.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWaROAAoJEBx+YmzsjxAgvhwP/37yLDHATzP4f5K3m5qkKmXI
Lrk4wbQob55iH7vqIGqj6BeMDBJ6BoVoNtk7tS8K/Jis0R3q3ti+WClj2xE5ECTy
SFLHb39t7eiWE8FSKN5ie5sK+3w9xh8tNHd3zNFlNyIuZ+MtUid9OFXgLk7Ey48d
QzQc8mvLMXvVt4YM6NSArxwrJ5gjwGoUHtOvzBCgQYa7rJvJ7mKUyylv/6gvmTAc
VVrwoiPqOyx58vfU1VA2VRbEKTTn4XgRCxdIv+4UIrc0HQ9zYYBMWsi/JnV3NkgH
TEQuEaIHmHnTSqlJEamCniz+g4OvieutlwW7CnXMz5F9DjQx0ya4vEuOxOo+hIGe
VPWwAnETLiAZvDKg0HY9o2yWRgZljjAZoTblMGIWnrcdBj/3zglXNqPakQphvXgw
qtq5HO01uT5VrDlCg5jbIAL+sELDBVAtAHRjUrwhiZu/RqovrmLb4awWvD29xie0
7qGYUcwsYZmwoXOhD8qWmj4JhCirHfx6vYb1UZdP+4cCVUWngfIB5Zuu3AN0+uAG
7JbmRpOiWhPhiJh2G6y22KBIHs9rqC34FaE8383t6n5Js8EXUULfXW+HIREUhLqB
iGHZxIqnY92ajhreadGjojIEzP+/mEc1P3r0b/YXd0VHpegUnPVvkDT8y//vBmaE
gKiQXU2mQSi29V+/BJFY
=xSro
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
