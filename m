From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 16 Jun 2015 11:54:29 +0100
Message-ID: <20150616105429.GI18309@sirena.org.uk>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3269412341836707809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 303052651B4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:54:46 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
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
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3269412341836707809==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wnLTWEf+vlzHZaR9"
Content-Disposition: inline


--wnLTWEf+vlzHZaR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2015 at 12:49:37AM +0000, Jie, Yang wrote:

> Mark, as you may see in this patch(1/2), I have added this selection to s=
ound/
> Soc/intel/Kconfig, we can find .compress_dai =3D1 in sst-mfld-platform-pc=
m.c,
> the compressed is referenced in sst-mfld-platform-pcm.c:sst_platform_dai,=
=20
> here copy the related part from the patch:

OK, that should have been in the commit message.

--wnLTWEf+vlzHZaR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgABkAAoJECTWi3JdVIfQKFoH/RMPpnywBMuaoLEAM6ChBBNQ
bMBZ7wDa+cQ9D6OZ1P11bcOCpsGT0dXCe+JSBHYUweXvBPDYqZXYlH7CTaMaDj4A
rKCV3YGOh5xDFnyH7wiL9FfzQ6TwNsRtdPiJtizQjTKlU7wAIegzlgrA1EIx1YNn
pmU0BjMLG2iSVf805wZhUuTzErLnFNzaB9WebAF7Vw44dbDaPR5b7Nftx61UsPG+
WhiXscl1U94lE09VWJARmvpJGK+Eo7bb6/P6Pt+QPRyZN1HQPVkgkfthRXtTI9BY
fz8zEtA0Qq3FNgJAcI1sVP0L7dohlEev0hm20LqsdVDY+sgmsWWw5JxjHDT+6r0=
=ttGo
-----END PGP SIGNATURE-----

--wnLTWEf+vlzHZaR9--

--===============3269412341836707809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3269412341836707809==--
