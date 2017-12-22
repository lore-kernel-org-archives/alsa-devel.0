From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 10/15] soundwire: Add sysfs for
 SoundWire DisCo properties
Date: Fri, 22 Dec 2017 17:13:44 +0530
Message-ID: <20171222114344.GS18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-11-git-send-email-vinod.koul@intel.com>
 <20171213091537.GA6269@kroah.com>
 <20171213095430.GO18649@localhost>
 <20171213162821.GB17132@kroah.com>
 <20171213165246.GQ18649@localhost>
 <20171213165922.GA6501@kroah.com>
 <20171222082656.GQ18649@localhost>
 <20171222083344.GA11307@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3997B26710A
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 12:39:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171222083344.GA11307@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Sagar Dharia <sdharia@codeaurora.org>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 22, 2017 at 09:33:44AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 22, 2017 at 01:56:56PM +0530, Vinod Koul wrote:

> > Hey Greg,
> > 
> > So I have spent couple of days on this but don't have a solution.
> > 
> > I can create a subdirectory using dynamic attribute group by giving it a
> > name. Works as advertised:). But I am unable to create subdirectory under
> > newly created subdir. The properties defined by MIPI follow a certain
> > hierarchy so we need subdirectories to represent that.
> 
> Yes, you can't create directories 2 levels deep, sorry, didn't realize
> you wanted to do that.
> 
> > Second issue am facing with these is getting the sdw_bus context. I tried
> > adding it but nothing looks elegant. I tried making sdw_attributes on top of
> > struct attribute and pass around the bus but doesn't seem to work for me.
> > 
> > On the contrary, the current design of creating kobjects looked more
> > cleaner. It has been used in bunch of other places, I double checked ref
> > counting and cleanup looks okay to me. Btw I tested with libudev as well,
> > its works well as we do send the event using kobject_uevent().
> 
> Where has it been used in other parts of the kernel like this?  Time to
> go yell at people :)
> 
> And the issue isn't that you will not catch the uevent, but that this is
> an attribute of the "parent" device, which is now not a device, but a
> "raw" kobject on no bus at all.
> 
> So, just create these as real struct devices, with a different "type"
> and have them all live on the bus properly.  Look at how the greybus
> code does it as one example (USB is another one, but it's much more
> complex.)

Thanks for the quick reply.

Are you sure greybus is a right example?

Looking at audio_manager.c we seem to create kset thus kobject without a
device. It lives off global sysfs!

Probing further I think you wanted to point me to gb_interface_create()
which I think would be similar to sdw_add_bus_master(). So we should
create a device without a driver for this and make kobjects live off it.

So IIUC it is okay to create kbojects but make sure we they live with a
'device' right?

Thanks
-- 
~Vinod
