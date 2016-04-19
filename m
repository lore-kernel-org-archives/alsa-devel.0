From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: docs: add clocking examples for DAI formats
Date: Tue, 19 Apr 2016 11:38:59 +0100
Message-ID: <20160419103859.GQ3217@sirena.org.uk>
References: <1461060688-19410-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J19t2I20ndwispKK"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461060688-19410-1-git-send-email-peda@axentia.se>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, peda@lysator.liu.se
List-Id: alsa-devel@alsa-project.org


--J19t2I20ndwispKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 12:11:28PM +0200, Peter Rosin wrote:

> +I2S
> +
> +LRC should have its flanks synchronized with a negative flank of BCLK.
> +The left channel word starts one BCLK cycle after a negative flank of LRC, and

Clock edges are normally referred to as such and have rising and falling
edges, please don't invent new terminology.  In general this is using
really strange language which makes it hard to follow.  Note also that
except for modes where clocks need to be exactly synchronized like left
justified the important thing is usually when the data can be sampled.
It takes time for changes to propagate so there's a distinction between
setting a state and when the state is looked at.

> +if LRC is not matching the word size. Also, see
> +https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf

Please make it clear that this is the official spec (there must be a
better link for it, this was literally the first hit on Google).

> +Left Justified (aka MSB)
> +
> +LRC should have its flanks synchronized with a negative flank of BCLK.
> +The left channel word starts directly after a positive flank of LRC, and the
> +right channel word starts directly after a negative flank of LRC. The words

This is unclear - what does "directly after" mean?  Is it the clock
after or do you mean that the data signal needs to change at the same
time as the falling edge of the LRCLK?  It should be the latter.

> +start with the MSB. Receivers must truncate words if more bits per word are
> +transmitted than they can use, and transmitters must pad words with zeros if
> +LRC is not matching the word size.

Neither of these is really true, both things are undefined behaviour
(this is how TDM works).  Transmitters can send anything or tristate and
it doesn't make much practical difference what happens on the recieve
side unless there's TDM.

> +Right Justified (aka LSB)
> +
> +LRC should have its flanks synchronized with a negative flank of BCLK.
> +The left channel word end right before a negative flank of LRC, and the right

Again, this is unclear - what is "right before"?  The final bit needs to
be sent on the BCLK edge preceeding the LRCLK transition.

> +DSP mode A

> +LRC should have positive flanks synchronized with a negative flank of BCLK.

LRCLK needs to rise before BCLK, it's good to do it on the preceeding
falling edge such that the timing is as relaxed as possible for the
reciever but not 100% a requirement.

> +The left channel word starts one BCLK after a positive flank of LRC, and the

It can be sampled...

> +right channel word starts directly after the left channel word. The words
> +start with MSB.

This isn't a stereo format, there can be any number of channels.

--J19t2I20ndwispKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFgrCAAoJECTWi3JdVIfQWF4IAIAaLL684M4mp6XpzbxnDkKm
a72Krs+kPURUuyVL37bDb5NZoWz0eVGwV61gmuKjndQQD8PXoyJrMu4pyqCBZO7q
uMblb+UqqOn1UU1jdXoWKLNDzZiPPM5gWDgTt5ZPSmjM53W9idZZQ5if9ZbYGlEK
q63VltjZ8ms+S+lmNn9J4ok9nmbeRCUKKzA/yNF5cCH6+f2P+bNMKDHqjuO9mZnm
X80r+mN0PJgyksnPo4romR9UBNlmybNci+9cUujV5pOslJRJVd8ZkSm8ycg0Frrc
TrhxThRyITbcnXP1rn+AC93qAaj2vEbI0FsMt0LwTJdWnoaKPJ5Ej4dN7yckKTY=
=nEG/
-----END PGP SIGNATURE-----

--J19t2I20ndwispKK--
