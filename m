From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-abe-twl6040: Remove support for
 pdata (legacy boot)
Date: Fri, 12 Jul 2013 15:26:02 +0100
Message-ID: <20130712142602.GH24508@sirena.org.uk>
References: <1373628835-11439-1-git-send-email-peter.ujfalusi@ti.com>
 <20130712115157.GF24508@sirena.org.uk> <51DFF1AC.4040103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9066783644147394871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CA9265A48
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 16:26:06 +0200 (CEST)
In-Reply-To: <51DFF1AC.4040103@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9066783644147394871==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/6pUCPTUcpTjDznW"
Content-Disposition: inline


--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 02:08:12PM +0200, Peter Ujfalusi wrote:
> On 07/12/2013 01:51 PM, Mark Brown wrote:
> > On Fri, Jul 12, 2013 at 01:33:55PM +0200, Peter Ujfalusi wrote:

> >> +/* TODO: This file can be removed in 3.12 since it is no longer needed */
> >> +

> > It's a bit late to do this for v3.11 so may as well just jump straight
> > to the removal?  Having the extra code isn't going to actively break
> > anything so it's just a cleanup.

> I know it is late for 3.11, but if I remove it with this commit your for-next
> will not compile if OMAP4 is selected since the board files are still there.
> I prefer to send a separate patch later on to remove the header file after
> your for-next picks up 3.11-rc1

OK, I'm going to rebase all the non-fix branches onto -rc1 anyway once
that's out so probably as well to just wait until then and then go
straight to the removal?

--/6pUCPTUcpTjDznW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR4BH3AAoJELSic+t+oim9TdYQAIdGqAalS/k4J9stkVuQaUjF
uNCBTjv3bi0Fbu6Xa/6d4MEc5Ey6Uj4XuMKwoMDWYxn4gZRlwLdCtfXYGMNco7Ck
NXKkEry3rfif0PpfiddPeoS+cW8P7mFIQC0denqXJEe+XGdKhWPNzUmEyLYutsZ2
d5CH/T5dO5Yry5dZKJuYrkPhdetdiSnEha1r3DXr4bYd48/6MaMewjkw8UYtG8Tn
42U8xh8g4Dk7inCTKlCnBBXw2+rJRqOCUktboOOgRJXVOv6pSIlJY2HFgmKlJyN4
Ia5lrdR12VquSCmSLc9MCm02oe8+D9SGdlkkaKR2a8uirTT4/S2bvRKB7EaHsLYY
3A/6X5Kj2XYZjmZY7Yf+MQpoAjXzxlgsbsbenSKZBt+KGRHmnxeQMdpcswDgjJWq
z3x7sPUliLAv981ze9hr1WfU7CQdtm+kzhvut9hrYBwXM2OIiTjgaCQkuuXWjdDy
rxDOEvRu7RmKFCZen8mD1xZPW35zKKkGso7TQRap47rZA7Il41UQZrgX2mddwl3o
Z4sKhUvnIAtWDyfVdse13uhGesyYw70qMj1GSKt/Ut7NK0yXTgf2YRyuW3kNmiFA
/r8Ta6ClIRTdaCYuOQ33ErynePrStsUqNyh6KwRqw3qEofUoTescXHn6o+tP0k2t
Wk8vLL+sR34rsQTShQSk
=r8T0
-----END PGP SIGNATURE-----

--/6pUCPTUcpTjDznW--

--===============9066783644147394871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9066783644147394871==--
