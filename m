From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 11 Jun 2012 13:22:28 +0800
Message-ID: <20120611052227.GO4218@opensource.wolfsonmicro.com>
References: <1339070421-15111-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5571790212546200600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A7B1040E5
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:22:41 +0200 (CEST)
In-Reply-To: <1339070421-15111-1-git-send-email-ola.o.lilja@stericsson.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5571790212546200600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
Content-Disposition: inline


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 07, 2012 at 02:00:21PM +0200, Ola Lilja wrote:
> Add codec-driver for ST-Ericsson AB8500 mixed-signal ASIC.

So, I applied this even though you left the API for doing platform data
in the machine driver in place since I see further patches which should
allow these to be unexported.  It'd have been better if you'd removed
them from this patch as requested, that way history would be a bit
cleaner and I'd not have to decide if the current stuff is OK.

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1YCKAAoJEBus8iNuMP3dUxQP/RYQtnKJoXu4/XuaJDaL1R3Z
QVv8jP3JothQgLXPUPYXYLV3K6DJhk+tRr4+DRV+IPvLVp/rrIF9V+Dz7JkdVCPZ
6YUzDG11V9Z5zWG4OQrkDS2nOihm0iAOmpU9g/d0M+LwjDLzWAgYJfpt8/okBxtY
DmephWuMBJJhDQTQE5IWWZ8DqmDBB0FQDzWDZCnGd6NPlCI4Jd2dLYWZ+BJUhGVk
fL+OUYsGyIvcZJHWBGZl4EdkvYEmOnf4B44jTL8VYGWN27RK0cLWj/G+KXnunh3G
afRx6L6SwdLeujDa0/SjvDoiQeUzUd2VT4gyv4qoPfxs81cELn5pc0cHPk3IiJIy
j39S/IWUTBVS4a+eimh+/eHjB1HmMBPlm4siolG+0yQFLGWOvMlJPn+f+AZwAmHN
Zkctv/lYUdj2H4Cmmi5bCNCxJPTMzJk98WN3IEIYG8j5+8O8ACwrpfY75K5Y8+g4
8k/pxXGlkHZvQUHrD65Esy5oNBD5How4PyPn2nN5Kd4gg5T8ukp8BZwTmiOFqnnJ
DImUR+qfbMDDSw7yobFBd7alcHPLYzgqvNShZ7U1tl+45MHZxKKg8Jxc1sWVJuBV
iWAHZpaqzcQil4vCijclYn5Lr6gcACpGb01j5f+bk+hHC2fbWmdH3M9m/PPq7doD
oWHxOHnr6vVUu1XIxD2f
=FRPq
-----END PGP SIGNATURE-----

--ZmZU9S7l/XJx5q9b--

--===============5571790212546200600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5571790212546200600==--
