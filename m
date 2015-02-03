From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Tue, 3 Feb 2015 16:47:48 +0000
Message-ID: <20150203164748.GR21293@sirena.org.uk>
References: <cover.1421868426.git.moinejf@free.fr>
 <d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
 <54C0088F.9070609@metafoo.de>
 <20150122090723.50ac0156@armhf>
 <54C14EB3.8080305@metafoo.de>
 <20150123131554.623003f9@armhf>
 <54C252F4.9000504@metafoo.de>
 <20150123193456.276ea512@armhf>
 <20150123191343.GW21293@sirena.org.uk>
 <20150124083027.3b3a018f@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gCTdBMF3eqGffSYF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150124083027.3b3a018f@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--gCTdBMF3eqGffSYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 24, 2015 at 08:30:27AM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Jan 23, 2015 at 07:34:56PM +0100, Jean-Francois Moine wrote:

> > > The simple card builder, 'dt-card' (maybe a better name would have been
> > > 'graph-card'), acts just like the simple-card except that it does not
> > > appear in the DT. Its creation is done by an audio controller.

> > Which audio controller?  There may be several CPU side audio interfaces
> > in the same card.  For example people often want to have both low
> > latency and high latency audio paths from the CPU into the hardware (low
> > latency tends to increase power burn).  SoC centric system designs do
> > sometimes also have PDM I/O, expecting to be directly connected to DMICs
> > and so on, which results in a relatively large number of CPU interfaces.

> The audio controller which creates the card depends on the complexity
> of the card. When there are many controllers, it is up to the designer
> to define either a master audio controller or to instantiate a 'card'
> device via the DT for doing the job.

So how does the simple controller interact with a more complex one given
that it's somehow picking some controller node to start from?

> > > Well, forget about this. I never clearly understood why some widgets
> > > and routes had to be defined at card level.

> > Please do try to understand the idea of representing simple components
> > on the board and analogue interconects between devices - it's really
> > important and not something that can be neglected.

> The problem is that this understanding would stay abstract: I have no
> such a hardware. Anyway, if the representation can be done with the
> simple-card, it may also be done with a graph of ports.

If you have a device with any sort of speaker or microphone, or any sort
of external connector for interfacing with an external device like a
headphone jack, then you have something that could be a widget.

> > That DT binding was done entirely in the context of video applications
> > IIRC, this is the first time it's been discussed in this context.

> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070622.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086273.html

So there's been some in passing mentions, not really serious discussion
though...

--gCTdBMF3eqGffSYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0Pu0AAoJECTWi3JdVIfQTfIH/Rv2hjtstaMCJH4TB9LUcFwy
Stdb9sHB4vVufCeF6OHN5AGdFmIpTlT6vqq07F77ehEJCu7FTOyw6cc6FV9nW62B
8H2xAO+4JYTRK22PbQbv8/7JNpM4vOzLkVoh7cttBuyuHzs54V/0e0ivfNEV18sk
qglip0DQqHjbs/8xkzB1mrPCqkIlv/BnPrW80J7TpVFYgrywaU8ADhHm8WZAp1e8
ILT8p/z4Ql6B6ja+g0ii0jufpjjnCIIoKJiz/hsFwJm33W0I/VmroCyU+mv+Gywq
g/rVbn55Rqt6zpY4TagOF077WotLptu+k0djn4v1gZzkZUDchnF13J69jIPnPms=
=8c84
-----END PGP SIGNATURE-----

--gCTdBMF3eqGffSYF--
