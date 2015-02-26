From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: wrap runtime_pm usage count
	under CONFIG_PM
Date: Thu, 26 Feb 2015 10:59:45 +0900
Message-ID: <20150226015945.GT6236@finisterre.sirena.org.uk>
References: <1424880472-1714-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783174359651293872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF22261527
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 03:00:48 +0100 (CET)
In-Reply-To: <1424880472-1714-1-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1783174359651293872==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fbglzKaagM3twbm3"
Content-Disposition: inline


--fbglzKaagM3twbm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 09:37:52PM +0530, Vinod Koul wrote:
> The struct dev_pm_ops defines usage_count only when CONFIG_PM is defined. So
> we should use this variable only in cases where this falg is true.
> So we define a local variable and read the value under this flag. In non PM
> cases, we set this to 1.

Applied, thanks.

--fbglzKaagM3twbm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7n4RAAoJECTWi3JdVIfQnCsH/0o6CpK/Lk60GDHL9NRJamMh
Aak8dZ8DIahKt2JF0p8GrU3u8hbYSnT+j4yN2lnQOyW7gFlO8+llRcWgGCF6aZhc
JHMirikVDzXVCrtTxrcMTwMu9MhkJ3dzdOmqFgcYNYwYXtpgP0d4C4+T5/7EGA9M
YL4bfT78jxJFwUs5nZOQXiIUjwa3xlUdTIDs7uI9Kjm98p1uFOpdnfwtcdQnvsjM
Q7+ENt+7gY+vcl5c+1McNj3bv1EkjQlK4kbC3UNZd/L+8DtgpBftX/3tJaCY+RXL
apPo8R5rQIqjtC3YpQHUC8lE3+4EWCeYBh+Xcs/w4bJM/4Uu45zuCDsxGx6jNjk=
=2Y17
-----END PGP SIGNATURE-----

--fbglzKaagM3twbm3--

--===============1783174359651293872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1783174359651293872==--
