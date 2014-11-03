From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Correct a macro for FW message
Date: Mon, 3 Nov 2014 16:12:15 +0000
Message-ID: <20141103161215.GZ3815@sirena.org.uk>
References: <1415023177-9442-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2950743422554371610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D7326050B
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 17:13:40 +0100 (CET)
In-Reply-To: <1415023177-9442-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2950743422554371610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eP8xGX2lG1UwfyBj"
Content-Disposition: inline


--eP8xGX2lG1UwfyBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 09:59:37PM +0800, Jie Yang wrote:
> For the broadwell official released FW(Since 8.4.1.43), the macro
> SST_HSW_NO_CHANNELS is changed and fixed to 4, so here change it
> to 4.

Applied, thanks.

--eP8xGX2lG1UwfyBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUV6leAAoJECTWi3JdVIfQL/MH/15WLEC1AdHz3i4m9WI25fTc
GZDuWPNvWujWE9zdHedhoacD1Ymg8E7+bITtHK+mW2w9T2q7twWthgGpgWl32p5w
qODRkwESs4N5S9WNx/eFh3dYQWPb6EMlUA2iPasKM5UhBMLAAeP0I/iqNkgvsrjR
1dLFrYYVVsSYti7JsJTZRO6xeQjPAMzqe/f4FDOcSXdEf8gzE9DZ1MBR3O33eaAh
BWeNsT1y6gRM+kF11pP3yEbEfuM2r+iMXL9tElTies/ACrbVuGaidKSXAb087uMk
MOMsEbTdcJ4h5yo5dunG0CoIK3aKT7jfwHmd5qSWXoX84vo0inW4yJGk9K6a6tM=
=iHRk
-----END PGP SIGNATURE-----

--eP8xGX2lG1UwfyBj--

--===============2950743422554371610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2950743422554371610==--
