From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Fri, 12 Jun 2015 13:15:49 +0100
Message-ID: <20150612121549.GU1921@sirena.org.uk>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <1434110356-23516-2-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997788414314396710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46A8E266926
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:16:01 +0200 (CEST)
In-Reply-To: <1434110356-23516-2-git-send-email-yang.jie@intel.com>
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


--===============0997788414314396710==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Tx+BDMK09J610+l"
Content-Disposition: inline


--8Tx+BDMK09J610+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 07:59:16PM +0800, Jie Yang wrote:

> +MODULE_ALIAS("platform:soc-compress");

Oh, and this is incorrect - there is no platform device driver in this
file.

--8Tx+BDMK09J610+l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVes10AAoJECTWi3JdVIfQp8AH/0nWnwXBjdyLz50QJ/e+xlTL
/9fLilPIDnnnRSHCMusPnqQaRr/2ziIufDUkSSZX2kj5TUm6cN1hk/XdpXzkb95L
mI+4ydEVXsDGVbovAAizOYtKV5zfIdRa1Zzbbo4hpObacr1XW/8OhWHOFwYP/DDa
lPBM40Gi+Qngqm3XNgus2IrIKlK28MFEkGYqngQ16PmzLPjcoXho7Scqvt+vZ28P
DK3HPwjPcnXWMg5ZTmeSbkwXpAUU8Q+gXXzEcZ/3KrE4VEq8Ax/6yHzBIZo6M1d8
s7xHZN+Xmr7de9g93ZDFE+4iK3v/6/Zsw2c83JcWAji4ClLqpoTSMe+KLMOxg2U=
=mMcA
-----END PGP SIGNATURE-----

--8Tx+BDMK09J610+l--

--===============0997788414314396710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0997788414314396710==--
