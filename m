From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S
 input controller
Date: Fri, 30 Oct 2015 10:20:20 +0900
Message-ID: <20151030012020.GO28319@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk>
 <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk>
 <562F824F.9070407@imgtec.com>
 <20151028010443.GX28319@sirena.org.uk>
 <56313B9C.8030502@imgtec.com>
 <20151028234334.GF28319@sirena.org.uk>
 <56323E83.5010605@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4cokgWgqjr3t8EL1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56323E83.5010605-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--4cokgWgqjr3t8EL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2015 at 03:42:59PM +0000, Damien Horsley wrote:

> For the I2S In, there is another issue with flushing on stream close. If
> the stream is stopped, then reconfigured to use a larger number of
> channels (without the stream being closed), then the per-channel fifos
> will become inconsistent with each other. The new channels will have no
> samples in their FIFOs, while the others may contain samples from the
> previous stream.

> Would hw_params be the correct place to flush instead?

Yes, you could flush there (or in both places for that matter).

--4cokgWgqjr3t8EL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMsXTAAoJECTWi3JdVIfQScQIAIUUol1l/hftAmRCj1o4rstl
VfdYytoikfmuGsLzQ1NtQ+KohYWRM20kRErAqwtt3DWSxyLmLUCbXuRyapy3v+f6
YpWhUlsXD7NSRSW5d5vomPWm0uSQn3CwbgiVcWncf0WOdox31LjHjg+uB5GJGCFL
8+gdsSRrKrYj3uZ4C7SoVFrLX5NFP/mEmiLeVm+TJFus9PI8JBMPVc84x1EJVtQL
0Sp1/8E5CZddDmsSqJYFySTNDNCX2BC57yuxeG1dVKkiVls3/oSEA6YGJj8Ciw4V
0PtBLDVcQgobnN6CVQER1Fv1K6Sc/rvw/Y5tyM0wxy9IkFYRdodWhxsRZF6nx/c=
=db4Y
-----END PGP SIGNATURE-----

--4cokgWgqjr3t8EL1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
