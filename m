From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/17 v2] ASoC: dapm: Add helpers to
 lock/unlock DAPM mutex
Date: Thu, 20 Feb 2014 19:23:11 +0900
Message-ID: <20140220102311.GE2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1250490153744900978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E1732617AB
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 11:23:35 +0100 (CET)
In-Reply-To: <1392736948-26623-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org


--===============1250490153744900978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zRAgBwIUb44b1VSK"
Content-Disposition: inline


--zRAgBwIUb44b1VSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:13PM +0000, Charles Keepax wrote:
> Acquiring the DAPM mutex is necessary before using several DAPM
> functions and dereference is quite ugly. This patch provides a helper
> function to simplify this.

Applied, thanks.

--zRAgBwIUb44b1VSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdeMAAoJELSic+t+oim96zIP/ivBMXTxh0KfouvagRl7eCDC
Qqi2diS1FJSA6cYOXGhDKZ88FDXLMniKGKcWfllGxhIADxNgr1pnxwn+LXWtcj+8
c9rMlmEvH5bm80Cjo6Aj8LQKNA7Ugs+WldEMUo9xVByVC5uq2fIncWLsiXw/ojMJ
OV4hw7ia+Jx/aNrCCyGgLhSMEKECClhRRM1Aa7E8Qanrg7kkkweHbogvHw4uBYo1
UKknuDd0IqGq1Yy+W+fVLXrB7VFWiIPCOxMQN0LiAkIvpsstVdmgOPgLFq6LUpXv
6pGVZMQUQgQ7Xvo7vovxhX1Z7PF5l8ALE6DV/Pw3WzQwu2K5tQcr/MdE4nriaa59
yLaYS1/Jts3J6LD5ZUqUuDutcK9GpSXEW49JsgIwESiU6G0Cx8gBDWKz/C32P0x/
2hA07l7XFbwJ7scdwp50f4RfRZDU0w+gu2yZnm4bRlolonIKX567R/8D7XzRUCag
kNDjLGDYIvkzLfrkDqRIthUz7HaMNTXbkA9AGtb7LTCjDYp2/vBEFSlTGR/hsCAz
9FwMhSvRPGuprlOHz6YSGvychxVsIUXtVtAIApVPVkTqi3b+QnLfSEICScM2Kq0W
FKfDenAf+jjbv1cnN7Z4SlLB2MM1LGmsVhHfvIdu3KsMf8GjZNoI+48e3Bhbof72
qzeQDz/WlWaSO1NOLvh0
=s921
-----END PGP SIGNATURE-----

--zRAgBwIUb44b1VSK--

--===============1250490153744900978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1250490153744900978==--
