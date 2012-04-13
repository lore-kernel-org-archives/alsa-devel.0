From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5 v3] ASoC: add generic simple-card
	support
Date: Fri, 13 Apr 2012 11:35:30 +0100
Message-ID: <20120413103529.GQ3168@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87zkashytm.wl%kuninori.morimoto.gx@renesas.com>
	<87y5qchyqj.wl%kuninori.morimoto.gx@renesas.com>
	<20120406175848.GN19424@opensource.wolfsonmicro.com>
	<87sjgd7ozb.wl%kuninori.morimoto.gx@renesas.com>
	<87pqbh7dbt.wl%kuninori.morimoto.gx@renesas.com>
	<87obr17d3o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7790224395760328959=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93D73243DF
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 12:35:32 +0200 (CEST)
In-Reply-To: <87obr17d3o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7790224395760328959==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Content-Disposition: inline


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 08, 2012 at 09:17:50PM -0700, Kuninori Morimoto wrote:
> Current ASoC requires card.c file to each platforms in order to
> specifies its CPU and Codecs pair.
> But the differences between these were only value/strings of setting.
> In order to reduce duplicate driver, this patch adds generic/simple-card.

I've applied all these - thanks!  I tweaked the first patch slightly to
move the Makefile entry.

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPiAFqAAoJEBus8iNuMP3dwQQP/0wRPWNTYDjA9XplYNP6IL1x
VJfxym+XU901FaHhIqCVsoYToR7acWsiRnvIjGiYY5fcqYezVoDQmEjtNhq+6S6M
y004IDeUo5A/6DG2f7xw8X5GSc8D82xsH/jtNs+RtDKwcGoJ1DpcIAQg5ckf3BJ5
NDR1YDuxstIsKKag8mi2JkNSYZzR2nHjym65P8W4TE4snl0ub8fKuqA56FPJxieJ
OsvjBCMHTrFzuL2KvGl5h4gmgXypIA9hRqwsnRNWD5IIu5RaNP9nLF7dswGMEKf+
mzFIkSwpnD19aiW9RmM6PG7aX+Znx3X8FmERgz/sK79smhqpB6QJ6ycPOuHo2GGs
mR5xurcYHT9tHENn6IhOdIYe6zm2UGVIDP2mpQJvPtoogqBzaTvqjEHl+ZN9NQMW
b3ZN+iWUzp4u3Srxa57ufDFiTjN4fc0zycEcr6IBElDBElHP0hTb4miqDEuHahuu
dSB4NPa7OzYxBhd+zCJSHbYpWQHSyqTT52oIJK6hZuuBTwrr/FHV4U6C8sF5FA5k
m8lZbJ7M+6tf6BgJ/y5bB2M2+DWMXFyRfCBnQtWs2vhhfbch9JejjC18Hn+w4UAb
KYDbbyh9CiwQEjROPd4kCPkYy8pnqtSBxK8bIIWlokZhLIeRuknup2lpaH4UK6i/
/50Fvh8VX0Azc9/bsyNO
=C4dU
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--

--===============7790224395760328959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7790224395760328959==--
