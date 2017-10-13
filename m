From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Fri, 13 Oct 2017 15:39:01 +0100
Message-ID: <20171013143901.t5wtxesho2wip4d7@sirena.co.uk>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
 <20171013112503.5h25exymttetowbk@sirena.co.uk>
 <1507894543.5860.7.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0441605145389932342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 91AD72676A3
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 16:39:11 +0200 (CEST)
In-Reply-To: <1507894543.5860.7.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patchwork-lst@pengutronix.de, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org


--===============0441605145389932342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aygjnj2yniu35hlh"
Content-Disposition: inline


--aygjnj2yniu35hlh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2017 at 01:35:43PM +0200, Lucas Stach wrote:
> Am Freitag, den 13.10.2017, 12:25 +0100 schrieb Mark Brown:
> > On Fri, Oct 13, 2017 at 12:43:46PM +0200, Lucas Stach wrote:

> > > The commit [1] which changed imx-pcm-dma to derive the pcm_config fro=
m the
> > > attached dmaengine introduced a regression on the supported sample fo=
rmats,
> > > as imx-sdma doesn't properly advertise all the supported slave bus wi=
dths.

> > How did this work previously - shouldn't we have failed to use the
> > unadvertised bus widths?=A0=A0I'd expect the framework to be providing =
error
> > checking for the clients here.

> No, if the sound PCM implementation explicitly provides a pcm_config
> with the hw.formats set to 0, the core only looks at the DAI supported
> formats. Now that we derive the pcm_config from the dmaengine

I'm not talking about the sound side here...

> hw.formats gets filled with formats supported by the dmaengine, which
> is then used as an additional constraint by the core.

=2E..I'm talking about the constraints supported on the DMA side.  I would
not expect the DMA side to be accepting things it said it didn't support.

--aygjnj2yniu35hlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlng0AQACgkQJNaLcl1U
h9AJFAf+Jc2X56Uzzlu5Pn7aRitnuJ90lakZfv0aBBhgI2Ovd/+1bkmtsSfDnVBN
fnOLh7gLg2SDXg8G4cSQB+VbjK9AB5N8C3lWtbx2fWDQhYpYHFe/HFG+ccuds567
qYUPnYcmqYtPvJ7jixD20Fpzt6uNEBGIQN+lv79razD5jRKYG8BJ14xlffdsHdsG
ALxel2yF5yhzdKvwiFO6YuR4acHHC6XZlU9U1Si08NxeR001IZQfPEXZ1+c3NtEr
XeDYhkUOoaSGnVtXljYQB6hgkpNyU/tLfQFBfwAKynsPtUgw6pGRH1ZVWPE7iSBp
0mcjP08Nt9rt6GNlFByS/AAHl6ueyw==
=ZeN4
-----END PGP SIGNATURE-----

--aygjnj2yniu35hlh--

--===============0441605145389932342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0441605145389932342==--
