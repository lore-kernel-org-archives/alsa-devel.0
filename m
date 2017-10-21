From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Sat, 21 Oct 2017 17:05:13 +0530
Message-ID: <20171021113513.GF30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
 <20171021091230.pwevgreloynqe7nu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 017B1266C2E
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 13:30:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171021091230.pwevgreloynqe7nu@sirena.org.uk>
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

On Sat, Oct 21, 2017 at 10:12:30AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:19AM +0530, Vinod Koul wrote:
> 
> > +	/*
> > +	 * SDW is an enumerable bus, but devices can be powered off. So,
> > +	 * they won't be able to report as present.
> > +	 *
> > +	 * Create Slave devices based on Slaves described in
> > +	 * the respective firmware (ACPI/DT)
> > +	 */
> > +
> > +	if (IS_ENABLED(CONFIG_ACPI) && bus->dev && ACPI_HANDLE(bus->dev))
> > +		ret = sdw_acpi_find_slaves(bus);
> > +	else if (IS_ENABLED(CONFIG_OF) && bus->dev && bus->dev->of_node)
> > +		ret = sdw_of_find_slaves(bus);
> > +	else
> > +		ret = -ENOTSUPP; /* No ACPI/DT so error out */
> 
> Devices *can* be powered off but is there any reason that a system
> couldn't be designed with them always powered?  Also given that we don't
> actually have any DT support the stubs for it are at best misleading,
> it's not going to be hard for someone to add them later.

Some people asked me to add it so it is clear how it would be supported on
DT based platforms. I would be too glad to remove if we have consensus on
that. Agree it is not too hard to add :)

> 
> > +	mutex_lock(&bus->bus_lock);
> > +	if (!list_empty(&bus->slaves))
> > +		list_del(&slave->node);
> 
> Shouldn't that be a while?  Or at least warn if there's anything extra
> there.  The code just looks very wrong as is.

I think you missed that it is called from sdw_delete_bus_master() which does
the loop by invoking device_for_each_child(), so this ones is supposed to
ensure one Slave is removed cleaned.

Let me know if i misread your comment.


Thanks
-- 
~Vinod
