From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: soc-compress: split
	soc-compress to a module
Date: Mon, 15 Jun 2015 16:07:02 +0100
Message-ID: <20150615150702.GR18309@sirena.org.uk>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <1434338445-31992-2-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1268878505035435887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E1826512B
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 17:07:12 +0200 (CEST)
In-Reply-To: <1434338445-31992-2-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: ramesh.babu@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, vivian.zhang@intel.com, vinod.koul@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1268878505035435887==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 11:20:45AM +0800, Jie Yang wrote:
> Split soc-compress into a separate module so we only compile/load
> it when it's needed.

Given that this patch is so much simpler than the previous one it would
seem better to make it the first patch - I'd be OK to apply it but it
depends on the prior patch.

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfuoVAAoJECTWi3JdVIfQLzkH/1D3RMAr5yIGW+kjZo9AGMon
Ve+9oQ6PrbZ7g+R1G3aQABLntwmQYayTYccdKrWgmWL/KwyHFgDXgGikdHYtfjRn
PFxRumohzeS/NgXFgBe1l8714A0l7qPPPDzyAzPNVYIWCardLWIXlUdeDB3XBTO9
DxgRRGc3jyl7Nk9MM1dmbs4QifgdU/3rStuV7dPoblw6jT+QyiAnmtZrAH7o+EQE
QgTIbpw1i7dcxXS0OCnUbALpDMK5drJNG/SGaGedEVz1DBTXwkKLGJWKHhQpXoKP
jKsZFQnzsi5C50ht79aflGvArmvuHEcWuCa8EmJ0/03iHbD5Oq08A23TEjQna9E=
=85DM
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--

--===============1268878505035435887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1268878505035435887==--
