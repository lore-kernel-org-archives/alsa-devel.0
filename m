From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7][RFC] ASoC: modern style CPU
Date: Wed, 17 Apr 2019 18:28:07 +0100
Message-ID: <20190417172807.GE5703@sirena.org.uk>
References: <87zhp144vs.wl-kuninori.morimoto.gx@renesas.com>
 <20190412115619.GK6909@sirena.org.uk>
 <87h8ayepjd.wl-kuninori.morimoto.gx@renesas.com>
 <87ftqieo0h.wl-kuninori.morimoto.gx@renesas.com>
 <f55ad838-1b1f-26c1-57a5-bf11937156fb@linux.intel.com>
 <87v9zdgnwk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1367836621549264814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DA2BF8071F
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 19:28:12 +0200 (CEST)
In-Reply-To: <87v9zdgnwk.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1367836621549264814==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 03:26:48PM +0900, Kuninori Morimoto wrote:

> > +SND_SOC_DAI_LINK_CCP(aif1,
> > +	SND_SOC_DAI_LINK(SDL_CPU("samsung-i2s.0")),
> > +	SND_SOC_DAI_LINK(SDL_CODEC("wm8994-codec", "wm8994-aif1")),
> > +	SND_SOC_DAI_LINK(SDL_PLATFORM("samsung-i2s.0")));

> > is this really the new direction?
> > Even the acronyms are not simple, it took me 15mn to figure out that
> > CCP stood for CPU/Codec/Platform and I couldn't figure out what SDL
> > means.

> The reason of "CCP" (= CPU/CODEC/PLATFORM) was to avoid long naming.
> and SDL is acronyms of "Snd soc Dai Link". but yes, it is un-understandable.
> It should be more understandable (and possibly short) naming.

I think you're right to want a shorter name but Pierre's probably right
that that particular name isn't the best...  I'm thinking it might be
good to look at the fully expanded definitions and then work back from
there, or perhaps just stick with them for a while (since the compact
forms are hopefully not a requirement for legibility, even if they are a
useful improvement).

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3YiYACgkQJNaLcl1U
h9AP9ggAgy24+9ijjbR8tHfO9XX4nZpQbb5WICAMleT1mrOqp9CDrVu9f788Qr6a
XipnyNbXRuciWSxywy5Ukzi7hBw+X3ZyYfM2Xcq0Gc7G6DqWYVORlEs0xztis1Ff
YSj14xPLdEe1/pVNbZ0l38ejIqZsg7nNCsZk8Kr4YZs5fx1G6XPc42aSqV9Q2tjJ
LWB7A34QuPJodqgsJD2yGdWAaMmOs3W3ZSiT2cDJ/MzmQFH7mVQMGzxmZFxq+eRF
BENozmXmhe/vDoACPdVT+1/UrH4/DAPwZkGxs4fsFjkBQODSUSlqzvoI3DSo7vHY
NDT5r0MQlRVa1iAqBrA6xT2y5sI8XA==
=WksM
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--

--===============1367836621549264814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1367836621549264814==--
