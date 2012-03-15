From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Thu, 15 Mar 2012 10:18:37 +0000
Message-ID: <20120315101836.GA3138@opensource.wolfsonmicro.com>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
	<20120314090115.GN3852@pengutronix.de>
	<4F612394.4060703@freescale.com>
	<20120315095230.GZ3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4139332293246483474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F52D1045C9
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:18:39 +0100 (CET)
In-Reply-To: <20120315095230.GZ3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4139332293246483474==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 10:52:31AM +0100, Sascha Hauer wrote:

> I don't know how this AC97 stuff integrates into the devicetree. Anyway,
> that's a topic for future discussions and shouldn't block the current
> patches. I just want to make sure that the original imx-ssi driver is
> not removed as long as the fsl_ssi driver does not have AC97 support.

AC'97 should be hotpluggable once you know the controller is there.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYcHzAAoJEBus8iNuMP3d0PAP/09X5ak/iovCbTu/bMzuWK4k
v26hJgv9xgsz1zm0SpaZ1MvVZk/P+y+inYXfI6KooRjdfuC+YZ/wkGHrSulSo+sd
H8XcTL52YI7Gjavoox3Dp3UygJfUfbPo4JYaVKdqWs+nKc4HOTVsdmt8k4wyxPZ9
NwPKBGPcX26pZi8PT9+iiAHmv3v7kn8lRtmVmRyuw9tnUAvcRRAS+B+WronSejIL
tGISWSArHPFOPyO3TdWV3m3nGsUTptJt3w3QtcJxJHFO3TbPy3B222tUxiJa52Ov
EJ6LMt9DIR//kCdBsUG1R5rh+DKDyt3W72WxReRwTPxBYMhLTZtk+H6k5LyfsjXW
tfYFLiaOH5MKOKPjW0+FEbYhlyGfUU9vDaUJPmJM8Qfo/0Jbv2E+0tnHtW06F63z
C932wyrAZgNXLZ63YUp0TlulH/oadut/SfLjKdWRP6s5ZvMNuoSlasLZ2CkcQ/mt
kcPK5SUfBq9ssulWVqwiOufOnnzhsVK7v1O/ehqKGoyRuRnqoCUWvovdD7nCFf1q
xd0sZSinuIQKOvUoPqS//+MfPJotvjBqtcV1u7LfIalnmhpP4P2Pa8Tc9Yd6hy2Q
MJ7exopjkAUf23JjJwrBBrwZ6rCHyyGeg0gv6IQKVl0eHou2CdOOrmLUOpOk3Fc+
5bJOSIlXLzx5IQW8Pl2S
=u4pI
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============4139332293246483474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4139332293246483474==--
