From: Mark Brown <broonie@kernel.org>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Wed, 30 May 2018 11:20:28 +0100
Message-ID: <20180530102028.GF6920@sirena.org.uk>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
 <20180530092445.GC6920@sirena.org.uk>
 <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8950035364198024954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6235E2676C4
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 12:20:29 +0200 (CEST)
In-Reply-To: <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8950035364198024954==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 11:47:15AM +0200, Daniel Mack wrote:
> On Wednesday, May 30, 2018 11:24 AM, Mark Brown wrote:

> > I think it's copied from somewhere else probably, it looks like there's
> > a bit of code motion going on.  I bet it was just for I2S, keeping the
> > extra clock cycle for the initial rising edge in the frame but not
> > actually required.

> Hmm, okay. You happen to still have access to that board for regression
> tests?

No, I doubt anyone does - it was the PXA32x reference platform.  The
ones I'm aware of unfortunately got thrown out.

> > > So for both 22050 and 44100, the base frequency and all dividers are the
> > > same, which can't be right. I assume these rates have never been used. I'll
> > > ignore this and implement the table in the datasheet which should do the
> > > right thing. Philipp?

> > That looks buggy, yeah.  I doubt anyone ever used 22.05kHz.

> AFAIU, it's rather the 44.1 rate that looks wrong. But okay, we'll see.

That's definitely been tested...  perhaps the parent rate is set
incorrectly?

> > > What we need, however, is a way to describe whether the dai is mclk master
> > > or slave. Would we add a DT propery for that?

> > That might be sensible, though the MCLK isn't really part of the DAI.

> Well, the DAI may well be the producer of the MCLK. If there's only a
> master/slave mode to decide, we could set that property on the machine side

It might be the same physical block, but the MCLK could also come from
somewhere completely different and not even need to be in sync with the
rest of the clocks.

> as well, in the subnode of simple-card for instance (similar to
> 'bitclock-master' and 'frame-master'), but then the question is which
> callback to use for propagating that master/slave setting to the cpu dai. We
> will, however, need such a callback anyway for non-DT boards, as those won't
> go away anytime soon. Could we squeeze that into the SND_SOC_DAIFMT_ mask?
> Not sure which options would be acceptable.

DAIFMT feels like a push, like I say we'll need to handle clocks that
aren't aligned with the DAI as well.  Possibly either the existing
set_sysclk() operation or some new operation.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOeusACgkQJNaLcl1U
h9BpgAf/Xf3/sXWCHhnNZfmZNNQu7U8s8GM/A48ySZ3Iq3bbcyucFSL/nJBrmj6C
JlnKxTnaJUKinoxxUW1WCJ4EJHPBO25yu8bOBSIY2B45c5CqFT50hP2Zb85Hv+dM
QZsF4jNyBDZBzXYb+8ffERWO/2rvEaGZv5zSg36icZ62+O+9ybFE1bTko/guONP5
1pefOwaM3z3XVagMCuETnNl4K+tn4dZOphrBsTNhQ3k/61kHLvcOGYWjG0JGnxZ4
NyIZ00OmEcldpWDtH8TtFA88kgkHXeAlIJtZro+X3YJNIiF/uSyLWW5mNZtgJWi6
JDB9mEpfc7zZgITfvovTnirOvi7wzg==
=BEBA
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

--===============8950035364198024954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8950035364198024954==--
