From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC:rt5670:change dapm routes of PLL
	connection
Date: Thu, 6 Nov 2014 06:01:08 +0000
Message-ID: <20141106060108.GQ8509@sirena.org.uk>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
 <1415247834-14278-4-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6046280555797175425=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FEEA26512A
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 07:01:24 +0100 (CET)
In-Reply-To: <1415247834-14278-4-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6046280555797175425==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5AmtYbcgdBTTPS58"
Content-Disposition: inline


--5AmtYbcgdBTTPS58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:23:54PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> PLL should be powered up once filter power is on. So, "PLL1"
> should be connected to filters instead of DACs.

Applied, thanks.

--5AmtYbcgdBTTPS58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWw6jAAoJECTWi3JdVIfQlkkH/2vmJ/SxFeMV/SN/31+dB8jJ
IXLOLBSzeIR+Smd949/eQVS1BnTLAUE8eo40I9q3pBB7rivIzIpzFAtLCZOpT5aD
cmyWGr8XPM88Qo1iSUF7tdp0VgiB3UTNKluCJYcwLx9yqS/BZoy+49aTCEnlwfj1
QB48kzZHLhiNALh9Qe/QBqathECyrIy0aojQywYw0Os4qNRRnu+8JKZI7F57oLki
1CVMAfUW3Y6YuUZut36+7PGgwbBwAuhvrAWLaMgr6bPRJDgfMssCLpVoLHCD6ZJz
UddDpgPayKO/ZcrSdkpHch5k8+GBzjPH3sRBQQY6bshZi8uUjR++i1X+Z7dXI6w=
=vcC3
-----END PGP SIGNATURE-----

--5AmtYbcgdBTTPS58--

--===============6046280555797175425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6046280555797175425==--
