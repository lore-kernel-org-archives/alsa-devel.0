From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Add token
 support for topology data
Date: Fri, 12 Aug 2016 11:41:07 +0100
Message-ID: <20160812104107.GB9347@sirena.org.uk>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0403712397807303604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83105265E22
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 12:41:24 +0200 (CEST)
In-Reply-To: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0403712397807303604==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KjcUHqqCp23GY06r"
Content-Disposition: inline


--KjcUHqqCp23GY06r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 12:29:49PM +0530, Vinod Koul wrote:
> With topology changes in alsa-lib, driver data for modules can now be
> passed in topology conf file using tuples.
>=20
> These changes allow private data to represented by tuples of type UUID,
> byte, short, word and strings.

A question I ask quite often: the topology code has been in mainline
since v4.2 but still has a big old #error at the top preventing any
actual use from userspace.  We're now more than a year after the code
was originally merged and still no patches to actually make this ABI
usable from userspace.  Where are we at with that?

--KjcUHqqCp23GY06r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrafCAAoJECTWi3JdVIfQ3y0H/jDMJhVKvO5Crb9cfly4ckD7
toWpX/i13d/lUqZoxY/zbbLo2ra2K0fxi+9F7dTLYOlu3HMkswIhdPB+PvrYKim9
LKOGTrdIyemD3zLK3uudk5FVNHj/uU774NS1X0AIh/7iWoKrXKhrpgWGQ8mH7e/B
wWymDG3qUyLrqke7lb2zp7D54NsDG26HLmfWDDtX2t0YRfiBcEYywgaRrEHvbmv3
Kn0g+qww74zEe/y9XUN0G/a8DkRSuQB0z1YNXH4rf6giesUJyJnE55SnYVfOrieA
fp/8AMy7roXy1zwvQhgiTEy7D7UmMvv+jAB5bcM+YFHq2PMld9A8M67ozTMczwc=
=bHQJ
-----END PGP SIGNATURE-----

--KjcUHqqCp23GY06r--

--===============0403712397807303604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0403712397807303604==--
