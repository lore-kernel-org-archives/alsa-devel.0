From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pxa2xx: fix ac97 cold reset for
	pxa27x
Date: Mon, 7 Jan 2013 11:05:56 +0000
Message-ID: <20130107110556.GA4544@opensource.wolfsonmicro.com>
References: <1356707815-3235-1-git-send-email-mikedunn@newsguy.com>
 <50E863AB.2000706@newsguy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6939591930994878753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 229DD2650E3
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 12:05:59 +0100 (CET)
In-Reply-To: <50E863AB.2000706@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: alsa-devel@alsa-project.org


--===============6939591930994878753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 05, 2013 at 09:32:27AM -0800, Mike Dunn wrote:
> Please don't apply this patch.  It works, but there is a better way to
> accomplish the same goal by fixing another problem and also keeping things
> consistent among the pxa siblings.  Patches to follow.

Don't top post...  if I've applied the patch then send an incremental
fix please.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6qvyAAoJELSic+t+oim9sqQP/jS0EOGA0BvHnntueO9rSsqh
ftE16wci9dS3IlX3P5inAmpR6QvrDH0f8+j+CC8OQ1Uh5oI0OwoHqWdaHsaVG7pe
Uk0D+31O+mnx8YijI54VF1qUHPTZ+UZ4jkO3l/AQj80Goax1lvtxwcU8k/vP/ch5
r2oGT2aeFfJFQ/XvwJgeDHMLB1zyDBJdM340qP6XKxJabUoNuOFJLU4OOhJnh/1B
+5OOrzfR3QI3Nq7lsoE+UjSllRXkK+ZEaw01Axwht3zAplsGOIFUMdDaOyHswZMV
1ibSJp+7xbw8qYZk9S3Wyuq4422a6RIKr4BDjs82/NqPrNJzfvoZVmb/5Coz+Sny
jXSTJxKta/2sYLNldV4jQsAHajXBIxjzqoa5hKOWBMLzzpxZ685Wm6x4GypjCZyj
AM9E4k4t+yGya1lEdOxW/J+r8LykQrrF0wmpyr4h/8haHTA0DmsEPtH9sKTXO1q6
uAapZ4NHU9VQokImb/Cd1MdIsyzYrPurZz8NewQpRcYzexE8MTBx19WtC4WrhfAN
fXwJI/ss/JFhgVf4YquEmY0WCJTO7T7dPuItyja6R/auRH3gWTRmXI/QzeAgHJLZ
4exvF43YEKfY+NS3BYvoylnYVhh+ydbrMnsqUd4Ls9KwpbEw7ILzybyOmmp7+l2N
GNZm5fZVC6nIaBmfKWqn
=Y38i
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============6939591930994878753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6939591930994878753==--
