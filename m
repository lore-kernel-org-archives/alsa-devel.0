From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Mon, 23 Oct 2017 09:24:26 +0100
Message-ID: <20171023082426.77tcpq4wtd4cwi7i@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
 <20171021091230.pwevgreloynqe7nu@sirena.org.uk>
 <20171021113513.GF30097@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3838039316523349916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B85C1266DCD
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 11:26:03 +0200 (CEST)
In-Reply-To: <20171021113513.GF30097@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============3838039316523349916==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lqsfbivgarcojcqj"
Content-Disposition: inline


--lqsfbivgarcojcqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 21, 2017 at 05:05:13PM +0530, Vinod Koul wrote:
> On Sat, Oct 21, 2017 at 10:12:30AM +0100, Mark Brown wrote:
> > On Thu, Oct 19, 2017 at 08:33:19AM +0530, Vinod Koul wrote:

> > > +	mutex_lock(&bus->bus_lock);
> > > +	if (!list_empty(&bus->slaves))
> > > +		list_del(&slave->node);

> > Shouldn't that be a while?  Or at least warn if there's anything extra
> > there.  The code just looks very wrong as is.

> I think you missed that it is called from sdw_delete_bus_master() which does
> the loop by invoking device_for_each_child(), so this ones is supposed to
> ensure one Slave is removed cleaned.

> Let me know if i misread your comment.

My point is that this code just looks so obviously wrong it doesn't
matter if it actually works, we should refactor so people don't look at
the code and immediately think they've spotted a bug.

--lqsfbivgarcojcqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlntpzkACgkQJNaLcl1U
h9C8IAf/ZPUBQ0L8rcDJUynlZVNRpg+CsnJ0IICwqF93Lazy/FVzEgoTxs8hnUuN
IjV5w9aMZ0xxa1fqWvlEmkHIrJKaczGQGAQVE/CDTjYcue3jEIVMcQaqTNKnlZq+
Anbtr4ndtZL6Ss07osv+64bvTa2glb7piuKhjKRe1D/VofBFYOhlZ035DSkFXpYG
t1YfqTxq9c+NOt/dP3LI8IFQtt99FPiTsNr7WjI4uTvhUKmjCGTgR/Qee5dy4G7+
oMFoumFWmkh7IfjhaXnVx6T+EQuTWmud0aKiDP9oV/odruryXisFQgTDv2oGedsw
ZKcTq+QbSWLPU4vkOVKKuvwBM5Jp5A==
=j6N+
-----END PGP SIGNATURE-----

--lqsfbivgarcojcqj--

--===============3838039316523349916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3838039316523349916==--
