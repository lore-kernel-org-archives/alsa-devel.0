From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Change spitz_ext_control to take
	dapm as argument.
Date: Fri, 17 Feb 2012 08:07:22 -0800
Message-ID: <20120217160721.GB3170@opensource.wolfsonmicro.com>
References: <1329466556.21113.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8251395815754524683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4B062458F
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 17:07:28 +0100 (CET)
In-Reply-To: <1329466556.21113.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8251395815754524683==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2012 at 04:15:56PM +0800, Axel Lin wrote:
> This fixes below build warning:
>   CC      sound/soc/pxa/spitz.o
> sound/soc/pxa/spitz.c: In function 'spitz_startup':
> sound/soc/pxa/spitz.c:116: warning: passing argument 1 of 'spitz_ext_control' from incompatible pointer type
> sound/soc/pxa/spitz.c:47: note: expected 'struct snd_soc_card *' but argument is of type 'struct snd_soc_codec *'

Applied, thanks.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPnqfAAoJEBus8iNuMP3dKyIQAI0tc/lEhMoaWpnzQaRkU+sj
bNpk7yTFXkk4ZaYEcSq8dPdxrUQvCYGVdu90BYWzR3pRakfdU38DKZj+xg/MKQjD
1REUC3EedH5m2xJ4BvPHaG5/BEx5kSEfAUZ0RSrUzSP1mJr8fhi0xgtrKWAvIYwO
56Ye3lKO1KY1xXCb0WsJfBp64q4zlnAvPHlFZT8kk1AFl1zTmr6JWeqSr1H45ALy
maL74hc2DMm/16EOqMw3y9npG5tGdHeyzI9VTJmxDOiFQf9ddEfe4MAyb6YkC+VX
pPUlH8Tir4x3jxMprbrT+y2V9LoatmcWRqlrIo/kz1tavCpC4IKmF3Q657bDL8a7
7haDRWwwiIYmBn71p5H1XXOMScPX+rRIw7CI8WXNdjXppA8HPmOeB5xHyxu3Wnww
ye2uKeBbH/p6ydQr792HIVXzaNtKPCN3Qxu/hzpP3JbEeEsa+T1u+Ql5MBFyGE+P
WIxGvn9zpw8ZClsD82cdVmMV5gYpXgLURwmxfh03n0Tn8C1RePHlF1nRZ9Z/RHAg
NQSwP8SEwDG60gs1r5xVAROOCU2y0tsyQfeC/GpQT7w7H5G/doZoJeU29LbH6bMP
i/WHuNwy4oCrJ4/EW7uVtMIBGDqRIEMlrj6ysHKOCB3ctFAqS1/JmdT356yGZebO
FWoVTWTJ2GvNI2An3hnU
=fr3A
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============8251395815754524683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8251395815754524683==--
