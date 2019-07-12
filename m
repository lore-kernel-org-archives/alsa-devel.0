From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: audio-graph-card: add missing const
 at graph_get_dai_id()" to the asoc tree
Date: Fri, 12 Jul 2019 11:51:43 +0100
Message-ID: <20190712105143.GK14859@sirena.co.uk>
References: <87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com>
 <20190711115807.34F58D02DA8@fitzroy.sirena.org.uk>
 <87ftnb66na.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8306428139368744638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 832E9F800D8
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2019 12:51:45 +0200 (CEST)
In-Reply-To: <87ftnb66na.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8306428139368744638==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2019 at 04:45:10PM +0900, Kuninori Morimoto wrote:
> > Fixes: c152f8491a8d9 ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Acked-by: Wen Yang <wen.yang99@zte.com.cn>
> > Link: https://lore.kernel.org/r/87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com
> > Signed-off-by: Mark Brown <broonie@kernel.org>

> I noticed that latest commit has "Link" line,
> but, it will be "404 Not Found" for me.
> Is this bug ?

It's because alsa-devel isn't archived by lore and you didn't CC
to any list that is.  I guess we should look at getting the list
archived on lore.

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0oZj4ACgkQJNaLcl1U
h9B1GwgAgWjrvCyKy91QXTm+WiJbfwG4EoOoAxlXs05YRlF7zYkKP8Wuj5/a4Ok6
ujpIq9Xe76bWgDltQeR/IJ94M+xcsB/tcD2ytB3PNZl6uSZS4zcZiZgXnlwzmWVX
zUFbkd6RHKqlZDUsieRbeM4Ctu5gtvOO5nuZmyoluqNMVysnBva869YKMihcY6QX
3LDQw7HEb0Q9VvGgJM4CAXfPgNboRIYxwjA6OuVPjHnO285txqf23ubSn82ryecb
UVUUPVTtizFBpNUvlQaH0bk0zjJdArzmR8tv8TuGgT9uPin/ZtAcpOoKGC2ZE2aq
s2yDq1gmMwno1LG/4NqBkQUnRI1Uxw==
=MZuw
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--

--===============8306428139368744638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8306428139368744638==--
