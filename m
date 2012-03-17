From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: p1022ds: tell the WM8776 codec
 driver that it's the master
Date: Sat, 17 Mar 2012 21:11:01 +0000
Message-ID: <20120317211101.GC3315@opensource.wolfsonmicro.com>
References: <1331933572-20658-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0916639326145606978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A55D0103F04
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 22:11:05 +0100 (CET)
In-Reply-To: <1331933572-20658-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0916639326145606978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 04:32:52PM -0500, Timur Tabi wrote:
> The WM8776 codec driver requires the machine driver to set one of the
> SND_SOC_DAIFMT_CBx_xxx values.  The P1022DS machine driver should be setting
> SND_SOC_DAIFMT_CBM_CFM, but since that value was zero, no one noticed.

Applied, thanks.

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZP3eAAoJEBus8iNuMP3d1qwP/iwUJsW1N7Dlj0xcIRscPYmh
YM4MqSTDWkakG2zBO3wtUULTiHbkAAAV9yDGvUdH2QjYpJNUJre43ZXOysy1aRx1
nAlZT+nVOMYZRRCNIx5XYJoDVWS1jpj6IhQV38sjMKhxf+dJP6/1+f1raBnoKEpP
Xl+5SGudpIutl7ugd2Ewns2+AafQe2pgjAspf2mIRO9lqVMHyvaiAIKZkp4Ru+NZ
C6ZHoFSAqNhGI3+TVyrbsiatcAYjVQBuFJbLYeH3ZrzyY1S1ep4AdDzSV9G4UGuS
aNUjgJa10ncQ0YmCoGJbjk0CAhKyBjqg6AvZmDs9qmXU6SajMNxVj7QLMgQSy0iF
ZOlCUClmFYE/bslGTYWDR/bTGT7+WIgjDQrpGBWn+FLoQ64De0geAMHIbH6MGzeA
3Aj5PSN4x45zyjGOLUkerNBUX6M9h867XKcULdVAl7nUaAr2oj16+h8ki0DZgdRw
r4hsQAil5w5hp14VDbjJmPzCcb7jPJO9pUm/MBVKM0zl4N8OJpdCj4zjOp4lh6nx
LYvu7nG6GdI2eOnBVlvjKJ1bZGD0PBaT2Gxvz6cSXCuxz1jbQI9scA0WSOpnfYL5
kz/TnoiyJ7aobb1S+9m9Dc7DIMymAIPiGQSSwW5wl5psq8HYO6AWQVxF+W0eXhEf
Sug9RmcxvPDX4oX7yMxY
=9mX7
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--

--===============0916639326145606978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0916639326145606978==--
