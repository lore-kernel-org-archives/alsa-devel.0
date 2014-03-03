From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] ASoC: pxa: e750_wm9705: Convert to
 table based DAPM setup
Date: Mon, 3 Mar 2014 10:05:05 +0800
Message-ID: <20140303020505.GW2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3011569685207083710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1622654DD
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:35:37 +0100 (CET)
In-Reply-To: <1393685300-5307-3-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3011569685207083710==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
Content-Disposition: inline


--ulNsWUvGrZAj8PMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:15PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

Applied, thanks.

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+NNAAoJELSic+t+oim9fdYP/23VrwYCqO4stsu8YGT9cN+/
IdJVz2MV2porELbJKhbtjjXUoU+atsmLYoS0Nww1lm/gK2gqrQTIqM/1N6XtPpDv
gvYhE+QWp0KY6BihuvtjQsjv7TuHew1pIIuWJYgpXu+CnZNkd11XmOb7BrGNUTHp
F5Tk9RcCAUGk2ZBR2yddVO8OJwkdCQkCdTItUlsM30vJ3Pcpm6uDqL9OZWaNy3sM
bxEhuZ2jXjXK7x2fN07iBD4D5J9/TAMKPej6HVe2QunQ+1B8BiSOKs+h54AVy+1G
BTAaTxHFTSmawm0sJE+u5Df6l+ZpNHFuZKRNSue598SqspMpXWLULt8Y4GJc4fL/
lzI0iFbhNMQlOLsIHlSH2TwXKKKGldc0VRYpGledtkG++yZXhFOb9FmJ/s7QsV5m
Si+eQWOJ2V1MSwbo6AJZYWKg+E2+dP9CyE6lJnlFet2YcJ89KLc1dpFRHEiiZO33
A9G2irLZTVTInvpKoRHwcPsAhRy1z5NreavA2htW8+2g6NDhXnWUbXJ2g5XOG5oY
URNEK6ELwe27ngkHu+al3n9scIEvcn0X8xAA9i/j+irkn1N8yX9yWl/6x1kllORc
pD6SaHS+AO/6geBVsUhpIAjMjqyUz/BI33GiX2vOIqlBoupNksfv0mq8x6wHOn8a
BdMSGwxUBobCwRcGQFO0
=u/AS
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--

--===============3011569685207083710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3011569685207083710==--
