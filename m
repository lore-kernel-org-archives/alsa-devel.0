From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/14] ASoC: wm8400: Use
	devm_regulator_bulk_get
Date: Wed, 28 Nov 2012 17:40:29 +0000
Message-ID: <20121128174028.GV32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1370041877284516419=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 262692625E6
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:40:30 +0100 (CET)
In-Reply-To: <1353930587-12907-4-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1370041877284516419==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Content-Disposition: inline


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:36PM +0530, Sachin Kamat wrote:
> devm_regulator_bulk_get() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.  CC maintainers...

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtkx7AAoJELSic+t+oim9sb0P/2f+2mkuoomy1mVsjLaomjW5
FrnCp0x59DbYlvHEgisnHY5wITzp2dH/SRlAf2pYne3+3EK35HYeyQ7oDE2EI9qM
nzjX/1oMhME62i2stnQe1Iu3grbQPgCvTDD0Q2DdKtVlCDPNg6hrny9+jHk2/vfB
T/Da7PtcrZiwen1sPSDj/PWYCpFJZmlVO1yjpF7ARF/bmtOdztLmwSOSvbolyks9
zJ13V8pwQvYr851y+7PbO/9H2JKYEzsDWMEXOpBB+GRW7y5fOTVMIB+DdNwOzR+q
Fhh93GndFTMHEhvrISG/g+S03G2RR6cGS4FGgKMoERsDxgHKoPu6lyf+488gcX35
ecwYtjt3/N4ruO3RrkbELX1osv5q/vvBx9B0NEcaAuMGUYrR7hNHTe4x8xLkpHHe
0oDGKWUSJ24qGVulW6FbgRz8IFBIaKMKqfwjGbcRlXYkkpeOSSLSRbu3moSYohay
HLP85kXeAYpF8Ws6Fs7GnQ6fiL5cLn/+mV5SvLI3GKIx2JEQ5qvKu8DGbTqXY4F5
4jTlR8zFg0sDU4e6pu+ytP6G+2YqGlnUKchYhIlFHrf+cbMq3hQnHDYuFDoXeWV6
g3iak4npA02W542YsrfMrN9t8XcKICjY8dJNcsXcBUAEEMaV7rnscGVqpnDOgvVJ
2gHIX+YwPLwFtlslEfSe
=wYPl
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--

--===============1370041877284516419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1370041877284516419==--
