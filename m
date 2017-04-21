From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: dwc: disallow building designware_pcm
 as a module
Date: Fri, 21 Apr 2017 11:49:15 +0100
Message-ID: <20170421104915.x7gxt5yqcuewa7rv@sirena.org.uk>
References: <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
 <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
 <20170420194646.qcpu7w3acjyfmeu5@sirena.org.uk>
 <s5h37d2su8h.wl-tiwai@suse.de>
 <376c5933-9321-5399-74c7-6fd4943fab3d@synopsys.com>
 <s5hshl2kpst.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rk7cqetjqdsl7djg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hshl2kpst.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Lubomir Rintel <lkundrak@v3.sk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--rk7cqetjqdsl7djg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2017 at 12:39:30PM +0200, Takashi Iwai wrote:
> Jose Abreu wrote:

> > Maybe rename to "dwc-i2s.c" and "dwc-pcm.c" (as the folder is
> > called "dwc") and let the module still be called "designware-i2s"?

> Lubomir's patch keeps the module name intact.  My point is that rename
> of a file isn't nice to look at the git commit history, so it's better
> to be avoided as much as possible.  But in this case, it looks
> unavoidable.

Right.  Renaming the source file is the lesser evil, it's possible
people might have the module name in their configuration for their
systems somewhere.

--rk7cqetjqdsl7djg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj546oACgkQJNaLcl1U
h9AyQAf+LAzZdrJrVhgbNMOfj86iJ8FaxR3Lfvru+dsIvLXyeBMZihg1brCQsxp2
z3eNcQCUfXqON6BfXTaArfGXTrGlGOCkMKV4K2ELnlmHkYeS6QfpVFrSwPPVQ4bB
qGCneOr86ih128tF4ECsnuzILUdSyhF7KqDpRh+5/dmLhD8/7i5yLUJeReugA628
peio/B93ELDJGpjGPyQrYYpJW3TD/CljOhSXVrxjEdG8+sMLyDjfcY1dsUMu1XCi
sY/QTOkY2GAIZkiotoqwb1ONKXqd5/UiMA2IaN09LLwfVQNg5SDSA6yZ93pAGa2W
YEYwiV7RPCuS/p5lxCSWd+J1m/rOXw==
=Fnsr
-----END PGP SIGNATURE-----

--rk7cqetjqdsl7djg--
