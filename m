From: Mark Brown <broonie@kernel.org>
Subject: Re: About ASoC DAIs cleanup
Date: Wed, 13 Dec 2017 15:59:52 +0000
Message-ID: <20171213155952.GL6416@sirena.org.uk>
References: <20171208084103.GC18649@localhost>
 <87fu8lio74.wl%kuninori.morimoto.gx@renesas.com>
 <20171208105545.GE18649@localhost>
 <87shciup8e.wl%kuninori.morimoto.gx@renesas.com>
 <87r2s2uo55.wl%kuninori.morimoto.gx@renesas.com>
 <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8172488408565945762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C15AB266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 17:00:04 +0100 (CET)
In-Reply-To: <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8172488408565945762==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Content-Disposition: inline


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 07:19:39AM +0000, Kuninori Morimoto wrote:

> Because many drivers are directly using rtd->codec_dai / rtd->cpu_dai,
> and it is difficult to lookup CPU/Codec DAI from non categorize DAIs.
> Thus, we can't support non-categorized DAI at this point.

> Now Vinod want to use Multi CPU DAI.
> If we can support Multi CPU DAI / Multi Codec DAI,
> we can cleanup current DAI code more.
> But what do you think ?

Cleaning things up so we don't need to use rtd->cpu_dai and rtd->codec_dai
would definitely be nice, it's also useful for CODEC<->CODEC links.  Off
the top of my head wrapping the accesses with macros/functions then
implementing a way of getting the DAI behind them would be tractable?

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxTngACgkQJNaLcl1U
h9BATQf/ZO7NnQq73FrFwJW19xe1OL2iyS03hR3kbYk5KQX8iZobEU7cA9V3z3SW
5XcbBbh1rfAN1qihVUn+pRf+mHgFpnlKg4Vga3MruBd4UKfvWd9TYQHQYLTskW/w
IK+Aw9RSlTRiSHrmBa0Ni71/0tU+2fmaFd+T1OUauCzR1ZM5DEm91PVfMFahmlvu
9SZItM4kSdISwK14u6ijhu3xtjcyV8ML/+wvUBOD5RI8CzRrrwSKp7QDfBrXGv5c
jyKZyZRgEEUzWUSjY2YajY/7E3ltzGE/fs00mtxsRAcHb8zJo1GUe1uM5d6oNwmL
NlmQwHCZ3rfTlA6RSYh9gWthuvqvTg==
=bhCU
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--

--===============8172488408565945762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8172488408565945762==--
