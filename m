From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dapm: use clk_prepare_enable and
 clk_disable_unprepare
Date: Tue, 30 Apr 2013 19:31:43 +0100
Message-ID: <20130430183143.GD26160@sirena.org.uk>
References: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
 <1367330994-7259-2-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2783942770315105367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D73962650A4
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 20:31:45 +0200 (CEST)
In-Reply-To: <1367330994-7259-2-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2783942770315105367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2013 at 04:09:52PM +0200, Fabio Baltieri wrote:
> Update dapm_clock_event to use clk_prepare_enable and
> clk_disable_unprepare.

Applied, thanks.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgA4MAAoJELSic+t+oim93QEP/1IfIwBI0We9zslG2fywezxl
Iv+4ZAGFvcWflNjSg/stsbcTjXrofApmb/u4E1MVEnFYliHKlx/5xAwJfxbMTinW
/EAl8yWNDKijhh5LWK5QiTZSg5MX987VbWCdyRWzt+boXqJ4QCCfb6HiicKmqt0r
3r7ptwx/KoHeF/7ZI2ZuvAdEgMzo6n7e+fil6rTDhRI4kYN0W4v3DZsOwLLsvcS3
V+bAvW5Sk7WMEULflnQUDq8d3u5WBZDNAmicFkPErf+YryS1aBsvDukLJQ74JTFY
3/jV79IAmhvCqYTW6NQeEmpCmScAGDosIj2sX03Fdses6HGrE7x7qdCbVeE6h8H/
rP7htwK/uTsiLEbDo+HNuICLn01Y+jKzDpyw5uX/DYPNvUuMfwkyqFq148XGbLmv
lT67sIXYwkJ5tI4Uy33AYgjPFBOgN+bIg2YgReWH/J1huptREOKe2AyXoWMj/twK
Nk6TETk1Uh2v32Trpj4yOVQ4hhXrHpCIymujBjaZE7WqfrzMpjkbyfQJP+q/tunj
kswy/xp2xZwUn1950jg9rl69YoJqjHgyJHQRaPCv8hDVzc6WcBYpTvDSM1oP+hSJ
OORbwjVRmJSKrPRcblz+dn2mXniMjpZ8dmgxvWuCFXWzopbCsShnIuBIY034bfWF
38AJtTjT8cMjOPFK+qnd
=wnn8
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============2783942770315105367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2783942770315105367==--
