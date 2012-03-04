From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/20] ASoC: imx: move SND_SOC_AC97_BUS
 selection down to machine driver
Date: Sun, 4 Mar 2012 13:34:43 +0000
Message-ID: <20120304133442.GD3083@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9201163783465440406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B0B7245A0
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 14:34:45 +0100 (CET)
In-Reply-To: <1330788001-10158-8-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============9201163783465440406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2012 at 11:19:48PM +0800, Shawn Guo wrote:
> SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
> Rather than selecting the option under SND_IMX_SOC, it's better to
> leave the selection to individual machine driver which knows if AC97
> support is needed or not.

Applied.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU28SAAoJEBus8iNuMP3dqwcP/35OoiVHHS9J8cJ8X4MugK5O
ksaLcA3I6209MrrwmO8gOs6AWDo0G20vmAbYj6mjGIJNGiRyG0Adga4NEW6iJ9qH
Q2GH3Eunm95Cp2xuHMLMktpZbILIew/f+z5n5WlY3b+5XJHv4Hu6Zjy6c5tUM6/8
FY2z1sVAFp21MevSwUCY0ONXQGeVEhXPpHUTnO4osnR3NsjtME3ENVHcGY5Wqx6n
O8+Po5NZSXrxpvKyQyTiIE7ZIY5rPsIZwI2u76M71bYdG1p+shwMufd9ehARaFVt
CPOjoRz1bJVeuV9/e+js3u91rWakbh+KK7/iXBEN262LOmnKRkcmfNoSRP1SxVRz
cnNUj0u2w4ZulAQCssXbq9aN4/JXJZ8yLqPefM6x0p6mcWeEkYZp6d1lv71/WJbr
F07wzCm7Qi1ixyiEfw0LRO4Y6VafsyeNLSuwL68815W7Eq0HFc2kTa3Qm8k6zKN/
EWlNQUOSj/+KPEIW31iPk27WQfolUtyu10767klvx3JfwCd89jUhyBdoRBEypnUI
kqQLuLKdnPOiccE3CdblCeVFRz7b53OsZd3NZeD9qv/KBMXPlQgWX+IhR0avvtj9
NXh2j9xEFfN1a/drnrfqwfTi0fwixSdLOLXBZHyfrSajeiRLOSFr21BPgttxuhTE
slGhYjgB4MKLgsNh1X2n
=eJQU
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--

--===============9201163783465440406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9201163783465440406==--
