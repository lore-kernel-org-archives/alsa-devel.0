From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Thu, 29 Mar 2012 17:30:06 +0100
Message-ID: <20120329163005.GV3668@opensource.wolfsonmicro.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3436536895515252449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE89B104524
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:30:08 +0200 (CEST)
In-Reply-To: <4F748751.3020300@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3436536895515252449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/CHBEyLWSSL2QXIQ"
Content-Disposition: inline


--/CHBEyLWSSL2QXIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 11:01:21AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > Applied, thanks (though checking return codes would be nice). =20

> Speaking of return codes, I can't even get ASoC for-3.5 to compile:

> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_bind_dai_link':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
> 'EPROBE_DEFER' undeclared (first use in this function)

It only works on top of Linus' tree, I'll be rebasing it once -rc1 comes
out.

--/CHBEyLWSSL2QXIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdI4FAAoJEBus8iNuMP3dYjkP+wQ4C/cuUFt42YYsvTxSTqvx
QCIZuD0z31mnaAlN45X8QbRff7zlk1g4ZD5Pg7YgIi5d7sLi1+MtjZNXULymSItv
jYwBiVgIk+4UTKT1JMF7NwLOFLybyhI5Rk5IjehfpFOnFeoW/jPBCVHu3o4aOVnH
f1lVMmWBPyZipB+AxXSEASBe6+PqxODY40vXlB4Rp3IXtoGaxPIppzMsGYqWWodb
m4H7MWyvgAihcNajt2AoT4A1qI8Vw/e4BPMyTBEYOVG4j/fSe9/BqD7Vm79MWbsR
92IwA6sAbsaHDNqK2Yq+rYoZXg3Ia2GOoTFc48m+nT1EXG3AuYNXrdsGHLwS6hhG
+EgrX2S1nwsD6IxeszXqzmFHAqzB1Xk1NcCSarNmYw2k5A00zIBvH9x8b1ejmDoV
Xs9G3v3LsEdRacadqDFJ6NvMLyHDxUWYQ2n/dBPrZSk6HDlIaZSwCVOG5jIXebmQ
Tnn6VCQEjlptr1a4uSngroJuRh7qL+GKh3WiJitb4G9PDlSrX3DWMb+xVmjqnYzn
Ai4Z1sX85ZEsqchml/wbN373OFY42h10Prg7AIEAWEQ+oZttR92jlMIzYyhMdRDa
ObOqLeHZdVYEOnHOUpIEMk0SNPnciFHPKQ20MHOw85dOXC0fPMwkvks6yWtwNRTm
HIaJrURLfFFZhCjElPPl
=3r/R
-----END PGP SIGNATURE-----

--/CHBEyLWSSL2QXIQ--

--===============3436536895515252449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3436536895515252449==--
