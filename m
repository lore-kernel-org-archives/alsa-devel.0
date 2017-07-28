From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Reset hw_ptr on resume trigger
Date: Fri, 28 Jul 2017 13:46:34 +0100
Message-ID: <20170728124634.ajonhi3cdbb35qeb@sirena.org.uk>
References: <20170728084206.4431-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ng7ut4xzw5cujxyq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728084206.4431-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, Vinod.Koul@intel.com
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "U . Artie Eoff" <ullysses.a.eoff@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ng7ut4xzw5cujxyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 04:42:06PM +0800, Cheng-Yi Chiang wrote:
> From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
>=20
> Reset the hw_ptr before queuing the restore_stream_context
> work to eradicate a nasty white audio noise on resume.
>=20
> Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>

I can't do anything with this, you've not provided a signoff for it.
Please see SubmittingPatches for what a signoff means and why it's
important.

Please also try to send your patches to relevant people - you've sent
this to the ARM kernel list but not to Vinod Koul who's the main
maintainer for the Intel drivers.

--ng7ut4xzw5cujxyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7MikACgkQJNaLcl1U
h9CqjAgAgLUCUowwIQVAMKJCu3Wt/DjIESKoVkV3kU20TWQ7PTq/JKu40gOrp7uM
RqNqySgGPrLM0tqK3zt8y3LZMWt19bVSGlIGemC1z3YXSWMUWemWZiJGiZ3w/A3t
Cnpz2DlON5TswO4iipLoRp0dxGp8MwQCWySUJzem/DS4kLFX5Bs+WiSsfZtQUykh
mhXrVPAAF0kQzkT2hq1ndFlQ7d9cR7qDyXtyamolA94c0x3C97DUp97qJ0FvvB7e
gPn5DOM4vluqn4yMPWF+YLp97s1OTJ0sPhVeQagCH+6o/q9qBA2p846G3gx8qiyb
fZ3b6yNwFesis3Z17i++EowcNRqwhg==
=IfTl
-----END PGP SIGNATURE-----

--ng7ut4xzw5cujxyq--
