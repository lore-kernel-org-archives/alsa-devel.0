From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap: mcbsp: Remove redundant
 checks for the st_data pointer
Date: Tue, 28 Feb 2012 12:40:36 +0000
Message-ID: <20120228124036.GJ3683@opensource.wolfsonmicro.com>
References: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
	<1330416452-7195-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0854104438724914939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61214103EC7
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 13:40:37 +0100 (CET)
In-Reply-To: <1330416452-7195-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============0854104438724914939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 10:07:32AM +0200, Peter Ujfalusi wrote:
> The parent functions of omap_st_start/stop also checks the validity of the
> st_data pointer so we do not need to do it again inside of omap_st_start/stop

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTMs8AAoJEBus8iNuMP3d08QP/AjmIffViLhyBJot2M7cU2zG
oEquLSsVQEKMOCh8CS4AAuhHkpE0ych7ZUC18yhaV1FK53E2gCLj74DMq2+/sev4
DEaVZ/vUXLV0av9541VDEI33aw0K1BRcWZs2rDPs6+F4MWuK1UusQKhKQKMOM9W7
L8IvKLqkkqtBUJIIaiu08Y07xqdcSI53hduxIEUc3Rif9UGpE3kh6+cfi4jwBodc
mqOGDfRmNpVRtjXIV0gFMaCYgDoEI9t6YN8pBz4Ek6tN/1UStyhR+LdR8S5s0Qc1
MWvz+ydzXV+TCmvriryMEmopfGvhT5qxqHDxS7BIDfRp1fk2G5CABOcnnNSdzQoe
RsCbzb0rVB+7dMDr5sHjbkgHfYTiRM3eYZKJvo7G1k6nTw3KLwa6yYaxhi66l5nA
MPBBTJi7o1tLW/hu9MGlR9aVCodynHWNSZLtc/dr6Yl7kONfuf/Iwiiumkcd7y8y
KmU+eMa5ykDDLeMNY4NNKgmZI3U1fCUpwg4rp0oB6V/qJnU2O/FwU39lkfFJjWDh
pwztqRLHa51hCcLjc2+/VkPVL6yKbVkPOdYDlyBGoUNcpizeGOnaxGBXz42o8pn7
AUgNtyGGz2v3Qxs3xY2CdwcKf2DjbVfubw9KPWY8XFi+8t8QniMvgnqMlPvmD7Gy
vfEEusspdLn/3egczW4i
=qGlX
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--

--===============0854104438724914939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0854104438724914939==--
