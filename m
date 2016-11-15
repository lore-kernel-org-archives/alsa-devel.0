From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC 09/14] SoundWire: Add support to handle Slave
 status change
Date: Tue, 15 Nov 2016 09:56:36 +0000
Message-ID: <20161115095636.GQ1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-10-git-send-email-hardik.t.shah@intel.com>
 <20161114160805.GO1575@localhost.localdomain>
 <8f415778-f55a-3038-ec87-4b0ffea32b87@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8f415778-f55a-3038-ec87-4b0ffea32b87@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2016 at 11:38:08AM -0600, Pierre-Louis Bossart wrote:
> On 11/14/16 10:08 AM, Charles Keepax wrote:
> >There are some issues with this, as the slave driver only probes
> >when the device actually shows up on the bus. However often
> >(especially in embedded contexts) some things may need to be
> >done to enable the slave. For example it may be held in reset or
> >its power supplies switched off until they are need. As such it
> >generally helps if the device probe can be called before it shows
> >up on the bus, the device probe can then do the necessary actions
> >to enable the device at which point it will show up on the bus.
> 
> Yes, this point was made at the LPC miniconference. What's not clear to me
> is if you would want the codec driver to be notified that the bus is
> operational and let it handle things like sideband power management for that
> device, or is someone else needs to know.
> 

I would think it would make sense to provide callbacks that
notify the end driver that the device has appeared on/disappears
from the bus. Similar to the Qualcomm SLIMBus stuff with the
device_up and device_down callbacks. Not all devices will need to
use them but they are probably handy to have.

As for actually notifying the end driver that bus itself is
operational is the PM runtime stuff going to be sufficient there?
As the slaves will be children of the master can't we use that to
ensure the bus is always powered when something is in use, and
the children themselves can then decide how much power management
to apply when they are not in use.

Thanks,
Charles
