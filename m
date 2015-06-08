From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Mon, 8 Jun 2015 10:24:16 +0100
Message-ID: <20150608092416.GH14071@sirena.org.uk>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0972863552350400318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B87826068A
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:24:26 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0972863552350400318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7K7m04Qp/nn6yf9"
Content-Disposition: inline


--z7K7m04Qp/nn6yf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 07:35:17AM +0000, Jie, Yang wrote:

> > I'd suggest that for review it'd be easier to have one patch for the mo=
ve and
> > another for the change in behaviour: it's a bit hard to find the actual=
 change
> > in what the kernel does in this diff and that's the bit that needs most=
 careful
> > consideration.

> > git format-patch -M may also help.

> Umm, Liam also suggested that, it's really hard for reviewing, but I foun=
d that=20
> "git format-patch -M" doesn't help for partially splitting/moving from a =
file
> to another/new file, I even tried '-M5%', but no luck. :(

> I can't find good way to make it better, any suggestion?

I think the thing I suggested about having one patch that only moves
code around and another that allows you to disable the constraining
would also help - the first patch will be big but mechanical which
helps.

--z7K7m04Qp/nn6yf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdV8/AAoJECTWi3JdVIfQUb0H/RsoYtD7XZ/eAbUGoe0OUgUX
qVBSe4XhJmKnI8J1HXaW0vEaBdmJXiHjDccsLZJdc2oe4CUmPYtqCXwXldoCNQTR
OxYeojRA2Sk+m0ALET4cx1N0ruk2fRRIL4G2s3kczSeeiPiSw6aLMFtq1Tp703hc
KyzcCqYZfs1sPczYYxSRoegYECF/9QrgdJ0cZqScpSXpZlrfwSpYtrhvpk0fbiWs
emlSjwgzCsBKWjMGkAq+dy233cV8XiqVQtgruzGpwfV86NBydT13yTPhoROTq9pC
AZib0oLvhA35QahUv9xAyVzzDpkaJuCPYVwT8v+7Y7x/c6/QizWox7WAtDwnbN0=
=zvz7
-----END PGP SIGNATURE-----

--z7K7m04Qp/nn6yf9--

--===============0972863552350400318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0972863552350400318==--
