From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: Intel: Skylake: fix
	memory leak"
Date: Tue, 5 Jan 2016 18:48:44 +0530
Message-ID: <20160105131844.GM2940@localhost>
References: <1451994364-29338-1-git-send-email-vinod.koul@intel.com>
 <20160105114622.GY16023@sirena.org.uk>
 <20160105115417.GL2940@localhost>
 <20160105121141.GZ16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0893243604841614149=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C0EEE2606D3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 14:15:17 +0100 (CET)
In-Reply-To: <20160105121141.GZ16023@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0893243604841614149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 12:11:41PM +0000, Mark Brown wrote:
> On Tue, Jan 05, 2016 at 05:24:17PM +0530, Vinod Koul wrote:
> > On Tue, Jan 05, 2016 at 11:46:22AM +0000, Mark Brown wrote:
>=20
> > > Please use subject lines matching the style for the subsystem.
>=20
> > Is this an automated mail :) but its signed!
>=20
> No, I type those out by hand.
>=20
> > Btw am not sure why this is not proper, isn't revert followed by old pa=
tch
> > title the right style for revert patches..? what did i miss...
>=20
> Patches are patches are patches, reverts are patches like any other and
> should still have subject lines matching the style for the subsystem.

Fair enough.. I relied on the git to create the title, should have changed
it :)

Will keep this in mind

--=20
~Vinod

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWi8K0AAoJEHwUBw8lI4NHLfwQAIeGNoUYvOm+g8qRpksR6+DQ
bGe00U0lQ3rztdT+/p6y7eiXyWc90Ssda344zItSbp8oofE+4FBxa0AQc10yQLUC
TdIQQRlZo5E4oY6th7PM/4IPGP25OdfoTGRxYb4nbIjlP151WdBDfvpFzkK+8xw0
uw1idLqxrjELRkvwXRXkFUwWttrxa2YUlMRZ29KAszsVc0jcBEZIVqJ+1+lp9GIB
G8OKN6QFoBxcwpBujnZrac5ohdmOv//y/8Tk+Y6Anc6Ozgd4xyl4DcIeP+UVzmfQ
FInfJaCYtrB5VewluUwzBnJxL75+4mgRH0EbPS4K6ioRcXnWI2QnyoHmurCiQR7g
/CTTxOhGzQXskDHNNYfY5mefNe0AWaoDK5U2I9nNh+3cFs1QW0cFmBGHA3xcafcB
bFSUQ1Vb2SjYjwOIEjP2AucsqLndKCkwNApWbfv9lZrJyQUprKDjiX81i+90t51f
11D8Hfy5NyZSMNZ/srqru/kwFf9rQSNXgtynfKR5zr63pIDPoAgAs0RKoiUex/QR
WDjUU2+OpRxdljWPFRB8boraqmJIF/Ph9JcgII8EIb/UUSXgxo05K8ItWvPasu8g
mLEiuTQdbdIB7wA8Pka6bN1sRmgx+fLahZ/aZ/IoQRRzMtByRXZTm0ULKH+Lqq2Q
qXNhg//PIITDvdI31bhR
=Oeyw
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

--===============0893243604841614149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0893243604841614149==--
