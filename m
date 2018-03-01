From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] sound/pci/ice1712: replace strcpy() with scnprintf()
Date: Thu, 1 Mar 2018 04:10:23 -1000
Message-ID: <20180301141023.kc2cb7xrjx2csgvr@gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
 <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gp33v5kaniw4op3d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joey Pabalinas <joeypabalinas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--gp33v5kaniw4op3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 03:55:09PM +0200, Andy Shevchenko wrote:
> So, why not just use strlcpy()?
> scnprintf() here adds an overhead for no benefit.

That's a good point, actually. Revising it now; patch
will follow shortly.

--=20
Joey Pabalinas

--gp33v5kaniw4op3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqYCc8ACgkQruvLfWhy
VBkFbxAA00gW8MQfUAF1PfYBbmjQ4KO4dP0n81ubPP9OMqQnZYUGz5huKZ/E+eM4
9XYvmEyh2k76zftRf2ILQPFVKpbL/rXSb9QWdmtoIWmNErRDF2c3k9zsE58v7Jf9
BL90eAGRweD5Pv3X30EqhVyQVNdxIrh9ewBaez7YORoWrv6RXyGW9gxfndT63WX8
ak5SL2UsO4+zRwl8hjW2j1AnbadnBuIY2Lq62spyO74bvKDsi+AkIczlNFLeTgNY
DRdAkAquwhH2iwq9EUMK+DcZQXIVTyHje3SJyqUhm/5WLVUuV6CYFMkoFmZo6A2B
i5ZNla3qlbf6qPXk5Baaw19Mmwt/ldyHs0dpvDUGCux7sa2ZEX3RHrppBrmtazZH
/KleVJWGtrn1yKQB+geRDswaUe4h9rm2X2u4QPqfspwWDb76WKizNU4kJ+N96xcT
sC6BS3j5dfTuDyKaAmWAHQRFz3n/gzFTKE8gpi5KMXAcl+lZTtlpmnGmpaS/Or+D
eWruPiHePrwqKObVa9pqmA1wzD6xEWjG8n0ZZ1ErhvOFH3uoMC6d6wU6qzVVS1jT
cx9I073u0XMABhPv2JXjh7X4IUwKj3U/QeFhhFYUPtzV0w3v6pC4wwEjZ1A/QMJH
P7EyMQWuAlJIw64GQBvTjMyi5tNFecfM7ZFwy7H1C00bY7glASA=
=zY+5
-----END PGP SIGNATURE-----

--gp33v5kaniw4op3d--
