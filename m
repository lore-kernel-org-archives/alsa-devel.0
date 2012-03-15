From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: omap-mcbsp: dma_op_mode changes
Date: Thu, 15 Mar 2012 12:22:57 +0000
Message-ID: <20120315122256.GI3138@opensource.wolfsonmicro.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0443905042404635408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD67A103E93
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 13:23:00 +0100 (CET)
In-Reply-To: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
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


--===============0443905042404635408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 12:37:12PM +0200, Peter Ujfalusi wrote:
> Hello,
>=20
> Removing the frame dm_op_mode, and using packet mode in element mode on
> OMAP3+ to transfer 1 sample at the time between the McBSP FIFO and memory.

Both

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYd8aAAoJEBus8iNuMP3dCyQP+wW8jFtnk3eZB1bwQgXUHFGW
/6dzzw7lwRHoleHQ2mQgXo2+HYHvAfkbgwMzyAr0iF/OiTukBa1e3dZVK29xOGUg
b4xKrQ9DNTrwj0FzEoXHdSLJc11zOKA1fFsGAlbVD30DOqxWXM8ntCGxGOloQn6V
CAc8SK4MHXL6vreOtst2e+ul60Syg/bHOmXR24F3G2RU0jojruTAVu5mEWmIKLYY
mM6QUjTch5Foxi8ekRj7V/9rRu0hIE6nj325/ew9scMzvk0Z68U9mCiaEDKYFuGq
baOETSjMHvf9xo2JcZjXVyT1VGnUAOLbAhPZ1IWkPvZiQXN9/LLBL+LpdfB9FcVs
jvvb8JgfYAvkHddt8GgmxhLk137R5PPGLUNMlIjOMnzSj9JkCTrbcTrQppnH6LJk
/W6x831dh+1BMeE5PD//cvqWgNfKXBeCnKzwd+3Q/P8Da4f0NKCDlmD/G9t0lVUT
T46Oww55R+Votrpv/H/EGNKUx6viqK0ZxJQX12EwWm4PPJJOcmGx1pjV5sq97mxE
bQuwCJLrOm/Wqtynqe4JcDNou1/6cs2vltQytUQwYrvjxgXzQQzcufTzI6cdOU8C
E1Ky0kZNytlpCOMTc/yIWpZ9zcpB3n+xm/J3rGHVZ2G+yJPebYOtoWLih1Huz7QQ
SMGsC0raIqaVMxmBpSoY
=jU+W
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

--===============0443905042404635408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0443905042404635408==--
