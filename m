From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: add snd_soc_of_get_dai_name()
	default of_xlate
Date: Fri, 18 Oct 2013 00:43:49 +0100
Message-ID: <20131017234349.GA2443@sirena.org.uk>
References: <87li1vdx9y.wl%kuninori.morimoto.gx@renesas.com>
 <525E57C0.6000508@metafoo.de>
 <87ob6o1tgg.wl%kuninori.morimoto.gx@renesas.com>
 <87li1s1o8c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8995967311995693045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9511A261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:43:54 +0200 (CEST)
In-Reply-To: <87li1s1o8c.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8995967311995693045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QEmF4LapLAdOVlp0"
Content-Disposition: inline


--QEmF4LapLAdOVlp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 10:05:26PM -0700, Kuninori Morimoto wrote:
> Current snd_soc_of_get_dai_name() needs .of_xlate_dai_name()
> callback on each component drivers.
> But required behavior on almost all these drivers is
> just returns its indexed driver's name.

Applied, thanks.

--QEmF4LapLAdOVlp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHYyAAoJELSic+t+oim9wwMP+wTEHIhBpGzUxw/gEpsM7mRb
HqKRFseQ1iKwUXSbTdSQJPZL6suH1G+2XIEqAE/bMt3B9490T+BVH/82SzOFEMwq
r/FKJtNNwHNi2VVlm8su8VT5UJr34Tn+G/zCncg/yjVP+xpycGGWdxNVpQ+WWz4l
akWZaPxUJhLtdaRYwPRVQGyFnlPbtSDhotY57zFOc9Heb3ucZawaHGxFOM1OzAH6
b63PumxPfxlozNWgYtb3Vw5TZ7odgatxFHGrGl+K24nF3m8MCOIOyJ4taQzC2+Iz
tXwOLo92p2KQBk09jSwNmJ85RLao0RHeTcvOwfmeQ/p6yxRnqCizLZ/1s9gmZz9a
TBiM+GpBpzdxZcg/IzdS7dDmwnrjeKCnmtX/7txKkTwEGbceQmdHuvY9xUnDECYJ
BcWW39t0zFdbDdt0ZVtc6piaWAmNCzJ88GC0V/E4ve/eQtP2Pj8Dud9I7zhLpWQz
voa3E2lorirhTlq+hvvJBeI1mguZg9W1JAs40hIAf+1oFWu3dp6YrUF6V+/QwEtB
QuLN8K/skQ6GweJLh8i8+vDGlspi2kfk54ZinKtcIinnTC/L/PApbO1E8kULeWjg
6Ci89faBO4vU7pm42bd1P0uuH64xyPY+O95U/rypSgtroWi8/bcv+YjkAikRUENT
Z/BFOwDMtT26wIqcPdao
=YbCY
-----END PGP SIGNATURE-----

--QEmF4LapLAdOVlp0--

--===============8995967311995693045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8995967311995693045==--
