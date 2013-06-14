From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: WM8962: Enable start-up and
 normal bias after reset in runtime resume
Date: Fri, 14 Jun 2013 12:43:41 +0100
Message-ID: <20130614114341.GO1403@sirena.org.uk>
References: <1371210546-5747-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7442917466035691187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB61D2650C1
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:43:44 +0200 (CEST)
In-Reply-To: <1371210546-5747-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7442917466035691187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rHXT7wjifYJhd5Y1"
Content-Disposition: inline


--rHXT7wjifYJhd5Y1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 07:49:06PM +0800, Nicolin Chen wrote:
> This part of bias settings are essential for WM8962 to power up. Without it
> "wm8962 0-001a: DC servo timed out" might be prompted due to power-up failure
> that happens to FLL if being used.

Applied, thanks.

--rHXT7wjifYJhd5Y1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuwHqAAoJELSic+t+oim9L4IQAJ3J406gD66/ziyyi3gOz+AJ
jh7KhQB2D64y6DUjOUfXJShV+NCdVpHzgb1+CZJmPDdk1n/4Gf/9V/8VtCIy/JjC
Quq18RY1jDtyWlt2QY/OD/wkGpctgOUaqRv6SkPCXce8JWCteja1tb/eH8PcSn71
lp+es4QJ6z77r7S97bXB7rYABWf+EfpKAR04bMtMXBHqMaHp1gXZZZs7xUfdFrWX
JzaIc/0Ncs+X0g30zRmAz+p43V/aERb2mnIFYiOLkJyYl2gS+mgiKqOvSliCXw/b
XZ1pITK4OA/0QhVOwMZ3qhDpqWw42831E979OjyCdTIsEaVX0vsOLyTBlUHb8mJB
unEHv1vFbKlNLF7KvbwhcGgASihMyIMcpBlIyofatJCKtW/QdGf6D5DviL2agbTf
HiLPudbhrSDMTZQ8wQH9+Sas7y6wHmXqLGbjW0AMB70xvrDjZX4h1HVoyivP//aW
+gQTzIlJijbWfKHdGlIoB/ovnRWrgduRqrVNbJrE10jtQS02Q4jW/YcP2ubilSaA
pv2qu5h/ePukdVOb3Ir05cjTKfUweYhOFQ/EPn8m1wyHs7hLTjSnkAWAfKyj3+i7
712hz0RaC8ukBVFJfx8DoEK2Rh5GEB72/cVyInx3H5/5ZORfhl4mIrbBFqkJ7RLB
XWLRe3dYmTv9QzLuCORH
=IwQJ
-----END PGP SIGNATURE-----

--rHXT7wjifYJhd5Y1--

--===============7442917466035691187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7442917466035691187==--
