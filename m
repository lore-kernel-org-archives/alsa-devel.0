From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Fri, 13 Mar 2015 23:34:07 +0000
Message-ID: <20150313233407.GF28806@sirena.org.uk>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150313062829.GA32000@intel.com> <55029D8B.9060309@intel.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BD7F2C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8123862871758182531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D99012604FD
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2015 00:34:13 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BD7F2C@SHSMSX101.ccr.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Jin, Yao" <yao.jin@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8123862871758182531==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/rpqzglUoB70AQHl"
Content-Disposition: inline


--/rpqzglUoB70AQHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2015 at 02:13:17PM +0000, Jie, Yang wrote:

> [Keyon] thank you all. Hi Mark, so should I keep them locally and send to you
> 2 or 3 weeks later, or you will keep them in queue and apply them one day?

Well, they won't apply as-is since other people are sending patches for
the files as well.  What might make more sense is to send a script which
generates the commit (so a bunch of mv commands, patch for the Makefile
and a changelog entry) then I can do that just before or just after the
merge window.  Does that make sense?

--/rpqzglUoB70AQHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVA3PuAAoJECTWi3JdVIfQLykH/iJRCrc1XVbxHXTyNShR6cgY
WvLAajbTK/NEJ56QA7eiS9JluJztkfk6CeR3ZukAixJh/J2gma67ByHc2u0dGfKM
klIhE081PrxtA0NXETFjoiF8FfslwhNcVwXJsfJzG6RCIGdezEklJ+8MTNZIAYhM
5tCIEhe3n1d47VQlLp15E/PMUqghr4F9kq47hvb50QJZH+jT0m3RIWi+w3yzYlLT
WlLV7F8QgTTRm/HteVN+A+l/pFtCIJFyl3+cPc6hcKuDshgVY2CJftu6s3Y2oyzX
sF7rxaGHp063qbkboL2t4I9Zaq4dOgyO+HVZA+XZDeoPkFy3xfurhhemx/IKh18=
=JY0X
-----END PGP SIGNATURE-----

--/rpqzglUoB70AQHl--

--===============8123862871758182531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8123862871758182531==--
