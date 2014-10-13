From: Mark Brown <broonie@kernel.org>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Mon, 13 Oct 2014 16:18:35 +0200
Message-ID: <20141013141835.GI27755@sirena.org.uk>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
 <20140919175205.GB1736@Asurada>
 <20140923015134.GE27755@sirena.org.uk>
 <CAL8zT=ggs=fsBhEY=vXyH=6Bvy6iftV4JjxJ+YXuftk+xQ3Zdw@mail.gmail.com>
 <20140924082146.GV4015@sirena.org.uk>
 <CAL8zT=gPh=pETH0fk7Jfz+n+-sRm_U1hEZv2FQAoSEkywjdVKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5358874730050692873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4DC1260465
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 16:19:18 +0200 (CEST)
In-Reply-To: <CAL8zT=gPh=pETH0fk7Jfz+n+-sRm_U1hEZv2FQAoSEkywjdVKw@mail.gmail.com>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5358874730050692873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYFfQIiwxA4Fn7ym"
Content-Disposition: inline


--WYFfQIiwxA4Fn7ym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 05:24:49PM +0200, Jean-Michel Hautbois wrote:
> 2014-09-24 10:21 GMT+02:00 Mark Brown <broonie@kernel.org>:

> > No, that's really not what DPCM is all about...  if this is a physically
> > separate device that's not got direct memory access it's probably more
> > appropriate to represent as a CODEC.  I was CCed in part way so don't
> > entirely know.

> OK, sorry for my late answer, but I was on a lot of things at the same ti=
me :/.
> Well, here is a tentative to explain what I want to do :
> http://paste.kde.org/pwijzty2p
> The objective is to develop the "Mux I=B2S" part, as this is in fact a
> FPGA with I=B2C registers which tell which input should go on which
> output.

OK, this probably does fit best with DPCM at this point of view as it is
such a simple straight through connection.  At least it's probably the
lowest impedence way of doing things right now, it's not really what we
want to do longer term though.

> I am reading Alsa docs, in order to fully understand what should be
> done, but it seems that this is nothing more than a simple codec with
> no effect on audio parameters... It should be visible in alsa mixer
> though, in order to drive the inputs from user space easily.

Even a dumb CODEC at least has the effect of limitng the configurations
that can be used.

--WYFfQIiwxA4Fn7ym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO987AAoJECTWi3JdVIfQbDIH/0fX0cnTydyNPkG69J3pD3hI
6WlteP/ZfMydN3/z73+X/Ivyp7m788ZtNWVEd4vFXT7nz9DMCdibO9WeRxOEV12w
bmyJ4tH94NJ2AisEPmfY0TcvPSmurlfjrIuLF0YBo8P5XctUd4lguWPa6Z9nlywH
BqXRFX7qyoxapHKKJ828+lFZtkOX4eYwUr5pnuBZtr9ilIyZId5uuXgaYYf8YnGU
8ObwdWwQCTVck34GWWvT7S9YqB4ivkbFAcDB8WQC+dBuyDX/VpNE7kptfSWYUQxC
DMuSlkKdAG++8ZKJiBfePD+ab8CsewMwjySl9JyASLoPFGPTv+bLVIpRxDQQsp0=
=s4Q0
-----END PGP SIGNATURE-----

--WYFfQIiwxA4Fn7ym--

--===============5358874730050692873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5358874730050692873==--
