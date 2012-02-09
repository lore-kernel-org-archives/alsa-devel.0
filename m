From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: da7210: Add support for PLL and
	SRM
Date: Thu, 9 Feb 2012 12:50:03 +0000
Message-ID: <20120209125003.GH3058@opensource.wolfsonmicro.com>
References: <1328095529.15257.7.camel@matrix>
	<20120201115035.GC5648@opensource.wolfsonmicro.com>
	<1328621149.26721.18.camel@matrix>
	<20120207191943.GB15929@opensource.wolfsonmicro.com>
	<1328791340.22077.3.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5049855324525925569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3793C2433D
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 13:50:06 +0100 (CET)
In-Reply-To: <1328791340.22077.3.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============5049855324525925569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2012 at 06:12:20PM +0530, Ashish Chavan wrote:

> BTW I am also planning to add SPI support to this driver. Just want to
> know if it should be done via reg-map APIs? If yes, then do I need to
> convert existing I2C stuff too to use reg-map?

Yes, please.  The idea is that all of the I2C and SPI drivers will get
converted over.

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM8CgAAoJEBus8iNuMP3dgG8P/AgnmyDoMXMTkyuudtEMQKU7
CCQ9U2iKnpx/DV3KiqMFCmP7dfxVtJMulym3if1oyDPupXthwrwKvdVoeExSsNDl
HayyWqWYBWscM22Rsbb5K6nuJYDdSNVyltexpt6L8wg6zxZboYWeA4z6dcPSyp44
p7IcsyeKxNQ3Ccru8chObbaAs1djl1ka+EXfEkmClJ8tg7hLEsE32b/NaeMaJPco
CNQJJ8BJNfQRxYHsG7CnX0iwXXVLUSkBqKf+F4OosRRPyJ6JqIxKQVGU8SuotyJH
m/F3ab4E4IlEo1RtP6uBxrZ/bXWL/sbolLWYDBmnp4KGJLBJ1L5ms1kvB3PNqRRh
FqSTQLIsg4KNUlhyQ9yAl1SA5TeU2zPkliuR8S5wlHV72YcehkN3ZtvmcXZf5BSw
FeCyMvsxR1/0KhA62iFkTAvFnTfRsw2t8OQMwH/0CtI39jeLAl1qs9MDrN+lH9sd
ZInc10e93iREZ+DMr6wLwd1gHigHak9ngAwXPC3TwL3mVG5r+uTOWSP70qN4EQG9
vNr1R3Uo3tFPHvFp+VHDY053Ly8jDNN39TB7O5l8Qbx0oFw+W1FuLiku5oij6VAl
sbxNdlfg2Hw9kgLpgJVkNRzEqcDgoor9sFbWBQ87VlVc/odoa6eNoyrGvJuM5UVP
wIXa2i54dYnSiEsaSqvt
=Pz40
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--

--===============5049855324525925569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5049855324525925569==--
