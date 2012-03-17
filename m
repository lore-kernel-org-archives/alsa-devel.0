From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pxa2xx-i2s: Add
	clk_prepare/clk_unprepare calls
Date: Sat, 17 Mar 2012 21:44:12 +0000
Message-ID: <20120317214412.GG3315@opensource.wolfsonmicro.com>
References: <1331835372.14662.8.camel@flow>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2694331388512201643=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A155103F11
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 22:44:14 +0100 (CET)
In-Reply-To: <1331835372.14662.8.camel@flow>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2694331388512201643==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 07:16:12PM +0100, Philipp Zabel wrote:
> This patch adds clk_prepare/clk_unprepare calls to the pxa2xx-i2s
> driver by using the helper functions clk_prepare_enable and
> clk_disable_unprepare.

Applied, thanks.  There's probably a reasonable case for a coccinelle
based conversion over the tree as a whole here...

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZQWcAAoJEBus8iNuMP3d5iMQAIhE3zdutdwZCcKSsbTZ7N8h
2WsBNyufT1XxP/OfOBVFCewxieHs1kcy3czcrW8rkFlA9McAE+N4o0y6+7yOWGCG
5tA2cPbUY87mrKItkDPkBMeJO6DjDdFNuIXYI0jNh+BiNj227MUlTporglc2Qb6I
QUhQXiciu+6XZQtaLYD8X7eBYso0IBDkx30ijEPmopwV1BeOTA06scDCvO7edIB4
TondTHeHLr0Ab8u32c0DZLH8xsrlMpPxiip56Gi1/IJPPj2Gsjj4wtYez595y0wW
doLelWHCdiNk/x7lS0usdyoqkN2p5IUlffWafnd77EQWTs3FVpyN31Edy21a9oQX
BHTbFprBwlU2ndS8XKEHcgo1yc2V5B5pd6ij8/OheruYqTpf+l5BrYEJF24Q2R3T
HpfPRifkumZLALby8UDOkC/ZmCvWa86RhL7etPsspXCh7GvB1+n0SbnuhefrsSP7
/jToN5giZYrwqUtrZRrkDBXN3ppXQJ9F9aMksgVc+hACyoanNoj74q+CQx9HECqX
i/pplpA5MlzmYNoVzQJuccYRJvF2+s9DaWx5IZe97+qI+DSGp9mmAj+gVEimWbRp
6vd1gPqx6gw3JNhdR5CIv6AeoPHmZLW8Ys+ranxjaP3x4fgA3zUCK2EQwwzBwB7T
Xg7/2Kmjc0FYppIpQAXJ
=x5+z
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--

--===============2694331388512201643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2694331388512201643==--
