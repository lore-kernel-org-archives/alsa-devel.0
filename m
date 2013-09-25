From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Wed, 25 Sep 2013 13:35:36 +0100
Message-ID: <20130925123536.GO3226@sirena.org.uk>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
 <20130925113103.GN3226@sirena.org.uk>
 <20130925114643.GH5132@lee--X1> <20130925115502.GI5132@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7103402602685627318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 699002625E2
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:35:41 +0200 (CEST)
In-Reply-To: <20130925115502.GI5132@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7103402602685627318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2013 at 12:55:02PM +0100, Lee Jones wrote:

> https://git.linaro.org/gitweb?p=3Dpeople/ljones/mfd.git mfd-asoc

Thanks, could you include the first patch as well please (there's a
dependency for bisection due to the BUG_ONs)?=20

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQtiVAAoJELSic+t+oim9GqQP/AvyjipTpukMsi2CS4WMZXx6
G40G15YIMGcZxQATl0n9JXSTB2C8Dc4EY0Cy1oALMQMK6PpWibm1n0WyTiBFu1bh
IUFHSaWaZC+TI+1BfT2QzfVZ9PO/aUKqntjhYpx4MMvN+QV/9BCH1We9cF2lk0fy
bslKhYJfFcLksSBOD68pSDI7J3h9V+O3inKuQ6kCqi+NsOf7tQhELqe2VaXu2HQZ
IYMuqiFVwx34MVX1RL5ErrHO9dcGS/ZIpcU+xjH6QsaSbO65NcHB1a3Cnz6UNEte
U7/Ml5lHkSYhtDdJxrL+a6Zd+U5h0MYB0M4etRULKZq6yvrSH9L+WyAs8tW5EYgy
caAs6qi4zTq3mSBb3dU/v1xgIsI6jdhsKDxzExZxOvJbtqlHZaik9Hd3ENPY4zSX
SBnSU3TaWRC5uMhg7eJruviumc9WK5nCwhG9/Z347hlykSpDrnD1gLUpNdcELUSq
gYiZXSiFBO7hWrpg4F/OfPHyDDTZuGX3yrWTMILDxmcYsV2pMxP4b16dXQLvgTNp
cfNp35NeN7ZoZ980xMUcNmPh51i/XpaGlR2XXDtxFd1rVQCEw5fDqBNRqa5OozCp
dnGNg4mB+X7nokBFdHijq6cOuf7SnlHrPAMjPOp74qXbd1vRCISlHFaq0l7PNRor
asXDyv09bK7v3Q27BBc7
=DH6Q
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--

--===============7103402602685627318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7103402602685627318==--
