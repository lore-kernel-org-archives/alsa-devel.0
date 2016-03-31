From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/5] ASoC: tas571x: chip type detection via I2C name
Date: Thu, 31 Mar 2016 08:36:26 -0700
Message-ID: <20160331153626.GB2350@sirena.org.uk>
References: <1459425241-21941-1-git-send-email-petr@barix.com>
 <1459425241-21941-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CdJmqRynzCmrDwyG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459425241-21941-2-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--CdJmqRynzCmrDwyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 01:53:58PM +0200, Petr Kulhavy wrote:
> The chip selection was relying only on DT. It was not possible to use the
> driver without DT.
> This adds the chip type detection from the I2C name, which
> allows to use the driver from the platform driver without DT.
>=20
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Don't resubmit already applied patches, as covered in SubmittingPatches
you should submit against the latest development tree.  Please resend
with just the new stuff, if any changes are needed in already applied
patches send incremental fixes.

--CdJmqRynzCmrDwyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/UP5AAoJECTWi3JdVIfQUeoH/jcmMIPU4bEH+PDp4Zdh2/iX
W33LmNMtnNzblP6nQMfI+UfIvrfKiLMjEVM+fWK85SQRy5r0vB+pZJx+1BYwoHC1
WSMoGxEqlYr1DelRPNY3M3+Ja1ZYjtJ/NAL03f14RiZ+4LbMqvGjiYpjXypKgB26
o7sDY85lL16ICN+ALamEASbcd/l/8ePCSv+EEZ9DGL3KebCjWDszYrgCQD0kVCFm
ijV39gEtzwVrt0ovI2CzmDUJopSLhS4xHUcT49t9aZyAeuOzRKN+7eYs+EUSxOI1
ZEqAwgfNS0xlCrZpGw6tYxMNXg7fvuCyNlrPhrPOkYDlxe72dFSjJh61CL4tM4M=
=lla/
-----END PGP SIGNATURE-----

--CdJmqRynzCmrDwyG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
