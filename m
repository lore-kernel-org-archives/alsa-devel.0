From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: max98090: Convert to
	devm_regmap_init_i2c()
Date: Wed, 20 Feb 2013 16:58:31 +0000
Message-ID: <20130220165831.GM2726@opensource.wolfsonmicro.com>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
 <1361187134-7525-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9116066966244043208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5866261742
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:58:32 +0100 (CET)
In-Reply-To: <1361187134-7525-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============9116066966244043208==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Content-Disposition: inline


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2013 at 05:02:11PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJQCvAAoJELSic+t+oim95qsP+gJV04g6WD0+4Z1yw0eDcivm
tqiDLZFfesCM48YR6Mi1GBNk62sfLv3JyRiogxsy2Pdm+eWNGv96e3a3f8fiPJqn
RCgtcWBLJrSPDs11e0yQ++mM0Tk27FLBKOJEamb9GHrgmcCivNhtwaHrEQvoqYGl
OQun25JR5dMD91pJf6IgISFx8aRw/5XuWAhGrvZYVBlOY1h/lj9H9CgDk4U+JTWR
RNyaUD3AQl5pIzNYX9ri0tLru+iX2p9UqYY4cvNbdDdy40CcmG+hzDjD+JrgTMsy
CJLOSyW29g6uwyFtAz8soiK6lAkO+3qBomq4M49AYpf2SyWXy7J6683f7DU6YaAO
0u6PHX/Ds4w8m8eUv0517G0JMJGFYPPDZfcEEPBYqCvOkR9tKMBhv/akc6RAAE5r
Kyd5CMVNq8Dbj7vshzcMf9MmgKflr+09NI/xPIy91x4r+fkU0E3RA+31pAfUIbpG
0lLwDczT+d/91qlh4RB+qF/sazLRCGR9mTqi04tCe52driGtxUErrBq6BtDrIdjy
uSzaWtkDem7B0XcUesKFdAPEAwaTjqhe2x0WX064I8VnPjS7IrFaeio0d9qfRI56
IXWDz546ia+M/Me+Iikuxe88MgmOtXLB/2iQcB2hmMcYWkY6EbclngbhXgwCaFFz
f08aqVGd/gDwLS4Sb9sW
=lzBX
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--

--===============9116066966244043208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9116066966244043208==--
