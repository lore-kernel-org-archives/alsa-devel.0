From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/5] Intel SST driver restructure
Date: Wed, 1 Apr 2015 23:51:51 +0100
Message-ID: <20150401225151.GK6023@sirena.org.uk>
References: <1427874143-26256-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4636205458833202055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C3B726154B
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 00:51:59 +0200 (CEST)
In-Reply-To: <1427874143-26256-1-git-send-email-yang.jie@intel.com>
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


--===============4636205458833202055==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 01, 2015 at 03:42:18PM +0800, Jie Yang wrote:
> In order to prepare for the upstreaming of Skylake drivers and to
> allow reuse of code between different Intel audio DSP products,
> this patch series restructures the Intel directory as follows:

I've reverted these due to a series of build failures reported by the
0day tester.

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHHaGAAoJECTWi3JdVIfQCN8H/iv13cC+Hc/SY3pazyXcIQAw
TbIU++ObFhhqQbt4jRaDMHRJ5N1p5MAwgnB+B6gwFu9cM469pSkYtryGeu6dO3eE
B89W34jnfjT/5798rh3yPqDP4K97p+hnuQoZ5ZdDyERf+FxQYCE0XThCuzdX+KVK
y+amuwTTcU5H8eygqkTv220mRW9epzXe2oIoQNLb1623zlPRueWcRtkyL3Q81oJY
tJq3I+EuYDxJKuqvpQunBBQQ+jDvhAx3COt574NGIzNPFBdjkFQ1cuRV1S1+QaLy
NKkRVeaNUd12Oy0h1i5UKbgCYc9ju93ih5hC+4c/7UqxtcD0Pwqzwi7s2CsdJLM=
=uoV+
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--

--===============4636205458833202055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4636205458833202055==--
