From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix refcount underflow
Date: Mon, 18 Feb 2019 17:50:10 +0000
Message-ID: <20190218175010.GB10794@sirena.org.uk>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
 <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
 <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hpnrp8ret.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "vicencb@gmail.com" <vicencb@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 08:52:26AM +0100, Takashi Iwai wrote:
> Daniel Baluta wrote:

> > > Fixes: commit da215354eb55c ("ASoC: simple-card: merge simple-scu-
> > > card")

> > Thanks! I thought about adding this but the current patch will not
> > cleanly apply because of:

> > 2d01a84605a55c ("ASoC: simple-card: reduce naming prefix")

That doesn't matter for fixes tags.  However...

> Yeah, it's a bit tricky because of the code change at this time.

> At best, send two patches, once for 5.0 and once for 5.1, and let Mark
> apply both of them and do the empty merge from 5.0 to 5.1, or let him
> resolve the merge conflict by applying manually the 5.1 patch.

...since this is something that needs to be fixed for v5.0 we need a
patch that can be applied on v5.0 (and has been tested by someone who
sees the issue there).  Takashi's plan seems like a good way to do that,
if you could send a patch against my for-5.0 branch (or just Linus'
tree) that'd be great.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq8FIACgkQJNaLcl1U
h9B58Qf+I/VpXqp+ASMjZ2UG85bKjLNGgZTHGDBbBYTTHLdWKjUrcyZqeiZ5A/lJ
DxUx8EIo+4PbmytunRjAvZHyp3K9s/6ozEyj4qbyCe81YyE2cqNQopHkucIA0b+X
nwyse/s7n7QqFjkFgTd4WNkveRowP/CvV4FzfucxBRKoL/5AkpGFkfDAGNTY6RDb
M5xpiDeUErV52RCFuZ7rwGNh57G4RVFnKcQV507ZuwxVlZ4kl++QdyeAHMGDlnXS
sUc3GXS4QzMCuTYUUW4aR+FkBjvFitc/3q1MTqQ8UytaiyGNIgqIYOjSHkhDFZIa
pBqnUzari84A+/+ehuQbJNUUeo9y9Q==
=dxr7
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
