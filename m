From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 19:02:48 +0000
Message-ID: <20181217190248.GI27909@sirena.org.uk>
References: <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
 <20181217173930.GF27909@sirena.org.uk>
 <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3936763459434294554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BB09D267AFC
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 20:02:50 +0100 (CET)
In-Reply-To: <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Dimitris Papavasiliou <dpapavas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3936763459434294554==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Content-Disposition: inline


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 12:08:36PM -0600, Pierre-Louis Bossart wrote:
> On 12/17/18 11:39 AM, Mark Brown wrote:

> > That looks a lot like the CODEC should be exporting a GPIO driver so the
> > machine driver doesn't actually need the regmap?  The only register
> > touched is _GPIO_CONTROL_1.

> I am not sure what you meant by 'exporting a GPIO driver' (mostly because I
> am not familiar with any GPIO framework) but indeed the local oscillator
> choice is controlled by a single register accessible through regmap - and
> changes to that register should only happen when the device is a specific
> state to prevent click/pops.

The GPIO framework provides a fairly simple view of GPIOs - from a user
point of view it's just getting or setting the value of a line.  It
looks like the register you're controlling isn't actually controlling a
chip feature directly but rather is setting a GPIO on the chip which
controls an external clock generator.  I could be misparsing things,
though.  I did glance at the pcm512x datasheet and didn't see pins or
anything that looked like an oscillator but I could've missed something.

> The machine driver should use clk_set_rate() and not directly handle regmap
> or codec stuff. If it does, or if the clock framework isn't relevant here
> then we can simplify all this as suggested in
> https://patchwork.kernel.org/patch/10444387/. What I was trying to do with
> the github update is to keep the clock framework, tie it closer with the
> codec parts with a state variable that prevents wild changes without going
> back to a 'safe' idle state (similar idea as PulseAudio clock changes, which
> can only happen when the PCM is not opened and used).

Right, I think bringing in the clock framework more is good -
effectively all I'm suggesting is changing the control interface used to
set the clock to add an indirection through gpiolib so you don't need to
pass the raw register map around.

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX8tcACgkQJNaLcl1U
h9D2Jgf+JngaUhAbUkO0hC4c/5uvSZ4GZLsgiBZldzPcU4bTVjAHXSTQ9RBkkerZ
zt51m/tCQQo2bhE2i4z5tuK1mTSojD7e5qxZsqL38/jbcQvqGU4v2r2X0QcvrbPh
tuymmDD4fmzpZvq4CD0oZizOn+HHvYxesm+M+/q+lmAZ1wwV7jOdNu0dL9/9mgRz
ppdLOCB07nOHxbnalKFgwKNaihK/+lOKNrWrxVBFUshKLbllZLl2NfKFoVvMFmTl
O3HIZHD/W5sd7PL3aLvCuB3sB888C3rvoQcrDzFvtKiu/MV9m1mr5+Y0ialTDu/2
SgYyMnAG2cTDzUq+42j4StNqqEcEAA==
=pIsa
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--

--===============3936763459434294554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3936763459434294554==--
