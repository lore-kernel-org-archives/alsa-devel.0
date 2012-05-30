From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 V2] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Wed, 30 May 2012 11:22:00 +0100
Message-ID: <20120530102159.GH9947@opensource.wolfsonmicro.com>
References: <1337915528-11887-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5714238049317569509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337915528-11887-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5714238049317569509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 11:12:08AM +0800, Qiao Zhou wrote:
> pxa-ssp.c uses API like cpu_is_pxa3xx(), cpu_is_pxa2xx(), which is
> defined under arch-pxa architecture, and drivers under mach-mmp
> can't find it. so just use ssp->type to replace that API.

This doesn't apply to for-3.5 (or Linus' tree I suspect).  Can you
please regenerate against that?

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxfTAAAoJEBus8iNuMP3dQV8P/3rbWdaQoUcVXCgtq6ZU4s7n
cbw7kpHnzRgIjMXxeXE9a04CULGA+Wu1sZHgCwq0pLyXu+5ThhNMtZu5bz8iOYjj
MVaf5HOy27jecGLAKf0GBXR7vEmOi8j6mdkz7HtvitP57QRPGdxfkeUUvFLBV2u/
bmj6bmZTxzgEh06Os4SSiVVN0/iUjz1DYbr/YlYBIinEOjpGNIx3NNWWwQ7tmR6w
r7Z8FZNJ0RapdZj6RV2USqK1l92ooSDlI6Gnw2kID2Q3ZX4x5OQZE/Q+fWJ978Ep
MXoXR2GOfECrVUNP7MOryXYJ/YRnY/0Art6/9TtNOHUOUwCUzThHrYCL8wxttLQF
lvaNGpLT692B4/5OYOrDgb3td4zvKtussGDP2bNWrmPiyhg9V/IGGYNKSBYZcRhK
+XiJJfHaeeb89YWEUG73viddwdTlEU5Yl0lYV58uEmhDA3PwSRoKrF+5lKl7R8Cd
I0aE+IZFgmQgA94B2KsRYiEf2AYCCr/e2NTbJkZ+RcXLko/T8Kh75SnCFdpgQfPA
l79CoyknouMIXxYuGxDx9dLL6u3skvAVSoIwvduRh266AeYDTMWq3JwvvgL+nlw5
XH7K28cQnK4SeK5MnQpb5aeM6aPVrXqr7zz/KLzQzyeGb+vwXB9sGv6ZHNoVElI3
J/0RVN4cZNaxCw945gjb
=6Phg
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============5714238049317569509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5714238049317569509==--
