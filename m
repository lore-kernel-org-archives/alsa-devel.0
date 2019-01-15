From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Tue, 15 Jan 2019 21:41:38 +0000
Message-ID: <20190115214138.GL5522@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0615842036177131589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DFC2667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 22:41:41 +0100 (CET)
In-Reply-To: <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============0615842036177131589==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 03:16:57PM -0600, Pierre-Louis Bossart wrote:

> > Maybe the defer card probe logic needs to be extended to also check if
> > dai_link_name had already been registered (either cpu or cpu_dai_name
> > needs to be set), not 100% sure which problem the defer card probe patch
> > was trying to solve.

We were getting cards probing without the platforms being registered
(which in turn meant we were just skipping their init) and had patches
proposed to implement the deferral in the cards.  The deferral stuff is
supposed to making sure that everything is registered when we
instantiate.

> same here, I don't get why the deferred probe stuff only deals with one of
> the two options.

I think it's just an oversight - I think the change you were proposing
to check the cpu_dai_name is a good idea anyway as it makes things more
consistent and work more obviously by intention.  And more generally if
we can simplify the code by removing legacy options that'd be good but
that's a bigger bit of work...

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+U5EACgkQJNaLcl1U
h9B4Twf+IDkkxRFHywZyz/i5Uiq5yHfvR6SLLsoeMHo9aLX1z5Pm5mPIcw7nMe4M
xasbMImcQ172jVp+k9YySyZqHBKGqI4y72nU66WjCUEmAD3/080+eJu3SUFBBVVM
jbXeumfwTC0MfQ2QipJsIe4+7a2FvdTSzh8RGvBAErtF7GLC5I7i5vidE9iR/aKU
TJWNU0mB+rrnhDVZDAAtotZj4314oxG7HpL/9eMj+Vdv41j45sh0ALd2CU1ijymM
xTi7dXLT2R96+FVkl91u+HgoIcxrbaLxx5HFCMUjipLiXDjHdh50Qpi26C3rvzYq
tXa/Py+LY/FMSUAWgkR4TjbbpkP32w==
=IKZV
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

--===============0615842036177131589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0615842036177131589==--
