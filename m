From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be
 freed in pause state
Date: Sat, 15 Dec 2012 23:49:53 +0900
Message-ID: <20121215144952.GD22033@opensource.wolfsonmicro.com>
References: <1355330980-25189-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3928509213423855051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAA072615AE
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 15:49:57 +0100 (CET)
In-Reply-To: <1355330980-25189-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3928509213423855051==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2012 at 08:49:40AM -0800, Patrick Lai wrote:
> When front-end PCM session is in paused state, back-end
> PCM session will be put in paused state as well if given
> front-end PCM session is the only client of given back-end.
> Then, application closes front-end PCM session, DPCM
> framework will not allow back-end enters HW_FREE state
> so back-end will never get shutdown completely.

This still doesn't apply against mainline, applying to v3.7 gives:

$ git am -3 --signoff /tmp/fnord
Applying: ASoC: pcm: allow backend hardware to be freed in pause state
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/soc-pcm.c:1240
error: sound/soc/soc-pcm.c: patch does not apply
Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Cannot fall back to three-way merge.
Patch failed at 0001 ASoC: pcm: allow backend hardware to be freed in pause state

I can't see what's wrong but that's making me worry about applying it
by hand as it seems likely that there's some aspect of it thatd' be
missed; the plain patch program also has similar issues.

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzI4IAAoJELSic+t+oim9RKkP/1hqLYID1xGVNTcy7w7f+pFL
faSJPYype0P7JGqZpoQsGD14rzjAcQ8RWUzW9/GKJCY4hEWXL6DKpJNRZYtjeB+D
tFV2Nc4Jr5ssVuPGpVz1Tk0shrbbNc/+k6aylfxGVM8Abav1Aj0/wBG73oHW5Dfv
SrbQ1YFkxVh/GUQQPopzKOGGgExufDVvYCZeUnGF5Wmc7ns2q7lhr/1LXFxJzee3
PbR5AZHeNZCBEAjypgO411oeNag/0szzXA2nV/jPl4tGEnZw3jLYLtbUjerAc0+J
d8QDa+LGsAa7O6PBNOaCan832uU5TcnUXy8bKRaBBWodrZY2JVYshc8jFzJAQQN6
EKOyJmy3QkgyXiZkcFnzdAvLEKffzc2Il3h8pBFlqEzr5p2X4L95UmUhJWB403yR
xDUInp9VDgmt6Qr/DzbhhA0BjsD9DEoO24hg18P/mgbZm17LtrPYXcrY0wrcpOsJ
y6Tk5ja9OapOXOeRHwnNNKoK+H6tjSrZskjXWh1WTgtPpr91T/McSS40QwbsWIkv
LS5pWj6isXQHgXQ4LljjmWLjHzpsiloSUm1IcjCcH7Von8gH+OjPH1OO1cpTa5BU
7KzGU+8Qy/+CQiwoREkmlWyu5yQd+n+0bBgbNkWqMKZDGvDVuo7o3zZxVr3AbOQM
inuIYCe9MzgxocdWzu92
=1IWR
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--

--===============3928509213423855051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3928509213423855051==--
