From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Tue, 8 Oct 2013 20:29:58 +0530
Message-ID: <20131008145958.GQ2954@intel.com>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
 <20131008154923.GE21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5011969231002917363=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C695265355
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 17:52:30 +0200 (CEST)
In-Reply-To: <20131008154923.GE21581@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5011969231002917363==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2013 at 04:49:23PM +0100, Mark Brown wrote:
> On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
>=20
> > supported. This patch adds code which uses the newly introduced
> > dma_get_slave_caps() API to query this information from the dmaengine d=
river.
>=20
> How newly introduced (ie, is it in Linus' tree)?
It was merged in last merge window, so you dont have any dependency...

--
~Vinod


--=20

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSVB3uAAoJEHwUBw8lI4NHIe4QALWZ0WmJHCJtXXMS0v2QEVeV
QX3Gas8PPxKfy1ktiswOTWvxhKs8Caj/d6KXCK/0HFF9zNWLpSrbD2gvaCcWz/VI
MumRoQANUWRPvvZVFe4unS8eLwiM7Q1YnGQOXHDTZIyv/q1TyA9B4s4JaeG15Y4X
HS4vgwwKHiZ/nV42sY3ZmS8lVZ8mYN/hLDU4CQQy1EGD7+DJMk2eu8XxWvBB4X9a
gbSC2JvSOnnqk/V/TQLx4BOIr8iPmkD/vwZ59yqtKq7DWMV3XV1mRQr0YKn0+GPh
XYl344QkykZaTfj8jRoM+yIviugK+wuAC8otA4mBCK5RkjP4hMxmf4j0icmDizdR
pcuBCsVbHMrYVfaPFIDMjYPu6jvSveze1uNutl7/9a89DvU+WHUMRVP9OKRinhk0
nf56LDue9gJAuG5DsRSlWX0qzticIzjsrQWzYncsiJI3xH+ffxB3sgkRYmGoiMS7
5RlThFFW0ODkxgiEOqk6jDu9Gq05zfrYwyrph7195rrx9MvM4sO8eJQPgg+bK2An
sNpxRnMuDZNLPM5s3i9zp4euYP6OP2ew8lG6nqHNh0jpatf9WaEZFZpWT/rJTnje
kL4udWqjQHEp57LCVbcSukob6Mx1VZlxIxjnhoOhnNnCeZLG8aq19/DVzOt8x80v
FOrwwA235Y3GEOjYba/8
=UHs/
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

--===============5011969231002917363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5011969231002917363==--
