From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
Date: Wed, 1 Feb 2017 11:59:58 +0000
Message-ID: <20170201115958.7a2odxxyhzm3ofew@sirena.org.uk>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
 <20170131211702.taxbrgxwo7b4daej@sirena.org.uk>
 <feb16b69-388f-10e5-7be5-c750095ee52b@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pbiqwxzkmhjtbzm7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <feb16b69-388f-10e5-7be5-c750095ee52b-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mylene Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--pbiqwxzkmhjtbzm7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 08:44:56AM +0100, Mylene Josserand wrote:
> On 31/01/2017 22:17, Mark Brown wrote:
> > On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl=E8ne Josserand wrote:
> > > Add a new compatible for sun4i-i2s driver to handle some
> > > SoCs that have a reset line that must be asserted/deasserted.

> > This doesn't apply against current code, please check and resend.

> I based my series on linux-next 20170131. Which one I should use?

You should be submitting against my git tree (which should be what's in
-next...).

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

--pbiqwxzkmhjtbzm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliRzb0ACgkQJNaLcl1U
h9BSdAf+INdhvnK6Y6YkElF6GHCXcbgfe0wvzvnDMOMcLH39BBYDMcFNDt88Hg3C
FNIdNdGPNBC3ib9otIqKN5+X8YvlygCjrQn3olTZF+JL1SlRkSSTtv7wXKkAeQKW
sZ0gFVay4VzUxlxGxcKVK3jUWEVaiU7Z6CNOquXqT6J8zabiTJ3s+qVIFilehAgL
B3RHn6ITX0QkYoXI/ElcVmdGX80n6tee8C8nflaXkxKf0az1Ld7wyuhJu4iFbF64
p/j0h/oH/2eji4YvOhtsJwYBrtoJcx8qL3LSrPdGf4nVxaz7+G2Qkd/WSEH9MOne
p7+UDNISJPciqUC8dL7Q7VjbUmkGwg==
=yc7a
-----END PGP SIGNATURE-----

--pbiqwxzkmhjtbzm7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
