From: Mark Brown <broonie@kernel.org>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Wed, 24 Sep 2014 09:21:46 +0100
Message-ID: <20140924082146.GV4015@sirena.org.uk>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
 <20140919175205.GB1736@Asurada>
 <20140923015134.GE27755@sirena.org.uk>
 <CAL8zT=ggs=fsBhEY=vXyH=6Bvy6iftV4JjxJ+YXuftk+xQ3Zdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3312050482741640596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A72182610A0
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:22:08 +0200 (CEST)
In-Reply-To: <CAL8zT=ggs=fsBhEY=vXyH=6Bvy6iftV4JjxJ+YXuftk+xQ3Zdw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3312050482741640596==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OelmujB7rQAg+yu0"
Content-Disposition: inline


--OelmujB7rQAg+yu0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2014 at 08:11:27AM +0200, Jean-Michel Hautbois wrote:
> Le 23 sept. 2014 03:51, "Mark Brown" <broonie@kernel.org> a =E9crit :

> > Depending on what the system looks like it's not at all clear that there
> > should be any visibility at all of DPCM in the DT - it's a detail of how
> > Linux is implemented at the end of the day.

> So this should definitely be implemented directly in a specific driver for
> my FPGA which is a DPCM right ?

No, that's really not what DPCM is all about...  if this is a physically
separate device that's not got direct memory access it's probably more
appropriate to represent as a CODEC.  I was CCed in part way so don't
entirely know.

--OelmujB7rQAg+yu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIn8ZAAoJECTWi3JdVIfQuBwH/2u6iaa83C3h7j+wH1ZNJ+jl
fifLRkhg0CuP818db9zwJZ01po5rlgLvVrhFXc7tdchjmO9FVsLj+tUjBBoMCM4R
L7B4enm8I7zM+pXiLktWj44HHmh7kpuCjePFSKquAI7JTkmsWP49ETLPycSZ717o
IdT2EJMLh0PyUxU9q/f81yX8RkS1hhTWv6vS8F3pllSLcPJI50kaqtnSMiDEResO
HqGz9cUxjSKdTR1NHj2nIE7hIlwV2APfPk9IUJ7uM4Sl1vkItvAz4OqZq7cXVlsH
ha1uFpy6jOoxafHdbSPmqZLuAQbhWwfI+k00dUj6G71+RE4xQv2IeKaT9wR8DZk=
=AZoA
-----END PGP SIGNATURE-----

--OelmujB7rQAg+yu0--

--===============3312050482741640596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3312050482741640596==--
