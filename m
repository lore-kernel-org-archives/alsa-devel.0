From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 10 Aug 2016 18:06:32 +0100
Message-ID: <20160810170632.GL9347@sirena.org.uk>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
 <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
 <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2724614979517317325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FFBF266728
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 19:06:53 +0200 (CEST)
In-Reply-To: <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
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
Cc: mark.rutland@arm.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Darren Hart <dvhart@linux.intel.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2724614979517317325==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2016 at 08:57:28AM -0500, Pierre-Louis Bossart wrote:

> Without going into a debate on x86 v. the clock API or the merits of a patch
> that has already been applied, I am pretty confused on who's supposed to
> manage the mclk between the machine and codec driver.

> So on a DAPM transition the clock is enabled. Fine.
> What's not clear here is that the codec driver doesn't know what rates are
> supported by the SOC/chipset. The machine driver is typically the one doing
> calls such as

This should really be being propagated through the clock tree by the
clock API rather than open coded - for a lot of things it'll just boil
down to a clk_set_rate() at the edge of the clock tree.  Any constraints
should also be applied through the clock API, though in a lot of cases
the devices are simple enough that it should be a fairly mechanical
process.

> so the summary is that we have two ways of doing the same thing - turning
> the mclk on when it's needed - and I wonder if doing this in the codec is
> really the right solution? Again this is not a question on the merits of the
> clk API/framework but whether we can have a single point of control instead
> of two pieces of code doing the same thing in two drivers.
> If I am missing something I am all ears.

We've got two ways of doing this at the minute partly because
historically things have been open coded in the machine drivers due to
the lack of a clock API, now we have one we can use we should be using
it consistently to set rates.  Where the machine driver needs to do
things dynamically it really ought to be able to express the constraints
it's trying to set through the clock API, if we can't do things we need
we should improve the clock API.  This will mean that we don't have to
reinvent the wheel when we're doing things with clocks, we have
consistent interfaces to all parts of the clock tree and other bits of
the system will get reuse from anything we've learned about
implementation.

The CODEC clearly has *some* idea of what's going on here, and
especially for simpler CODECs the code to drive the clocking should be
fairly easy to generalize as there's few options.  From a clock API
point of view the CODEC really ought to be the one requesting the clocks
that go into it, though there's nothing that says it has to only use its
own information to do that.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXq18XAAoJECTWi3JdVIfQONcH/j1nEc+sO9quCV1emA37XseH
7MMMrEYV+tpEwP1uk10+8f6I/hYAHGumux5VnhtRQIM3efsKxYHOGGSf7tzFBNiL
ME07JJXDd67aJ1Zk41hWCTP3U7RBfIGFoZIE3+7gr63+XAwYFcd1sCUe6CO4RoS8
gw9MN8Uqrdc2Nj+rR0+5kppsm+SfyzKF/SZfOxR87n+aykKBT+Q+HskAZXIxjeSQ
AhUaPLk0/h0738jEt+nwnrfD/nnY7ACRYCxcXY8arWzITk8g6EUv81Cx4sq0BGtX
wzGKJ3NZw16qccgBffzLwboWcVUfApRM6ZKcKmi3nGvvhRlRm7uddTKBUDS9bJc=
=jQAw
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--

--===============2724614979517317325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2724614979517317325==--
