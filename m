From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: add irq enable/disable APIs
	and export
Date: Wed, 4 Feb 2015 13:15:31 +0000
Message-ID: <20150204131531.GA21293@sirena.org.uk>
References: <1423053895-24342-1-git-send-email-yang.jie@intel.com>
 <20150204125856.GZ21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA9A58@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5779091942271718682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB2A260448
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 14:15:38 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BA9A58@SHSMSX101.ccr.corp.intel.com>
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
Cc: "bardliao@realtek.com" <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5779091942271718682==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VuO68Z/CU90YfXMp"
Content-Disposition: inline


--VuO68Z/CU90YfXMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 01:12:25PM +0000, Jie, Yang wrote:

> [Keyon] thanks for review, Mark, do you mean we should change the
> function names to rt286_enable/disable_jack_detection()?

Yes, that should be fine.

--VuO68Z/CU90YfXMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0htyAAoJECTWi3JdVIfQigIH/21q8I+UAkra2y6cNB6w6dXT
5r1lYEQnzyLXidnSfXiQejL5+rje42Is/yS2YfLpJ/oHGREvreJueu0YX52GweLd
iCcipxxE2RvG0vtZZ+towquddCw/x2315z7gUOypOP1XOVgcW9Tl91ip0YX8XVMc
9syHX/TQEQ3EtWzQa8/mOJflajWuN56eU2CU43p+IjdzHQBAH9fembFjlJWNDLC3
m3hbSn0FTYxb5UvFBdcZ1rrIkmcJmpVJ31vAfrAXYHr7MCz0AafpRqjfyAQHI/WN
3I9QLS51wbcJ+8rg/eGi0lUyBhKHpicgI8HY9Q7c1IxUnWNT+z+ziNQBkGmkkjg=
=Eakg
-----END PGP SIGNATURE-----

--VuO68Z/CU90YfXMp--

--===============5779091942271718682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5779091942271718682==--
