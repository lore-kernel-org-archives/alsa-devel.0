From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
 helper functions
Date: Tue, 28 Feb 2012 14:30:30 +0000
Message-ID: <20120228143029.GN3683@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4B442D.2050902@metafoo.de>
	<20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4C94B6.4050508@metafoo.de>
	<20120228125244.GK3683@opensource.wolfsonmicro.com>
	<4F4CE1E2.80404@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3743536425260106195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80535103F1D
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 15:30:32 +0100 (CET)
In-Reply-To: <4F4CE1E2.80404@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lrg@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Mika Westerberg <mika.westerberg@iki.fi>
List-Id: alsa-devel@alsa-project.org


--===============3743536425260106195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="31zvzas5NXT9fief"
Content-Disposition: inline


--31zvzas5NXT9fief
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 03:17:06PM +0100, Lars-Peter Clausen wrote:
> On 02/28/2012 01:52 PM, Mark Brown wrote:

> > Looking good.  Can you please resend the series with this fix applied
> > and all the acks you've collected?

> I don't think there were any Acked-bys, just a Tested-by from Shawn Guo.

I think Vinod acked it, ICBW though.

--31zvzas5NXT9fief
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTOT/AAoJEBus8iNuMP3dyxoQAJqUDiqf79KxkNvaKnl6zoHw
8yQd82laZb69UOZl1U6LEnQf5HQ12n+hb+wMGWSX46MPTAfFLE1GCkupgYr0Dc2k
t/60nOicO5urK6I8JcwCHvTkSM8EaM3MMuhNWGniHHetIvJ4heVn9ukRiCKpX9Qt
oHhdyx68OBgxHdPpLCLQU0HkL5tkYAITF46WJrGut+sStYg2Z9v+ZwMfFsoIubf8
QRSGzrrfK4GhbuXIpwnl3sc+j3RMuUueWMrSxsGaP2Tawx1K0XAza6gIUPfu6uJE
S0Sx5HGmuCByyNyU12w+NUIdvY5CkZWdudIbETmISA1w11uHwrvTBb+FOkkU2yy3
qXFBOHG9uiPe5g8qcEi0LhWIDcjdgCxyVbYXQcL2OnQrWhbDS1saPu5mRNnamTBl
2hlxbKUAkYiaxcLj2o6c+uKlnR+kyYEEcyi+oxPo4jRy15cThVMYduD5CWB4CUvy
/cX5c/pSCI/UKuwlTz0vqlSvQhKtQDfVy9H8RW1/AXCt6meY7UGQ/gVHhuPGTQK4
UI4zCfVLEepmAuENxh8hxFVpsfhDY9i63yunv+8osKJKTjp6uKPd9cHHjDRdxy60
1uqWFWSLQXhPrIiA31ysXw3b8Tn2JmRz8tOSjS+JYndzdO0yZ3OZjI2vqaVBIEO9
qjXYg11pZGRTyarktuc3
=FdgZ
-----END PGP SIGNATURE-----

--31zvzas5NXT9fief--

--===============3743536425260106195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3743536425260106195==--
