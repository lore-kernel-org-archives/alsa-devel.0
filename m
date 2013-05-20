From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: request IRQF_ONESHOT
	interrupt
Date: Mon, 20 May 2013 08:01:13 -0500
Message-ID: <20130520130113.GU1627@sirena.org.uk>
References: <1369029487-32702-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3692481278697530732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F39742610D2
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 15:01:22 +0200 (CEST)
In-Reply-To: <1369029487-32702-1-git-send-email-abrestic@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>, Ralph Birt <ralph.birt@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============3692481278697530732==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3T2jnoiI0lx9XXvh"
Content-Disposition: inline


--3T2jnoiI0lx9XXvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 19, 2013 at 10:58:07PM -0700, Andrew Bresticker wrote:
> request_threaded_irq() rejects calls which both do not specify a handler
> (indicating that the primary IRQ handler should be used) and do not set
> IRQF_ONESHOT because the combination is unsafe with level-triggered
> interrupts.  It is safe in this case, though, since max98090 IRQs are

Applied, thanks.  If request_threaded_irq() is rejecting these that's
not ideal - some threaded interrupts can only be generated from within
threaded context and therefore can't have primary handlers.  Unless it
only rejects in the case where the parent IRQ is a hard IRQ of course.

--3T2jnoiI0lx9XXvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRmh6QAAoJELSic+t+oim9ByQP/AqYwU0DYgY5mFbW67cShBZm
UDtV5Pas3aSAnKoeSxaEy2RenCDOBgXlJ70E9MW2eo+CmdIaiI+l9KPbTpqpjjoD
NqArcv7HYFdiYUbTNaPQt+shTV83EG4OnhsGXobZLKTkH0fk3jZLLbJKLs/RgJa3
ENJ2r45vGg6bnPYqz0/K/O/gKyuebqzHshh1svuF/JMwqbFjC8Zy9XjnDZWU8293
NIUFX0Lsc3R9qmWIf0XB27avFYgNl1egedxSTqYs3aoF96dH+FmBq0u28a3PELxl
1f0Pz46p4feeMl3QtyTj27KGjkMiZ1DPOcDShI+OXVzfFRe5ucJ6s5lK71+IYc+b
pt3AdqTzMU2Zv1z3QJVQFjSb/RmFke2GBrIG3h4CF1HK4Yb0GkndBkDRcoRdtHXh
13jCOsug9sR1I33GP7eHO0EkcQb1ms1FO4FeM7KTxDjMMY84gFLje1lDuv5KpPCi
s9O6tRz5Qh0gBdJrxD2QuYqoU6TxfZYp2t7aqAwxUHD/dRQOifjjn0JriMubZiFc
AjWjkgK9Z1WF9KbH/e58Kj0l2j4pUqvhjPyKVOOP7QUcL+pqL3HBbm0y0EAInSde
4nCAHkid2MhDKB/oez+m1cYJ1w0KmCj2+/G+juxSh36QX9QFj7ozYsNpsXsNXyPb
+KbADZQE/liOMrlYbbHI
=iKp3
-----END PGP SIGNATURE-----

--3T2jnoiI0lx9XXvh--

--===============3692481278697530732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3692481278697530732==--
