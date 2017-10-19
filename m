From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Thu, 19 Oct 2017 10:14:43 +0530
Message-ID: <20171019044443.GE30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <670b9fc6-69b1-b7f8-19c7-18b1b12b7674@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3251E26753D
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 06:40:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <670b9fc6-69b1-b7f8-19c7-18b1b12b7674@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


Thanks for the quick review Randy,

On Wed, Oct 18, 2017 at 08:33:08PM -0700, Randy Dunlap wrote:
> On 10/18/17 20:03, Vinod Koul wrote:

> > +SoundWire is a new interface ratified in 2015 by the MIPI Alliance.
> > +SoundWire is used for transporting data typically related to audio
> > +functions. SoundWire interface is optimized to integrate audio devices in
> > +mobile or mobile inspired systems.
> > +
> > +SoundWire is a 2-Pin multi-drop interface with data and clock line. It
> 
>                   2-pin

ok

> > +The SoundWire protocol supports up to eleven Slave interfaces. All the
> > +interfaces share the common Bus containing data and clock line. Each of the
> > +Slaves can support up to 14 Data Ports. 13 Data Ports are dedicated to audio
> > +transport. Data Port0 is dedicated to transport of Bulk control information,
> > +each of the audio Data Ports (1..14) can support up to 8 Channels in
> 
>                                 (1..13) ??

nope. 1 to 14, both inclusive, thats why 14 Data Ports

> > +Bus:
> > +Implements SoundWire Linux Bus which handles the SoundWire protocol.
> > +It programs all the MIPI defined Slave registers. It represents a SoundWire
> 
>                        MIPI-defined
> 
> > +Master. There can be multiple instances of Bus maybe present in a system.
> 
> eh?
>            Multiple instances of Bus may be present in a system.

sounds better

> > +int sdw_add_bus_master(struct sdw_bus *bus)
> > +{
> > +        if (!bus->dev)
> > +                return -ENODEV;
> > +
> > +        mutex_init(&bus->lock);
> > +        INIT_LIST_HEAD(&bus->slaves);
> > +
> > +	/* Check ACPI for Slave devices */
> > +        sdw_acpi_find_slaves(bus);
> > +
> > +	/* Check DT for Slave devices */
> > +	sdw_of_find_slaves(bus);
> 
> Please use same indentation as sdw_acpi_find_slaves().

ah not sure why it came like this, thanks for pointing out

> > +The MIPI specification requires each Slave interface to expose a unique
> > +48-bit identifier, stored in 6 read only dev_id registers. This dev_id
> 
>                                   read-only

right

> > +identifier, Bus enumerates the Slave device based on the 48-bit identifier.
> > +Slave device and driver match is done based on this 48-bit identifier. Probe
> > +of the Slave driver is called by Bus on successful match between device and
> > +driver id. A parent/child relationship is enforced between Slave and Master
> 
> maybe reverse this order.............                         Master and Slave
> 
> to be in the "parent/child" order?  Unless I have them backwards?

right, will update this

> > +devices (the logical representation is aligned with the physical
> > +connectivity).
> > +
> > +The information on Master/Slave dependencies is stored in platform data,
> > +board-file, ACPI or DT. The MIPI Software specification defines an
> 

ok

-- 
~Vinod
