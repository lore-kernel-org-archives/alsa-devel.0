From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/4] ASoC: rsnd: use regmap instead of
 original register mapping method
Date: Tue, 17 Sep 2013 14:35:25 +0100
Message-ID: <20130917133525.GG21013@sirena.org.uk>
References: <87sixrre8r.wl%kuninori.morimoto.gx@renesas.com>
 <87mwnvsy7a.wl%kuninori.morimoto.gx@renesas.com>
 <87hae3sxt2.wl%kuninori.morimoto.gx@renesas.com>
 <20130917130402.GE21013@sirena.org.uk>
 <uioxzfuoi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7177950022335662331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 789292619F6
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 15:35:34 +0200 (CEST)
In-Reply-To: <uioxzfuoi.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7177950022335662331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9iFHQ9JnogSZzyzY"
Content-Disposition: inline


--9iFHQ9JnogSZzyzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 10:23:58PM +0900, Kuninori Morimoto wrote:

> For example, SSI device have many ports (0-8),
> but ADG is only 1 device.
> On this driver, all devices are using rsnd_write/read() to
> access register.

OK, this sounds like the module should have this information - ie check
something in the module structure rather than asking regmap.

--9iFHQ9JnogSZzyzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOFqaAAoJELSic+t+oim9SSoP/2FKpkAZMSHmsR+0+OEmKnkj
pfVNvfTU3gZDiGYTDSLiLWrbtvldt+sz+8pq3jyI1J87BrfoxjqZO70EKMrWQMGu
tnPuv+yKT/UrWheKwinyMcy7zCRa9U1DbAa5hgqbfnoyZpbIBluPy0z+8vy207kY
7ZJWdny5hQx4NpQ1CMeaZhVwlW5dSANNdAjhT1w25uNpP19Ylb65POM/z1Lve/Ux
iK28N3AUTvGdMDbvU+RW+HcG6PiPY8/a/cuc7w97JvlvC5SH1muijyfSl/jOOIlB
Zp0tb6F25sC3rfn3cK4tijR/eBxK/9Ca1x4yyXXtopON8KwWkMpDTVb1lzYY3n5X
318E6sbhuimt03P7EoEaf0JZManp3u/ImErPAk3VO4b6h9N9MCRoT6XXG5omE9Mb
k1Tc0Z+z+Yo+s4rlpBhkf+K50/QFMYirYs+dA6xCHa1CBKjEIWCyMqvBVACGPmcD
ny/4vmycjLRBBmlOQvoUG8EJwaBLbM5vgZe9rKnAv4XneYbjt2ZV/w5AeKrzUMvV
+HceneLpHYFHLtMCPkwb2qnwX4ly2gugsNAjgRO8tZ5h2U4q8IH/SkTdcqNghmDm
lw8jKARS9As/OSAZ7QHd6eVn64HJT2S6u3KYbK3p1fVGmOJqgUIxvqvvA/o+fPn9
T1VbfVaQSZL/3CgRVBER
=ReRR
-----END PGP SIGNATURE-----

--9iFHQ9JnogSZzyzY--

--===============7177950022335662331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7177950022335662331==--
