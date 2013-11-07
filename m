From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Thu, 7 Nov 2013 10:47:25 +0000
Message-ID: <20131107104725.GS2493@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-14-git-send-email-tiwai@suse.de>
 <20131106184422.GI30879@opensource.wolfsonmicro.com>
 <s5hk3gle0tt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4742651819160944111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D3DB626550E
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 11:47:31 +0100 (CET)
In-Reply-To: <s5hk3gle0tt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4742651819160944111==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="99FKeZQ5IARcBmLz"
Content-Disposition: inline


--99FKeZQ5IARcBmLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 09:23:42PM +0100, Takashi Iwai wrote:

> Secondly, more importantly, it's end-users who would suffer from the
> sudden death problem, not the developers.  This is the production
> level, so you can't justify the sudden death.  And, with panic() by
> BUG*(), developers would receive only news that machines are killed
> without dying messages.

With the sort of systems these things are sold into users don't have any
direct access to anything that'd let them trigger problems - the devices
are sold as full stack integrated systems and the system integrators
don't generally differentiate between what error handling would do and
direct failures that much.  It is better to handle things gracefully but
we need to be realistic about the benefits.

--99FKeZQ5IARcBmLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe2+1AAoJELSic+t+oim9k78P/i4kDSHFALO7618Eed15VHH3
YT9Net4HVrR7SkntIukMXmq4lsopw5bJt87ID4KRDdys956QOwQPlnKZv3ATBa2D
sVjxvJxJEbtKcSrAh8QubxNZAlrD6bsspuu/iNSl6I7xCEBVDwKKpFviR8ZfdsIp
T55z7J8h8EfWZjiWT9fGfeoibIQO1ohxffk5ZuZUbZCSusCF4nUOpug6gWVPYKX6
kiNITBj1HeLe3XY0PnrP+6wG9HM+igeP3JNgH+R6U0yAzC498FsbUfAb7+1uGq4n
6qC2TcWPq8YftxwJqmevsnqRdPPsH+QrVCkG6PswzAySVZvl1I1+Q54+/JxLxZ/Z
vLmV/ozOHl5vRYQg/e+q1Ze4isVgP/w/G0DmtNZ36iLUOR1I6C74JL5a7du7kBAq
SA+26tBrNI2V5jwXlyDDdNwRUxtShbkOWoads5+L3aRxuude6TGrb+cxIq4iUV00
maNxQD2nEusR3fc0tqhBl6/LC3zxbHlGWc6pjvqEG96JBNQNjOeTFc6+GFnqMa9e
U2tqIklh3+FQANYMKHDzzgGkU01QvalJHDdZKr7SpRlVKwXbgawmPUrIsSAgHR/h
g3vexe8oCT338NcI0JgMrL76YwOf0gwCHIOo9M+uVg6V9+H607GKWV5fLTW/WpZH
TtrEG+Ry3OP3o+FlONwJ
=eGwK
-----END PGP SIGNATURE-----

--99FKeZQ5IARcBmLz--

--===============4742651819160944111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4742651819160944111==--
