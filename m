From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] drm/i2c:tda998x: Use the HDMI audio CODEC
Date: Wed, 1 Oct 2014 13:37:08 +0100
Message-ID: <20141001123708.GZ4273@sirena.org.uk>
References: <cover.1411547014.git.moinejf@free.fr>
 <4b3d35a14461ed164956b7f5aa77b29170bc393d.1411547014.git.moinejf@free.fr>
 <20140930192540.GL4273@sirena.org.uk>
 <20141001112846.0dbc80ae@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="diT81a9gloLbuVo+"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141001112846.0dbc80ae@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--diT81a9gloLbuVo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 11:28:46AM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > > +	request_module("snd-soc-hdmi-codec");
> > > +	pdev =3D platform_device_register_resndata(&priv->hdmi->dev,
> > > +						 "hdmi-audio-codec",
> > > +						  PLATFORM_DEVID_NONE,
> > > +						  NULL, 0,
> > > +						  &tda998x_hdmi_data,
> > > +						  sizeof tda998x_hdmi_data); =20

> > Why is this request_module() needed?  If there is a good reason for it
> > we should have some documentation.

> The reason is simple: as the HDMI CODEC is not declared in the DT, the
> associated module must be loaded in memory.

No, that doesn't make sense - there's absolutely no dependency on DT for
module loading, non-DT boards work perfectly fine.  Think about this for
a minute, we don't have lots of request_module() calls in board files.
You're working around some other bug here.

--diT81a9gloLbuVo+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUK/VzAAoJECTWi3JdVIfQCeoH/RUU/tCbsxm0OWbFFEVXIG8u
G8Gmihvxh1PHcxbuG8SzC5daFf3Txe4ZhFd5WavEXzfKmzjqtl+NwYd5Zhwu3G9X
lu+GNZniDIXN6rIoMfIamDzsa4opFYtn0X0mXSO7XLWf5mCKaq5Oe4Lh1qdQGX+V
x38s/jkWKaMk5PeNhTUFf9CbPnwLslQseoX6eRECKWMFy6k0vLlrHR+goXkclABC
M6qpC16HwQLL0prmML/GwkDxdALQzg7ktdZsmvlrfXspCdF8TwD2kClo0YG6P8IK
nJ4V2iAbWkfs1XbSUbbXzzyBVMsXBjLtx0NarOyoMBBInLGBnIw0/MiYXviQzGI=
=SOfX
-----END PGP SIGNATURE-----

--diT81a9gloLbuVo+--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
