From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 30 Apr 2012 10:56:01 +0100
Message-ID: <20120430095601.GD3170@opensource.wolfsonmicro.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
	<4F9A649E.4000300@stericsson.com>
	<20120427093516.GB18260@opensource.wolfsonmicro.com>
	<4F9A7B03.5040802@stericsson.com>
	<20120427111123.GD18260@opensource.wolfsonmicro.com>
	<4F9E526F.6090705@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2367834734345597064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36301243BF
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 11:56:04 +0200 (CEST)
In-Reply-To: <4F9E526F.6090705@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2367834734345597064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2012 at 10:50:55AM +0200, Ola Lilja wrote:
> On 04/27/2012 01:11 PM, Mark Brown wrote:
> > On Fri, Apr 27, 2012 at 12:54:59PM +0200, Ola Lilja wrote:

> > OK, then why aren't they hooked up in the board anyway (probably fixed to
> > a specific configuration there, though there are some use cases for
> > changing)?  This is what other CODEC drivers do with their MICBIASes...

> OK, I will have to investigate this possibility then... I'm not certain that we
> have this information available from the board in any easy way.

Usually it's very clear in the schematic?

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnmGmAAoJEBus8iNuMP3dReMP+gI+KecCDdBPTnnpXrSxa/l/
/Zy6w6PuboswkFvdwviXQNc1NdJ/xiFOo5AyKijUb7AwBVi6OGhAIfTTP7HhHocl
m4TVqr/4ZoCMEl8cdANeuUFn/IqREQw2zSM/VkPpIMSkWHUPpx5viPv5Q8JoMG0v
1GAv282Wnd9Ye1YAWjEUpscdVOi9zaNorcfYK9MaMyBzNWYenGAD0NPtMbdnOSVW
DDwzndFUFH9O7y3d3D8krs8nrNxHeWnjTuBhVaN+Dm6uVvCGF5ZkyXa81dDImZqU
0NMRglavy1dezJ9NA5qMrsi9TZM0luAb5vUeaXhpeyMcvV+QGkOn8WYoPn76B/E7
Kl4y10o70LayJj2lsTScvty5+rf1aCqCBCu+3hnnSVV9xihSsMQkNOxGut0RI20R
KFA2w1YGwD3z0U4XzdW+PxPksAXG8v5jdx/wgTSpMdzkm3WzrOSRCPEJc8PQBGNv
hW7fUlrNXdaLiVb0n8ihBcIhLonfVmIYTGqVDbe3POEN3xmU/N4o//ZId2Bmka0/
UcgGjkyhHyQigcL8F0vjVrEow7IXgRmIccGS//BGl+huLS6yHf3Jtd4u1GIfGQHN
c2pncBJcpRgec1OTOw+ca8CveFdGvQ6++wuLXVhRyKadzbUS/mdHuJ+vJZmYj3/0
Zw/0BbMNGKDZSyjiJ6SR
=DnNo
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

--===============2367834734345597064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2367834734345597064==--
