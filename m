From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Sat, 21 Oct 2017 16:58:40 +0530
Message-ID: <20171021112840.GD30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 89AC6266C2E
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 13:24:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 09:57:44AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:17AM +0530, Vinod Koul wrote:
> 
> > +The SoundWire protocol supports up to eleven Slave interfaces. All the
> 
> There's lots of perfectly normal nouns in this document like Slave here
> which are randomly capitalized.  Is there some great reason for this?
> It makes the document pretty distracting to read.

Slave, SoundWire etc are MIPI definitions hence capitalized.

> > +Bus implements API to read standard Master MIPI properties and also provides
> > +callback in Master ops for Master driver to implement own functions that
> 
> implement it's own functions.

ok

> 
> > +provides capabilities information. DT support is not implemented at this
> > +time but should be trivial to add since capabilities are enabled with the
> > +device_property_ API.
> 
> Since we're making this up from whole cloth rather than following an
> existing standard let's get a DT binding document together and review
> the properties that are getting defined.

I don't have a DT to test, but looking at Slimbus code I guess assumptions
are fair and we seem to have similar concepts and implementation.

> 
> > +	/* Check ACPI for Slave devices */
> > +        sdw_acpi_find_slaves(bus);
> 
> Tab/space issues here.

fixed now

> 
> > +The MIPI specification requires each Slave interface to expose a unique
> > +48-bit identifier, stored in 6 read only dev_id registers. This dev_id
> > +identifier contains vendor and part information, as well as a field enabling
> > +to differentiate between identical components. An additional class field is
> > +currently unused. Slave driver is written for the specific 48-bit
> > +identifier, Bus enumerates the Slave device based on the 48-bit identifier.
> 
> So this says that the instance identifer is part of the device
> identifier but the driver should bind to the whole device identifer?
> I'd expect the driver to bind to everything except the instance
> identifer.

Other parts are still TBD and not really used, like Device Class, Spec
version. We are using only mfg id and part id for binding.

-- 
~Vinod
