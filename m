From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Wed, 30 May 2018 10:49:01 +0100
Message-ID: <20180530094901.GE6920@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <20180529112447.GC23509@sirena.org.uk>
 <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5965920488156982661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 36C7F267688
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 11:49:02 +0200 (CEST)
In-Reply-To: <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============5965920488156982661==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 10:23:48PM +0200, Daniel Mack wrote:
> On Tuesday, May 29, 2018 01:24 PM, Mark Brown wrote:

> > If we want to get more complex usage of clocks in the DT we should be
> > moving the CODECs over to using the standard clock bindings for this
> > stuff rather than inventing custom ASoC clock bindings for it.  That way
> > we don't have to deal with the pain of trying to join things up in the
> > future.

> This will get rather complex too though, because most codec and cpu dais can
> act as clock source xor clock consumer, depending on how the hardware is
> built. Would you want to represent everything, bit clocks, frame clocks,
> master clocks etc as clock nodes?

We're probably OK just going down to the master clocks mostly I think.
For the clocks on the actual bus we can probably have helpers in the
core that generate the clocks and the drivers just tell the core the
rates.

> If that's the case, could you depict how the DT bindings should look like by
> example?

I've not been able to dig far enough into the clock bindings yet.
That's not super helpful for you I appreciate, TBH nobody seemed to
particularly need this so it wasn't super urgent - most of the things
using alternative clocks on devices seem to also need custom machine
drivers for other reasons.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOc4wACgkQJNaLcl1U
h9AjtAf/cdC7eyZp5ggY3+UOZi//ylePT/NRAxdS5SWZoVG7ogYCCU6WUSSEc4yX
hxtvmlBeLHWVzyhVybabpeHCZR2r21+MngsVYefTP95M79nvBQKZXKEY2lMrtf9y
ntPv2pMDcXWd4jgPT7r4REyL2icvw3AaOjqJPzl2GSGQNCZyCB20iQ7tJN3VWcDy
xwBKOrf8XQA4qmXX2hBsJI3mHfLXSkTfF1AYG7Br0nHu/3EfOPynpB5htQku41u2
yFR9yzdbFX11UtfDwge7GlGT6I3awqSwJ/a+ewUfHcBVEZAdPPZH3AUNwwRHIMwi
23/iwm6DEvrClu7MFLKcxb7+gMHTwg==
=l7v+
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

--===============5965920488156982661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5965920488156982661==--
