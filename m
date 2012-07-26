From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mc13783: Provide codec->control_data
Date: Thu, 26 Jul 2012 21:36:27 +0100
Message-ID: <20120726203627.GE4560@opensource.wolfsonmicro.com>
References: <1343327343-10159-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2520064381380326299=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16DDD265F28
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 22:36:59 +0200 (CEST)
In-Reply-To: <1343327343-10159-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: philippe.retornaz@epfl.ch, alsa-devel@alsa-project.org, lee.jones@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============2520064381380326299==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 03:29:03PM -0300, Fabio Estevam wrote:
> If codec->control_data is not provided, the following crash happens:

Applied, thanks!

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEaooAAoJEBus8iNuMP3dGREQAId+jpKY7/23Pl+x6Bvoinsy
xmJxvK8ZVsj9yH6vRn2emyNn6EmwRrutR9szp4ramH+vSjuNJYM0HXyHEVn7yv4l
7goH26JkP9RyaiUilfpwSQc3j0sHfPS/jG/ixTa39+Ex5SyBJOGgMxGFBUG7/Zm1
IbjvZT5oVPFMZlt5wlLMqPG25YdHnPoZY4DM2iNyaS7pQpw9cpMOd0tU8BUWaP50
6XtqaOKsfOdliX8UjYz/tQ7zjqqMfd4AUbYXu/+3+MxN609kiZsSZHavMQsx1Rw6
NKznlInKcRW61riHYlAMI3USjpgdWTcqcibuDu9hdDBqe/PHSmmYsdbU7kjZ7z/5
seUbAaKuudHCbG+r2F65bXrONXtRV1hI8B7Y3p4fyY91KG3g/ao364IwLqrRN/74
kIMFfQIzvem2XYu9g87pXmhMmSC0bmB2t6cw0mUpD7AG4MRBaa08AqsRr9AfFEkA
xC01r4Chn165MRxj9SsrvrJOz5jxlyE7kKk45HkqqGeJCdksdaaEVqIBvz8kMdCl
V71A6fY0/UFO3fauV3ljDJZWvmzOV/yTRImpEEUd4DX6YnO8qwLu8yPHov7DYK7T
+pOb879zbv7AS5WLQSGepgjaZsjS3yrZKMYjwz7uQh0gZ7BLDebwsBpHTwPV4C8K
ZlvLx62b6bgArLDknBL7
=a88/
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--

--===============2520064381380326299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2520064381380326299==--
