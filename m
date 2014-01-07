From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/11] ASoC: mxs: Don't set unused
 struct snd_pcm_hardware fields
Date: Tue, 7 Jan 2014 11:42:09 +0000
Message-ID: <20140107114209.GD31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1720567598231747896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC9E264F2C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:42:15 +0100 (CET)
In-Reply-To: <1389014356-7014-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1720567598231747896==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nJtR7aCSuff7dCfE"
Content-Disposition: inline


--nJtR7aCSuff7dCfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:12PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--nJtR7aCSuff7dCfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+gOAAoJELSic+t+oim9fpYP/i1yZKhHXJcryNoNUBhK9u0h
37i6KTW3gImjMv0xpJWrTiaJoqz7rBOCFZChw8t+p0YBzgSq+mC/Abnrhtm72GRJ
xzRmJGYutyJYbqKnJocbUuIOk4ONm/S+5TXLwuAzNp/rz/39+0LwPJYrinwmBxI7
3Ax64BziS5qPCEzuLzELsOaGBPfZrCdCyA6J6N0Rhz8GXGG6qtl5AOm5m3uqMXMN
3o7GIc0UAd9rs15BM9CkBfGIxeNApA7ZVQ3kEKBOwvaF8JMHP5vHl3c0LnTO5NYg
IOVtiAhulidlLyYLinuCqzrFLKBxHp6bBR1gLBndPerznO1sqU5cLrMZOOKl9T9X
CKwIv7KEl05jKCCQf+I9nq5k7FWb0k4nRkblLENZ0cKyjNlTebKOiMvcO3HYP2ZN
ZMIvx2c6RgHlgkbGB+WSL43PKZPNHW/jINKgZACOsptGmbc3bp1nxkApOgZQYMDS
nusL8ee2MKnU/hYBs5mhw5k34+gIREPfQ7sZ2c38YntcR7LKOzUNdZK9HeiZ1ou4
T64UBThxClXT8AyswRcBwcKYTdfeX8iZPpOta+xwdKvfULdslDQ7B1QSOAZrsdtO
AGuwU7sZKKvamzXHTleJcTGCORmCjV2DJ9sO+nvkWHiB5Dpk0ErlJ1iX9LFi9SQt
m4stnyE9Xg54b/z72WuE
=k8id
-----END PGP SIGNATURE-----

--nJtR7aCSuff7dCfE--

--===============1720567598231747896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1720567598231747896==--
