From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: pcm512x: enable set_sysclk
	callback
Date: Mon, 4 Jun 2018 11:40:29 +0100
Message-ID: <20180604104029.GA7536@sirena.org.uk>
References: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6316736390420687754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F1E26786E
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 12:40:34 +0200 (CEST)
In-Reply-To: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6316736390420687754==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 04:26:43PM -0500, Pierre-Louis Bossart wrote:
> For codec master mode, the current pcm512x code relies on the clock API.

> Simple boards such as Hifiberry DAC+ PRO rely on 2 local oscillators
> to generate 44.1 or 48kHz multiples, with the clock selection being
> handled by the machine driver toggling GPIOS.

> The RaspberryPi kernel exposes a "hifiberry,dacpro-clk" clock driver
> which does nothing but tell the codec driver what rate is set by the
> machine driver [1][2]

> This patch suggests an alternate fallback solution to let the codec
> driver know what the sysclk is based on the existing .set_sysclk
> callback.

I'm not seeing a great advantage in this - we want to have more adoption
of standard APIs for clocking rather than less.  As that Pi board shows
it's easy to create static clocks in the clock API so why not just do
that?

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVFx0ACgkQJNaLcl1U
h9AWqgf8DrfD/R7MyUBz6r4apSS6ev5vxP24HXi1aDSGk+CZvsSxtvQSADQblc5q
PLlQXeJ1dsexvGSWzz4ixCgd42c/XG3JiD/BU7K+ElNbjLsz9MARwOzR48UaHBgh
jcdi7ul7WZhoam98WKYx0oMuza1SkfoCoq6qq121SH2vKpzdSLhTlgLLw/x4ToNh
Vc3r9XSeYZ4yGdg2X0lSoS5YW77gvHk8s/mNc8vQW4+BRBP6CnZhz4U6aK5OJXZc
N1t7bCOhRR640AyL41aezyh+znGUvlvxmgiiFmVcuvGt+QMiMSXEHZo11EuErxkn
ngZbuKMqX8gomwh268nNEpZqr9By+w==
=PTLS
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============6316736390420687754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6316736390420687754==--
