From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 10/15] soundwire: Add sysfs for
 SoundWire DisCo properties
Date: Wed, 13 Dec 2017 17:28:21 +0100
Message-ID: <20171213162821.GB17132@kroah.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-11-git-send-email-vinod.koul@intel.com>
 <20171213091537.GA6269@kroah.com>
 <20171213095430.GO18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id C98D3266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 17:28:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171213095430.GO18649@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 03:24:30PM +0530, Vinod Koul wrote:
> On Wed, Dec 13, 2017 at 10:15:37AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 06, 2017 at 09:17:06PM +0530, Vinod Koul wrote:
> > > It helps to read the properties for understanding and debugging
> > > systems, so add sysfs files for SoundWire DisCo properties.
> > > 
> > > TODO: Add ABI files for sysfs
> > 
> > Is this TODO done?
> 
> Nope sorry not yet. But before this get merged will add
> 
> > > + * Base file is:
> > > + *		properties
> > > + *		|---- interface-revision
> > > + *		|---- master-count
> > > + *		|---- link-N
> > > + *		      |---- clock-stop-modes
> > > + *		      |---- max-clock-frequency
> > > + *		      |---- clock-frequencies
> > > + *		      |---- default-frame-rows
> > > + *		      |---- default-frame-cols
> > > + *		      |---- dynamic-frame-shape
> > > + *		      |---- command-error-threshold
> > > + */
> > 
> > Why nest them so deep?  Anyway, that's not really an issue I guess, it's
> > your ABI, not mine :)
> 
> well it gives us a hierarchical view. We have N links...

That's fine, then make it a real 'struct device' if you want to have a
reference counted object.  Tie it to your bus, and you are good to go.
Don't use a raw kobject as that totaly breaks the device heirachy in the
kernel as well as preventing any of these attributes from being accessed
by userspace libraries (i.e. libudev.)

> > > +
> > > +struct sdw_master_sysfs {
> > > +	struct kobject kobj;
> > > +	struct sdw_bus *bus;
> > 
> > Huh?  Why do you need to use kobjects?
> > 
> > When you switch from using a 'struct device' and hang a kobject off of
> > it, that's a huge signal that something is wrong here.  That kobject
> > will now no longer be part of the device "chain" in the system, uevents
> > will get odd, and other strange things can happen.
> > 
> > Why can't you just use "normal" attributes attached to the device?  You
> > shouldn't need a kobject here.  What am I missing?
> 
> Okay my understanding might be incorrect then. So we can have N links in
> the system and each link would have a kobject for "link-N". Not sure how
> device attributes would do link-N/clock-stop-modes and so on, if they can
> let me know how and I will surely change that.

You can create a subdirectory for attributes quite easily.  If you don't
want to make it a "full" object, and all you care about is the
subdirectory, then do it that way.  Otherwise use a 'struct device'
please.

thanks,

greg k-h
