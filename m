From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 01/14] Documentation: Add SoundWire summary
Date: Mon, 23 Oct 2017 09:21:14 +0100
Message-ID: <20171023082114.qxngdzkm42v7dzzi@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
 <20171021112840.GD30097@localhost>
 <32258d12-f405-a62d-143a-c801ad06e097@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlozbvyivs3te3bf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32258d12-f405-a62d-143a-c801ad06e097@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org


--tlozbvyivs3te3bf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 22, 2017 at 03:36:32PM +0530, Pierre-Louis Bossart wrote:
> On 10/21/17 4:58 PM, Vinod Koul wrote:
> > On Sat, Oct 21, 2017 at 09:57:44AM +0100, Mark Brown wrote:

> > > There's lots of perfectly normal nouns in this document like Slave here
> > > which are randomly capitalized.  Is there some great reason for this?
> > > It makes the document pretty distracting to read.

> > Slave, SoundWire etc are MIPI definitions hence capitalized.

> I insisted to follow the conventions in the specification, it's not random
> at all.

It's making it pretty painful to read as kernel documentation.

> We can put together a DT binding document that follows the Disco spec but
> it'd be a bad idea to change the definitions or come up with new ones...

Given that there's a goal to do this via the device property stuff with
the apparent goal that we also use this stuff for DT it should at least
be run past some DT people. It may be that everything is totally fine as
is but we should at least check.

--tlozbvyivs3te3bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlntpncACgkQJNaLcl1U
h9CaWAf+NhQ6Hdd061aIsls9waNCgH8PQtGFYejgymD621rK4bQcWxJBupYN4bug
op8Tzb1YF0A0UbSEHYwjNvcL8J75nC2AdWrP64jLHK50UHyRjCNxRMq6EERy3TLg
pqXlqqTfrpntVmZbxBN47FFgnIylh/rJ6yG8B3G7FZTvet6Xrq/kshBhmWa13fFC
EXlzTdl8vAzsxQPr3jIIwxA1HVd9yL9RTePYmghNsuI1FtgOMj8qdPohADK3TCKk
/Kxhkjl14XtWWrWdRzOjuqvRXqSfA8j3LqtDd7ByJWRDEG/ul3t7aTOrR8bzqkCQ
PRl0Pg3A6Tru7PLh0ScfDwZscoNtdg==
=3+Q/
-----END PGP SIGNATURE-----

--tlozbvyivs3te3bf--
