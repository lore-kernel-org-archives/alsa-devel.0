From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Fri, 9 Mar 2012 11:53:31 +0000
Message-ID: <20120309115327.GD3273@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
	<4F5912D0.2090800@freescale.com>
	<20120309012653.GG2499@S2101-09.ap.freescale.net>
	<4F596674.5030405@freescale.com>
	<20120309032128.GK2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7465223995883640238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E84710B967
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 12:53:41 +0100 (CET)
In-Reply-To: <20120309032128.GK2499@S2101-09.ap.freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7465223995883640238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 11:21:31AM +0800, Shawn Guo wrote:
> On Fri, Mar 09, 2012 at 02:09:57AM +0000, Tabi Timur-B04825 wrote:

> > That's the general idea, but I think it needs more study.  I don't=20
> > consider this to be a bug that needs to be fixed ASAP, since it's never=
=20
> > been an actual problem so far.  For instance, do we need to protect=20
> > between hw_params and _trigger?

Yes, the capture and playback streams may run in parallel.

> Ok, I will leave it to you with a big "FIXME" comment then.

You probably just need a read/modify/write function to do the locking in
the style of update_bits().

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWe8rAAoJEBus8iNuMP3dstMP/2T6/VAqQ4erWkeryPFRJNL8
b5WoNpe0+hAHTYbuGpCRIUyWURtOPKhM4Ei2l00MKXfIsB/7ZHoaxBao/bfh1hDH
Vq50Wyzkwl5f++Y4JD8HN2ot30HyYqgAQEPHeUITV2sfZQHnrEGPyDclTLxSFWhp
9QI/l69Gt2hpKySWqCzHDNr06fguxPPNq0zg+7zj7XXOaDATldf3mb6AO3RM6mie
Ip9h/x/r39x+RERFCn18XFpGg2E72r4BLORkN/ndLAKqxIEmFei/BXvp5PmXbJvD
eRS9ZBj4LGQOkmBit7IjsiQmwgY0xtgXei35Ekqg8831wVv1YPoDDok3V0Obz9xJ
NlN0uVcQlS76CyiLUvU7UiFvYm6oUCXr04ViXq9JRpEByLM7y8BmM3dc1ZkPWxlK
7/Owf44S/Tc4bMxsBQ28gN4GQMVc6QTETHyf9sE3p9v9X2y2fEUHalMkgOtQHUSI
RVEJZ6Y7IzOg3iv2fwdOtrxLwuxsBBVcY3ruWZZpWZkoq8/rNj6O/IWXLdmP+CiX
5vjKEiQ4smOP6MLlZ+NWioNhA4JEINoQHx1Lp/xeOZ227JksQhnDNggv5dTinxS8
DzXD6SdZyYni+DxWd/O4LqX7HaJzsj0vMM8eb/oEtURfBa2B6QCYrdUym+fcvr6m
oNIGNvRmbHog6xVtIWdY
=ATIs
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--

--===============7465223995883640238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7465223995883640238==--
