From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Fri, 1 Jun 2012 13:52:49 +0100
Message-ID: <20120601125249.GN24139@opensource.wolfsonmicro.com>
References: <1338443313-28276-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4320753044130620408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1338443313-28276-1-git-send-email-zhouqiao@marvell.com>
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


--===============4320753044130620408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mI5TpPl/qDRoXxBg"
Content-Disposition: inline


--mI5TpPl/qDRoXxBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2012 at 01:48:33PM +0800, Qiao Zhou wrote:
> pxa-ssp.c uses API like cpu_is_pxa3xx(), cpu_is_pxa2xx(), which is
> defined under arch-pxa architecture, and drivers under mach-mmp
> can't find it. so just use ssp->type to replace that API.

Still not applying against

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.5

for some reason - what did you generate the patch against?

> Change-Id: I0a0671802189f61ff90d984ca577a41627f869fa

Shouldn't have this in mainline submissions...

--mI5TpPl/qDRoXxBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyLrYAAoJEBus8iNuMP3dcgIP/2t5BGXxSKMq/bih77zngoXI
dyXbPZV1oWUXqUoDtBvYejBbaW7beVJA+jOW37md2QGtybhd4us+f+nwClRY5QPg
3XSF0g+PYf8b6nun+WDLoe8CyVK8d4F3H+5qw3Mgq7BRWh/5TCsXYF9BXl9zFjYH
gMx9ilGNLd31tPihloeQ0ZQXKfvNkHiOfzebqtr8Osmk2gwErLmRT97aAU96XIBd
EvjZjyp1MsZBMjP7N+KhflMBWOAQkrlu8swpuv9xmrLk50s1G5nykQBdvz0ZtoSg
wAUX3l1maXw8tChvUI0I/Afe339WB0xfh4AFvFH8ftbuiEhHTYX+UIfwvqYVEj/t
82gtu8Rwb47uiQzZ0VbD2aqnOKQEaCYon7MUB5y9keMBjt2W5LkToj2yl1ajGH78
prEoIDlpJDRqmlc4IMJV3MrtUZMewqaNALle4g8d56GRPvszK3hJsDxXiWPFNOIj
3nI1r1C4Qvbh6qGH7Cq0DyN7UhwTtkSUaZ4vYrKpW47UiwYsjkI+Qj1qoksC2/VR
AEVfNCJMmODGxmr4k/Q2pXyZhm1yRGhjgbYU2KBwHSRqj+dEkaOt3nWx5EYoQ+mG
9Uvgtn+ggubOLRAZ5TO3EQM0PB09S21SbeO8ATo4guAhH/iUhf6jaMP7mD/rSvu/
kz0Fjapx1CLIimrIX5x3
=fO6R
-----END PGP SIGNATURE-----

--mI5TpPl/qDRoXxBg--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4320753044130620408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4320753044130620408==--
