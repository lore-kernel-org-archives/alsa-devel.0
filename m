From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 19:19:22 +0100
Message-ID: <20140811181922.GH17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
 <20140811171133.GG17528@sirena.org.uk>
 <CAKON4OyyPhH9=kRRxkmFJGcvzWTBdZ2_d449FCAzE+6jy5XFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6458157980630008297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F29C726164D
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 20:19:30 +0200 (CEST)
In-Reply-To: <CAKON4OyyPhH9=kRRxkmFJGcvzWTBdZ2_d449FCAzE+6jy5XFKg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6458157980630008297==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLSijTScCavI0RJH"
Content-Disposition: inline


--oLSijTScCavI0RJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 02:00:22PM -0400, jonsmirl@gmail.com wrote:
> On Mon, Aug 11, 2014 at 1:11 PM, Mark Brown <broonie@kernel.org> wrote:

> > That's absolutely fine, the clocking arrangements and sequencing
> > requirements for achieving it are in general going to depend on the
> > machine.  The machine may have requirements which mean that it doesn't
> > want to use a clock configuration it's physically possible for it to
> > generate, or it may want to do more extensive reparenting depending on
> > use case.

> We probably need something like EPROBE_DEFER that is used in the
> driver subsystem to allow that various pieces to so this out.

That really doesn't solve the problem - consider reparenting for
example.

--oLSijTScCavI0RJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6QkmAAoJELSic+t+oim9KY0P/0Uj1IsiBA6E+wi/Wu4dePbv
lSDrf/a6fh6P8pfOpFtBVCZvtRPEz0op8X9T8VVIOKwOGI4+ciAAx8i+XBymle8L
ktnrf4FBaMdKZX3wQdkg1tDS3tRHL6gPAWABQk40ehlKaYyz+WOptOPuRYNOOdge
hj1n1D2HHXVEpQWPvmm0n2P1gki5XldB3dfKa0TwYnWJeDtcXXuk96qeyzNI4cBp
KBS9gO6vA4MjgmqDNHbH55/vOo7Ozg0pLmKUYYdrZK7T0dcR6POOdBxOKOpWC8Si
ug+3e7/eLke2Gd6sGmKkdw+EdDvSzT/8BgovPtrePMn74+EaZ2ccNxuZ7QWtt3R7
0HyCwoMQ8An++KLT7K3BaH/Ae6JeRDkvybbCAa65aQAELrFxcLm54cDoD9ZJKW3W
Q7F2GRBHeH/eiNo+vuxgM7eM7yswUXLe341Ao4Jp7Nu6WZESxd1cwXYyHgz64lD9
9jBBOGSklJU0OHD7ZAtF4QkafWy68aO18FtdLRXJ5HTxLDdAFP7XnmzmbGm3TKB5
iDXnTDQv0c9sOe6FndG7KxS3FYL4+9Qu/k/WdOwL9UBkRxJ0Mg8C/9YWCVSo28Lw
TM9TeXJjPt/x9GzKgJYHw7yZHLAwdpsHcysepKEj24Jud6WEGj1POWh7l/xlIQYr
tvN+CFAWkszDeaZSKlHe
=E+P1
-----END PGP SIGNATURE-----

--oLSijTScCavI0RJH--

--===============6458157980630008297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6458157980630008297==--
