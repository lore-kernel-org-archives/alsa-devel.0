From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 10 Aug 2016 18:52:43 +0100
Message-ID: <20160810175243.GN9347@sirena.org.uk>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
 <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
 <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
 <20160810170632.GL9347@sirena.org.uk>
 <c794d543-a57a-aad6-1b62-4d101a79cdd3@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2632061453710435474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB954266819
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 19:53:06 +0200 (CEST)
In-Reply-To: <c794d543-a57a-aad6-1b62-4d101a79cdd3@linux.intel.com>
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


--===============2632061453710435474==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2016 at 12:31:28PM -0500, Pierre-Louis Bossart wrote:

> If we want to be consistent then we need to have a framework that handles
> both the SOC clock sources and the codec internal clock tree (including
> dividers and switches)
> I wonder if what you are hinting at is the codec driver modeling its
> internal PLL/clock tree with the clock API?

I'm not just hinting at that, I've openly stated it quite a few times
now!  :P  For the simpler CODECs it's kind of marginal if you need to
bother but for anything more complex (even things with PLLs) it seems
like the way forwards.

> If we have the clock API requesting the mclk only, and the rest of the co=
dec
> configuration is done by the machine driver there is no real progress I c=
an
> see.

It's still useful in that we can consistently manage the clocks external
to the CODEC that way, especially when looking at systems where it is
useful to dynamically start and stop the clocks.

> > The CODEC clearly has *some* idea of what's going on here, and
> > especially for simpler CODECs the code to drive the clocking should be
> > fairly easy to generalize as there's few options.  From a clock API
> > point of view the CODEC really ought to be the one requesting the clocks
> > that go into it, though there's nothing that says it has to only use its
> > own information to do that.

> I don't get the last part, how would the codec use information it doesn't
> own or have access to?

I'd expect that a clock consumer should (like a regulator consumer can)
be able to figure out what constraints there are on the rates it has
set.  Those could be fixed restrictions but it'd be good to also have
ways for other actors in the system to change things at runtime.

> At any rate, I am only trying to define the problem statement, probably
> something to talk about at the Audio Miniconference.

Yup.  I really should chase to see if that actually got accepted or
not...=20

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXq2npAAoJECTWi3JdVIfQoiMH/AkShQBYhz7E8L/yUBN+QHon
KkPYGoOr3B76nAfA0fOC57aqasNhAsnus7FMuQeZd+CLxJd3RuPH46QTRtDVt22z
DSNXkNExYi/1uWNBsnY7DXWKy0CXPMGoqx8eqKircAa4cCmuBFlC3jpZooswuUlx
wIU3TvCPxFkL/T7hZ2vgNp5I5svTEhyiHKmHqogc4mb9UMIOdJYgeqhvWBBdFdzy
GjbaklIdLKbP8R4oDDNeeIaBI+b+eFahD5Ur2d1tCujAhFK4E9Aubm2W1j/u6ZTo
l0Ib1RmxyN0VtreDjR0MfPyPIfYW0x3zlWfciy3IMcVk+bHRkIoyxCTFcF3anXc=
=JFUj
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--

--===============2632061453710435474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2632061453710435474==--
