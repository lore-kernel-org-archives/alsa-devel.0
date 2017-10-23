From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Mon, 23 Oct 2017 08:50:50 +0100
Message-ID: <20171023075050.tly3jx436vs3xuof@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
 <20171021112840.GD30097@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7438053021877403236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F815266DCD
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 09:50:59 +0200 (CEST)
In-Reply-To: <20171021112840.GD30097@localhost>
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


--===============7438053021877403236==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndde5j6tu5vk4sur"
Content-Disposition: inline


--ndde5j6tu5vk4sur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 21, 2017 at 04:58:40PM +0530, Vinod Koul wrote:
> On Sat, Oct 21, 2017 at 09:57:44AM +0100, Mark Brown wrote:

> > There's lots of perfectly normal nouns in this document like Slave here
> > which are randomly capitalized.  Is there some great reason for this?
> > It makes the document pretty distracting to read.

> Slave, SoundWire etc are MIPI definitions hence capitalized.

Slave?  Really?

> > > +provides capabilities information. DT support is not implemented at this
> > > +time but should be trivial to add since capabilities are enabled with the
> > > +device_property_ API.

> > Since we're making this up from whole cloth rather than following an
> > existing standard let's get a DT binding document together and review
> > the properties that are getting defined.

> I don't have a DT to test, but looking at Slimbus code I guess assumptions
> are fair and we seem to have similar concepts and implementation.

That's fine, we can still review binding documents.

> > > +The MIPI specification requires each Slave interface to expose a unique
> > > +48-bit identifier, stored in 6 read only dev_id registers. This dev_id
> > > +identifier contains vendor and part information, as well as a field enabling
> > > +to differentiate between identical components. An additional class field is
> > > +currently unused. Slave driver is written for the specific 48-bit
> > > +identifier, Bus enumerates the Slave device based on the 48-bit identifier.

> > So this says that the instance identifer is part of the device
> > identifier but the driver should bind to the whole device identifer?
> > I'd expect the driver to bind to everything except the instance
> > identifer.

> Other parts are still TBD and not really used, like Device Class, Spec
> version. We are using only mfg id and part id for binding.

That's not what the document claims.

--ndde5j6tu5vk4sur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlntn1kACgkQJNaLcl1U
h9BqkAf/UgqYKnSXYbGR0pS1M76hi2Aa2907y71fvW8GCox85v/NpH6YXuQXqfSL
XOlPLgmpopENhW4/FxaX61RJq5ihpwvtiOUYaDGn3DQXaPn2gZhMKfuDc6La76Tb
54eVCwaXV9kPY4JttI193nLkvgyC/ipN/sRvOocIRC/q3YiGyk/jigcrV9yDzR6y
9TKx/425cnjGSXUlJPeYpv4S7BR06gS3ak1fAIkCt1CKAOEYwa4+AvWAqvo1z/7m
O79BaDkaKz38vtuTrU8RMq6HP4PCtI4zDwVwE9Dw5sCKCacWhkb7IiH14w2gkEFX
aG279W9jvKIXtM2iNW76l7sLhm9JpQ==
=6L+K
-----END PGP SIGNATURE-----

--ndde5j6tu5vk4sur--

--===============7438053021877403236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7438053021877403236==--
