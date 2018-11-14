From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
Date: Wed, 14 Nov 2018 09:31:29 -0800
Message-ID: <20181114173129.GY2089@sirena.org.uk>
References: <20181108124934.32381-1-peron.clem@gmail.com>
 <20181113225135.GQ2089@sirena.org.uk>
 <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0041556861377147262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EDAC2677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 18:31:38 +0100 (CET)
In-Reply-To: <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Adrien Charruel <adrien.charruel@devialet.com>
List-Id: alsa-devel@alsa-project.org


--===============0041556861377147262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agGyne4gKHM29dDu"
Content-Disposition: inline


--agGyne4gKHM29dDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 11:55:17AM +0100, Cl=E9ment P=E9ron wrote:
> On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=E9ment P=E9ron wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > > + *

> > Please make the entire comment a C++ one so this looks more intentional.

> I check from other files and also this article says :
> "For normal C source files, the string will be a comment using the
> "//" syntax; header files, instead, use traditional (/* */) comments
> for reasons related to tooling"
> https://lwn.net/Articles/739183/

Right, and what I said was that you should make the entire comment a C++
one which means that the magic line will be C++ as required.

--agGyne4gKHM29dDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsW/AACgkQJNaLcl1U
h9ARfAf7BUJ2TjdjCO1OP/yZi+Fz/tBTVFUVwsvmt3t6tDcgAnvBddRaxNkf2UnI
Ku02xMMRFJVIlPiWqh0HqT1l758GfvSVaZC2YdDFSO+JVQnP+svyxnx0XaSuM8QF
wU9yP4kUyOALyfBNqMcF2YaTfNSxxmiO49XIr0dVH6Sik+xdRbiY2apra+/oKmRt
LRcnJLty1t6VyrZdAnUNWMH/L3oF/lEzOLrqTthEqpxfnaVhsReWu42qJeFmYI8n
rJmR/6oe+mx+0y2USzduCUUn8syd0YExUkQSoF/sDgkwaFb7dWtF7bZ6s2CXGpqI
6Se4ft3a4WA6K0hrGJbZMwr5iD7awg==
=zoBY
-----END PGP SIGNATURE-----

--agGyne4gKHM29dDu--

--===============0041556861377147262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0041556861377147262==--
