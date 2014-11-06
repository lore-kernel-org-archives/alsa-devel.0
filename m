From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: mrfld - remove non static
	definition
Date: Thu, 6 Nov 2014 16:08:22 +0000
Message-ID: <20141106160822.GO8509@sirena.org.uk>
References: <1415282443-3444-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718161059079969472=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E7CF260695
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 17:08:56 +0100 (CET)
Received: from 92.40.249.210.threembb.co.uk ([92.40.249.210] helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa
 (TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
 (envelope-from <broonie@sirena.org.uk>) id 1XmPc5-0005Sn-2q
 for alsa-devel@alsa-project.org; Thu, 06 Nov 2014 16:08:55 +0000
In-Reply-To: <1415282443-3444-1-git-send-email-vinod.koul@intel.com>
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


--===============1718161059079969472==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FTZ6+qRtsnuZwWZA"
Content-Disposition: inline


--FTZ6+qRtsnuZwWZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 07:30:43PM +0530, Vinod Koul wrote:
> sst_save_shim64() is defined as static in code but header is non static.
> Since this is not used other than file where defined remove non static
> definition

Applied, thanks.

--FTZ6+qRtsnuZwWZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW5z1AAoJECTWi3JdVIfQN18H/02rHO0jvbYyXDLFRTvmlNCH
aQhKlOAv6IzBqt+ysw/vMYV/T+X8CyaXAHtEkrIRfZPMw2tUWxCPhHRX/dzYQGdd
PDQ6xJPWysCngE88FDozErUQ3QMfOJE3kng9EPgzL+BgJVHdgEt5XvgYC/cDxBEa
jF4Muv381elLNFU+A7hwCYI7NXgxF1iKMpeRoW7rlc1jUCN9XR41XIP1nHMmzdvC
GEaZhWGubDkH65p5UZl5QVeOgCkm6S+haNeUyE+eFOmFC8Ti+dn5ZXT+WYMqjtY9
asuyj7Cx9X9hDdC4Cp2secDMh5JA5Yy3hWc6db8BMR7we4rJisL9+sU4WHrCjBA=
=fmhB
-----END PGP SIGNATURE-----

--FTZ6+qRtsnuZwWZA--

--===============1718161059079969472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1718161059079969472==--
