From: Mark Brown <broonie@kernel.org>
Subject: Re: About ASoC DAIs cleanup
Date: Thu, 14 Dec 2017 11:37:18 +0000
Message-ID: <20171214113718.GB9788@sirena.org.uk>
References: <20171208084103.GC18649@localhost>
 <87fu8lio74.wl%kuninori.morimoto.gx@renesas.com>
 <20171208105545.GE18649@localhost>
 <87shciup8e.wl%kuninori.morimoto.gx@renesas.com>
 <87r2s2uo55.wl%kuninori.morimoto.gx@renesas.com>
 <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171213155952.GL6416@sirena.org.uk>
 <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171214050648.GU18649@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5216895221863558099=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D22266B67
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 12:37:37 +0100 (CET)
In-Reply-To: <20171214050648.GU18649@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5216895221863558099==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 10:36:48AM +0530, Vinod Koul wrote:
> On Thu, Dec 14, 2017 at 03:07:30AM +0000, Kuninori Morimoto wrote:

> > > Cleaning things up so we don't need to use rtd->cpu_dai and rtd->codec_dai
> > > would definitely be nice, it's also useful for CODEC<->CODEC links.  Off
> > > the top of my head wrapping the accesses with macros/functions then
> > > implementing a way of getting the DAI behind them would be tractable?

> Yes but one of the problems I see that we have specific ordering on the
> DAI ops between various components, is that a specific requirement?

It's designed to minimize pops, it's not a hard requirement but changing
it might break things for existing systems.

> > 	3rd step: think about No-Categorized DAI (if possible)
> > Because many drivers are directly using rtd->cpu_dai, rtd->codec_dai

> We should fix that part while at it. I guess drivers needs own dai,
> possibly for name or some data, so if they have helpers for that, we
> should be able to remove those..

The drivers need some way to get their driver data back and to know
which DAI to address on multi device hardware.  Most of the callbacks
get the DAI passed in directly, that's the simplest thing.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloyYm4ACgkQJNaLcl1U
h9DP6Af9FlivxU6FqI99dRkuRjJO/OCjIZoK+abHGqH+2DCy+tthxuxtCowRVmnD
Ud0XlWCSo7Vf+7zUCphTq3bMfC91rZXKsbC7EMYNVKtCQZ21/a7T+al88X8cSxCN
TpoAgns8RGdMJURkBO7cjAU+y4meF0W23TqjOZfV8hC5qMlp/WwfD/F1xqn9Of4h
Ye4dYKPKB1y2KxkV+LOoP+Ti+KN9hVE3w2/Fb2DeMQ8JUqbXDITODSA+RVf5szn9
v+UPFKR0n3bvOr46rOlXqC1SE8dCa8LjTUa3WfH3KwGrMQX+tRPJfbIuN70pp6Dc
kGlN6BSwsd6+VdGHRNr3wqQs3ZZ9iw==
=MjcC
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

--===============5216895221863558099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5216895221863558099==--
