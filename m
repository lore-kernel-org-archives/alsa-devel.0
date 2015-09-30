From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
Date: Wed, 30 Sep 2015 19:22:19 +0100
Message-ID: <20150930182219.GU15635@sirena.org.uk>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpUp1egui7PDlNtH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yitian <yitian.bu@tangramtek.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Andrew.Jackson@arm.com, wsa@the-dreams.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--lpUp1egui7PDlNtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:
> Designware I2S uses tx empty and rx available signals as the DMA
> handshaking signals. during music playing, if XRUN occurs,
> i2s_stop() function will be executed and both tx and rx irq are
> masked, when music continues to be played, i2s_start() is executed
> but both tx and rx irq are not unmasked which cause I2S stop
> sending DMA handshaking signal to DMA controller, and it finally
> causes music playing will be stopped once XRUN occurs for the first
> time.

I'm a bit concerned about how this code ever worked given the above
description - is there some race condition which allows things to work
if we're lucky?

--lpUp1egui7PDlNtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDChaAAoJECTWi3JdVIfQdpAH/jPy5MTvbSOsEvuGL4GxlypV
4AQneDdVjvbE8Iy3zCkb0Wt5n9wuEqRlQUlNUtaqBtfITa2kKUoJspnGaz2jBwf2
2ZB/MKizDcpoxMrYsDVxyumZ+ls8mtugox+5QdzmJNO0SakQ6VjynAWAtI12KRso
EmylSuswYojPRRZ0DWP+OPdCB7mE2hX5gZDHF+tt/K79IcW+8CX3MfMpO1cygtDd
rNYMabf9CLgcpVoOymTYga1CEDj9p5x3Z2HO6gDov+3qdBSA5Tg7g3OMqpCIXIxe
Wju51vEABo5xbjTx7rUt8awDG2NqWaOZf+/hLLJoNn2UyyNUt6aQ0wUp+KSQiAY=
=HECV
-----END PGP SIGNATURE-----

--lpUp1egui7PDlNtH--
