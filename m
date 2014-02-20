From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/17 v2] ASoC: wm8994: Update locking around use of DAPM
 pin API
Date: Thu, 20 Feb 2014 19:26:56 +0900
Message-ID: <20140220102655.GJ2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bt3HvjSfDPxOMUKF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--bt3HvjSfDPxOMUKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:19PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--bt3HvjSfDPxOMUKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdhsAAoJELSic+t+oim9sIEP/2C+m/P39lZWsYOC4FdXm0zO
g72qF3ETNAuIX2fQbw5p/A5TtnxBlLH/W73gt7xS0/eALCmVamZBUbZWWCi1+3j9
kDVDl7hjFme87n5LWb4C7UZ4qWd/kSII4iPKOBXWhSnp807CM/2ORuJ1IRTEjfz4
fUjZO4SpdqPVPvjAp+Ik3GBiusQAmrbC3Hpa8BK9f/4yUJBtct45jGNXtDmfVWXp
VkyTwBrveWDyMIVg99z6kP2x6k4S7oR1brk7STh8eM6r+OHQv0mRHCOrTLFv411H
ss10E7TSMIdjkiNkbN+QZZtyEuIJwB896xeJ8VM9qMjxFwqGA2Bb8tMMGgvc1Dcz
K9NpCsUfc3WIoNNAOgcbzFoWGWfXRVth4XC6IF/Yd1xnNCXfVqXqACbRSrVcbn65
RGLLJcwuaxl3OM9c9jTOtbNQ1ANXCVgLvuqBsGeUvb7dVUuEpZH4Jx7ZkdeETW0B
2/6Rj3DbNQo08Ckb8phIWt8l5QgizgW9uMvjVjgCTtsXFp4uMgoA1hv07/YCtZEt
rvzV9yENXSCizSrPq79rQlbRH6lfMBiLWE1shSyF7okWKRz+5b7aS7GasHsvsXqD
s5CXknUBkTgIg1TI8JcwcMJDubq/pelIPSeDC9tcalRQHhBCpbDOiUzIXu92VCSU
3XlGND8pVLtDLudYN5hb
=KPwl
-----END PGP SIGNATURE-----

--bt3HvjSfDPxOMUKF--
