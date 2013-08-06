From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5110: Correct input OSR bits for
	wm5110
Date: Tue, 6 Aug 2013 17:41:49 +0100
Message-ID: <20130806164149.GD6427@sirena.org.uk>
References: <1375805035-22463-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5466781709765361614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0074C26087E
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 18:41:54 +0200 (CEST)
In-Reply-To: <1375805035-22463-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5466781709765361614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 05:03:55PM +0100, Charles Keepax wrote:
> The input OSR bits are specified differently for wm5110 than for current
> revs of wm5102. This patch corrects support for this on wm5110.

Applied, thanks.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSASdKAAoJELSic+t+oim9Vm4P/iDyVuZ+1Rdd6x7Vx4NTa5/q
tCNMH8RSU8fkjWwrnwmcaOFZDJ1k0tkaAg4DjnRLOF6IVOFotm1+68Yc+yFCL6Ff
dr/4M1GD04IYoSsNA0cDKB29E8qeIMHB0NClRbl9nYQLPBzGgysanpRoCpMpR/o0
YEvVi/OkdDZ+ZVtNe+Wt5tuQlvhbbzy3qPWq7yVgM9bxsjBcTQSfZVeEXMQ4Igrx
a9KlhkEIEmOGK7HPV5RyZpxV9Qyo0VLvT8I9lFqUc2rsvDaOWT83XFl1CsUKcstW
NAMPmd1M7ap0iHzDJNy9AODzgWxQ8FzsIxJT2J6vE6hvWOsfsRWAa6T6L9jIbOkK
YOjVxkNWbeD7QZpdivJjZHu0J4rR6PwmVAoeO7HPSDEjAbAzPHwhDB43xxCAG4TU
oODir64zOVdQOhvyeomjPLOBX1aexHPebaavUKG6xDZY/zPtwR/uid92LDNW1odV
59BT6lIZZE9bnXsb0lt9nUdL8OifytLTGUz6Kj6Mn4Txiu8oFbN1grAHFIlbML9U
RnHSlGbanGFYGK8HQu+YEhqsS7dgPjvJuY23Zj/YTXjwY6LBT9HO1QjFVqTvwFI4
Rd1pP4nw8wsGFWih/Wx3GduTTS/K3MJUXFy2qXKRe54fSl3vHF5u/WJ4qi3wlGPu
uDVb57i0Igwd5yaSbG4m
=OA1t
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--

--===============5466781709765361614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5466781709765361614==--
