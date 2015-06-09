From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Tue, 9 Jun 2015 20:03:06 +0100
Message-ID: <20150609190306.GZ14071@sirena.org.uk>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
 <s5hd216k12q.wl-tiwai@suse.de>
 <20150609175711.GR14071@sirena.org.uk>
 <s5hlhfsaf79.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5269825357957181529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62FC926147D
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 21:03:13 +0200 (CEST)
In-Reply-To: <s5hlhfsaf79.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Zhang, Vivian" <vivian.zhang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5269825357957181529==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zpRouf6TsWqWFjU"
Content-Disposition: inline


--4zpRouf6TsWqWFjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 08:50:50PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Indeed, part of the reason I was asking about the split was to help me
> > figure out what takes the place of constraints - sounds like nothing?  I
> > wonder if we could have cards support this by providing fixed
> > configurations that we could check against using less code or something.

> I think it's possible to reduce the hw refine part.  But, the question
> is whether a kernel driver should trust user-space blindly.  The
> removal of *full* hw constraints means that, and I'm worried by lack
> of safety.

Quite, I think you're right on the blind trust.  It seems like too much
potential for people to break their systems.  The code reorganisation to
make it easier to modify the kernel if you really know what you're doing
seems much less worrying but that final step with no further safeguards
is a bit too much.

--4zpRouf6TsWqWFjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdzhpAAoJECTWi3JdVIfQqh8H/1lsLYrlf5Hll3D7QjjqkaVf
56OVi4+AlsQRx6v5GQmVcsgXfoKgx+fiVDkXlg4UT/xi6Qv3KCrQ8UeBKNFdL9pi
BVLrhZ17lI+/UuufdpyQwHMvO8XGiATNcelK90XUg2DoPD8wJUeLIxaAbHRnshCf
2cMAO/16vdk599/y1Zr8LZD/KraGixTO7OQ/jfzpwoJD4MAwXS6PSp3TI7YpjPCM
AcRXZ0y4DzfDkRtLze4sLrVdggNe5XFWFAphmXp5GmFdhOy3IbkmFsfSBlG0ilU8
cVjuTCs0fiIbhl1jqpKxUVXCyfil2ShNLg4eXUvW7cfYk0V8DAM1m4YVJdUlqGw=
=JZ13
-----END PGP SIGNATURE-----

--4zpRouf6TsWqWFjU--

--===============5269825357957181529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5269825357957181529==--
