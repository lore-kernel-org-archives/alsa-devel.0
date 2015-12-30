From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: fix usrcnt decrementing bug
Date: Wed, 30 Dec 2015 17:12:57 +0000
Message-ID: <20151230171257.GY16023@sirena.org.uk>
References: <87k2o4fkad.wl%kuninori.morimoto.gx@renesas.com>
 <1450940559-16516-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3437957471418864009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE61C2659D7
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 18:15:16 +0100 (CET)
In-Reply-To: <1450940559-16516-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Takashi Iwai <tiwai@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============3437957471418864009==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="apSYfA7d5AHMku3c"
Content-Disposition: inline


--apSYfA7d5AHMku3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 24, 2015 at 08:02:39AM +0100, Andrzej Hajda wrote:
> Field usrcnt is unsigned so it cannot be lesser than zero.
> The patch fixes the check, moves it to the beginning of the function
> and changes return value to -EIO in case of usercnt error.

Please don't send new patches in reply to old ones, it makes it hard to
figure out what the current version of things is.

--apSYfA7d5AHMku3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhBCYAAoJECTWi3JdVIfQK7UH/AiSbqcIx3Kp6NyJromhsW5n
zguexpID1anHx9GJUKPnlah9n7P7jCJIjobC3gjbH3ys6lnjrYqBjeJYG642x3Jw
5eaKKt9bkDydOQVT4jQx3b2HkwuWk4UnnccOGtLkYc/QuGpqTIvgJ6CGxXHgjxkA
BArxVmJhhY3yKx4nHrTJtYu16ANYtDwpW9VJHbffusjDNuF5ls2myVBqDKqHA+VR
2tygKTSy8B2BAkX8/9OpVPpLI0UzA8ToBq4jj7azfOrsrMq7QxfhpSfJcgjfoxki
3ayragdlkPqVvL/adNd+hGzbafVNW6v6UhqX54JRLZ/cCGRqjAcUP7n1btJLEw0=
=dXMH
-----END PGP SIGNATURE-----

--apSYfA7d5AHMku3c--

--===============3437957471418864009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3437957471418864009==--
