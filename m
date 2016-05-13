From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: note buggy I2S support when the
 codec masters LRCLK
Date: Fri, 13 May 2016 12:42:32 +0100
Message-ID: <20160513114232.GH22038@sirena.org.uk>
References: <1461747993-11516-1-git-send-email-peda@axentia.se>
 <20160427162344.GA3217@sirena.org.uk>
 <29d9da68-789d-d3ea-cb9a-0230596e3069@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <29d9da68-789d-d3ea-cb9a-0230596e3069@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 11:29:53PM +0200, Peter Rosin wrote:
> On 2016-04-27 18:23, Mark Brown wrote:

> > Almost every programmable serial port does this, it's a very common
> > issue which is why we always try to go for exact clocking where we can -
> > it greatly improves the interoperability for I2S if there are no dead
> > clocks.

> Someone said: be conservative in what you send, be liberal in what you
> accept. This is not that at all. This is more like: be conservative in
> what you send, and accept only a subset of valid input.

> It absolutely kills interoperability if you claim I2S and then don't
> do I2S. If you are not looking at both edges of LRCLK it simply isn't I2S.
> It's something else. Like "packed I2S" or "DSP moda A with inverted
> symmetric LRCLK" or something, so why not invent a way to say that?

The reason people do this is so that they can interface I2S only CODECs
(which are reasonably common, especially simpler CODECs with no register
map) with SoCs that have programmable serial ports.  If you want to
spend the time to represent this explicitly through the system that
would be useful but note that the main reason the format configuration
is currently done manually is that especially with older devices it is
common for there to be gotchas in this, either in terms of things like
this or in terms of performance.  Determining what should master the bus
is an especially thorny issue, there are frequently tradeoffs between
the quality of the clocks and other restrictions.

> I have this codec which does I2S but there is no way to get rid of dead
> clocks when it masters the clocks. It can divide MCLK with 1,2,4,8 or 16
> to get a BCLK, or it can generate BCLK as 48x or 64x LRCLK. But it only
> sports 16 bits per sample.

In order to make that interoperate you should declare support for 24 and
32 bit formats in the DAI formats and set sig_bits to 16.  The
representation of memory formats in the DAIs that don't interface with
memory was a really unfortunate choice which sadly nobody has ever had
the time and/or enthusiasm to address.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNb2nAAoJECTWi3JdVIfQNXYH/2FyhGMybHO9GHENYtdbDvX8
6CE87WggzK4HNl3AQB6vN1Snb8K7PqfGQsRnVMLO/Zl/PLXMxOCg30gLYeoGJgPR
LNxNsYqFg+vIGjjttICdvMSCZaepkK8dntE9MsgcZFQSUmktcTBgxoJ01JdMXjVX
ug492pX5c8ZvBjqYXCnVzVmXBrVQIxdGq0K20fLw3FiJQe7w7LTtiMSIGpetRRW7
w0TUDm9urEZruKeoJZLUOcPIbdq2d430W1DICvqmV7EGWrZsr6KYRFN77Tnv7dkR
hVXKIK+egeerIbj0g6VTenAV1XjJ4i0CZMTjLR1MLL5BSu7vnIZhBt0SHYhi+sg=
=5s8F
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
