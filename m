From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: txx9aclc_ac97: Fix kernel crash on
	probe
Date: Sun, 16 Feb 2014 08:36:17 +0800
Message-ID: <20140216003617.GO4451@sirena.org.uk>
References: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432496407348001649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A69261718
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 01:36:26 +0100 (CET)
In-Reply-To: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0432496407348001649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lz5aeKxNMHO5Q25g"
Content-Disposition: inline


--lz5aeKxNMHO5Q25g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 15, 2014 at 11:28:29PM +0400, Alexander Shiyan wrote:
> This patch fixes a crash caused by commit af5b2d7519
> (ASoC: txx9aclc_ac97: Convert to devm_ioremap_resource()).
> This is an attempt to assign "drvdata->base" while memory
> for "drvdata" is not already allocated.

Applied, thanks.

--lz5aeKxNMHO5Q25g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAAf3AAoJELSic+t+oim95zoP/jzmYPGt9RsZKGGKv9wgtFFF
v66PAgsNjns0sUcFPhmhxZa0t4I2acZmCT+DqPVHDIOMb3apg3j+DgysQlpFdS30
yR1EFGbiNQoT/uwA4gfhgtF0XeYKIL9YMrPkYqI2JfzN4vX8ndby3fum3jpwT/22
OJSz2HgcJwM8pvIs0ZAVXX+3E74+EOzmzx0DOVoxJqWGpGxZNRGrs6HqEw7Lss+d
vppCuIzgF9bH4apWwanlMhpWMNhfphSUEe76mNYGbLGoFDlfDBxqGEkLuSn7gSJ0
93ZAHop2GlJPSJ8C/voIVP4WyacdBCQgiMrprUTynK1fIVFLckFoFwTIvaBuPFYR
IbiN7Xyukyubo1UyKixzdH+tN849OJqYl7daI9lXmoQxGAZxkISk7oF5mNa9p0hZ
m4F4dJv9iBtnm7i+doIdMqcfhPdCZ6vk7gD1jejxPkS3ZLJ1aWz8j/Zm3+lKYvgT
y1D6bkYZzy86m5JHmBFRUWCBFKqxLrW3rqVfKgDToMa0uwPRzem5N5u0HjagYSmy
4yX9qIvZBDia7Wmu2m7gzKr6U5E0V54wFAFwRaCVVkHXoccAnJ1lwXwnP9hTFD6G
QM91zRUida4MeJfR0fTw+w1S0+R0l6yrko9T8ySTM5t92whq1GyovzfPwDdXB4/e
iZrqX8PJbZY5cmKdeW7v
=s8uP
-----END PGP SIGNATURE-----

--lz5aeKxNMHO5Q25g--

--===============0432496407348001649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0432496407348001649==--
