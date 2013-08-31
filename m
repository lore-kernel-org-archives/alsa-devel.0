From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix cache sync
Date: Sat, 31 Aug 2013 18:18:20 +0100
Message-ID: <20130831171820.GK18608@sirena.org.uk>
References: <1377965723-2812-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6207309407285740442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E13D261AEB
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 19:18:23 +0200 (CEST)
In-Reply-To: <1377965723-2812-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6207309407285740442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 06:15:23PM +0200, Lars-Peter Clausen wrote:
> The ssm2602 uses regmap for caching not soc-cache, so we need to use
> regcache_sync() instead of snd_soc_cache_sync().

Applied, thanks.

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIiVZAAoJELSic+t+oim9KKYP/1EYVEaVQK3JrZT5earMFYLb
irPYfTW5TorOBnJqM5ADTHAC6ILyW0Fm5zkePqB/YMaOGkKuqtq5qa5IH04iZxSE
5f7Cr/BRcvSx42gJhmaBHLGiiZc4xny+50ZON2ZGzG9hFzlmvt9aHgjCGxAyhkau
N14LcGhy2+HA908mN7IHrtbA3hV+rH7bLDIRUZ+TPbLfyjUJs0JaiMVkm9K4L59k
c3aKYWWHhkYs+zq6dFsqfKx02L/MMPDa5e3ROBDDP6H6nCJiGOK8OVKcfA9RavzV
4VtHeFK+gp5PRUDjzdQ84H4d3VDK6Y+RPLbGGNYHXNWCS3yzJZkqCNgKmkdu0dCe
uZWFdq2jekiWlVkKYKOKft675mB73jFf2CMnEgiUmIYxk8IN6eOk4p9nqGghJVZP
FTaSmsWkv5UpNmOnl9kY2B/IFpQixgwz7ig+M9APQFj/k0xNKKxE85t1ON8kkmhh
Sd6fGManOnev8zh4QvG5zQ0LhKwr6Qi/2ihwVZzASYlfV97Pw8/GmTPTqL3smj9R
8xl2gtI3dH2SiNd+MvhCb9Goyq7GxueHFoZxSR/TeIttYr7j4D2N6sJKs/Tsji2m
r4geRusAqcSdBqiAjTan+Yt3DNx6kGksanaRJJKdT64kPpCX/C2eNq77h5xtJX7+
Ss+pFojjYUJvuMROIWqr
=jEx8
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--

--===============6207309407285740442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6207309407285740442==--
