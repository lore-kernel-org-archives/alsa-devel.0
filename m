From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Add hw_params support for hostless stream BE
	DAIs
Date: Mon, 14 Mar 2016 11:12:47 +0000
Message-ID: <20160314111247.GA3683@sirena.org.uk>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
 <20160302020215.GN18327@sirena.org.uk>
 <20160310205703.GA26632@jeeja.kp@intel.com>
 <20160311035927.GQ3898@sirena.org.uk>
 <20160314175741.GA5556@jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2048721353459050126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4595326078A
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 12:12:55 +0100 (CET)
In-Reply-To: <20160314175741.GA5556@jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2048721353459050126==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 14, 2016 at 11:27:42PM +0530, Jeeja KP wrote:

> We discussed this and yes we are looking at ways to solve this longer
> term with DAPM but today DAPM doesn't help us in managing DMAs for our
> controller. I believe Vinod did discuss this limitation during ELC.
> We are starting this discussion internally and will try to solve
> this part.

We discussed using CODEC-CODEC links for this.  If you want to add DMA
operations to them then that's a simple matter of programming (which
IIRC we did discuss).

> Now for us to mange the internal sinks and source how should we go about
> modelling them in DAPM and provide hw_params for the configuration?

In the same way as anyone not doing it on a SoC does; at the minute that
means working out any settings that need configuration by looking at
what happens when the signal goes out onto an audio interface.  Ideally
we'd have a mechanism for propagating digital configuration along audio
paths.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW5pytAAoJECTWi3JdVIfQoPUH/34z0E35NDjgUuda+xlq1JfX
19KOlJFL+rARy7uFNBTmCjq9AIOZdaDiLUqVaRtxRVE9uUuhQP+hUYawrdgWtZO0
A988talOTaagKK9cciop4MBQ1ktzXhk4VUletQhLRy0Fd//Tw1LYv3H5KLHQos6u
hmg+wmNpmvJgZTL0sg1oDV1IDMFlLQUuyhImyhCe/s0LCnDKzXeGKTcqLa7vx7Tg
NNe+I+K52on3sIIw9XI4AD/MnhtVOUXhAZ4UNeFT1IUKqa/klKPntJer+J9tfdoO
8S6qLcAdrI37jSxmCT0U5PebMVdRboILm2PFS1P1GYvG7shJJIeUSihcYd4aPZE=
=cSfZ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--===============2048721353459050126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2048721353459050126==--
