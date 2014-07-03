From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 3 Jul 2014 12:59:24 +0100
Message-ID: <20140703115924.GY410@sirena.org.uk>
References: <20140702183841.7c964832@armhf>
 <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
 <20140703133406.2d3e3a1d@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j13PAD5Nz8dz2ik7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140703133406.2d3e3a1d@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--j13PAD5Nz8dz2ik7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 01:34:06PM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Your board happens to only be able to present the same input on both I2S
> > and S/PDIF but that might not apply to other boards, they may be able to
> > route different signals to each which would present a practical problem.

> If there are two different streamss on I2S and S/PDIF, and if the audio
> subsystem wants to route these streams to the same connector (widget
> 'hdmi-out'), then, somewhere, there should be a software or a design
> bug. No?

Yes, which is why the driver shouldn't silently ignore the situation.

> Anyway, the tda998x cannot know if the double route is wanted or not.

It doesn't need to know, it just needs to identify something it can't
support either by providing a way to pick which interface is used or by
rejecting the second interface.

--j13PAD5Nz8dz2ik7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtUWZAAoJELSic+t+oim9OE0P/3qYCYKQllHUWyZKuNhKhysO
wr8H5BbZziQrkByipmYihNw303AqQQ8R2+zxetJE+xEJIDImL82mnCTmJ129wSUN
MaQixJ7jEWIZL35GfxegRO7c2lHbQCMTALeVMpKUcMAJ08ZnL+9PMgQ/57cs4682
0d+o2IgkX7IYpt98NdLKuvWz7hV+kU0BDHVpVow0QGnK7rmbDXLEMu0gZ3jnvzix
uXqXHmZsdWuIlafUQca/gb1va4q10wzNRK4KEckIs80rxbU7qL7OuvbznZLGRPBr
AHYiVPqt3iNbwExTFQgNQQAghnPgCjKPE7oGzbPgP0wPSk9oDzt7rduvVDvytRq8
4wkuYn7OVgCFwGL4sOb1QaB8giYZtn7U0nLUMyRh/kM27z29X+zJusX9Eb7Ytldv
nh/um5EB2fCwLZwX/09pnIHy7/u8t23bpFzwP5hEoFKv+NSIvnCSoQm0Upe1mIeb
KTh/BHs86MLGKOAHoShlOoCj/JNFYAJbB4MO/fZOHPcUUdW9DlHb1k1ujVvbgMU2
HIKXoCLnemWfj6CtkPkzREh0It72UcF0gRwlAOq0qAPCF8syyomKH3fO+Qp0xtJo
KdcC1G3md/i46ZNze/Kx5ux6y6M51udnep6E0Qvd8kHXBqQpRAXkBlCjBqlEA4Lx
g/MJJYdMxwRCLph9A3nj
=yWLR
-----END PGP SIGNATURE-----

--j13PAD5Nz8dz2ik7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
