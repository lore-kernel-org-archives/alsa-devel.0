From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 10/15] soundwire: Add sysfs for SoundWire
 DisCo properties
Date: Fri, 22 Dec 2017 13:56:56 +0530
Message-ID: <20171222082656.GQ18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-11-git-send-email-vinod.koul@intel.com>
 <20171213091537.GA6269@kroah.com>
 <20171213095430.GO18649@localhost>
 <20171213162821.GB17132@kroah.com>
 <20171213165246.GQ18649@localhost>
 <20171213165922.GA6501@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213165922.GA6501@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 05:59:22PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 13, 2017 at 10:22:46PM +0530, Vinod Koul wrote:
> > On Wed, Dec 13, 2017 at 05:28:21PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Dec 13, 2017 at 03:24:30PM +0530, Vinod Koul wrote:
> > > > On Wed, Dec 13, 2017 at 10:15:37AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Wed, Dec 06, 2017 at 09:17:06PM +0530, Vinod Koul wrote:
> > > > > > It helps to read the properties for understanding and debugging
> > > > > > systems, so add sysfs files for SoundWire DisCo properties.
> > > > > > 
> > > > > > TODO: Add ABI files for sysfs
> > > > > 
> > > > > Is this TODO done?
> > > > 
> > > > Nope sorry not yet. But before this get merged will add
> > > > 
> > > > > > + * Base file is:
> > > > > > + *		properties
> > > > > > + *		|---- interface-revision
> > > > > > + *		|---- master-count
> > > > > > + *		|---- link-N
> > > > > > + *		      |---- clock-stop-modes
> > > > > > + *		      |---- max-clock-frequency
> > > > > > + *		      |---- clock-frequencies
> > > > > > + *		      |---- default-frame-rows
> > > > > > + *		      |---- default-frame-cols
> > > > > > + *		      |---- dynamic-frame-shape
> > > > > > + *		      |---- command-error-threshold
> > > > > > + */
> > > > > 
> > > > > Why nest them so deep?  Anyway, that's not really an issue I guess, it's
> > > > > your ABI, not mine :)
> > > > 
> > > > well it gives us a hierarchical view. We have N links...
> > > 
> > > That's fine, then make it a real 'struct device' if you want to have a
> > > reference counted object.  Tie it to your bus, and you are good to go.
> > > Don't use a raw kobject as that totaly breaks the device heirachy in the
> > > kernel as well as preventing any of these attributes from being accessed
> > > by userspace libraries (i.e. libudev.)
> > > 
> > > > > > +
> > > > > > +struct sdw_master_sysfs {
> > > > > > +	struct kobject kobj;
> > > > > > +	struct sdw_bus *bus;
> > > > > 
> > > > > Huh?  Why do you need to use kobjects?
> > > > > 
> > > > > When you switch from using a 'struct device' and hang a kobject off of
> > > > > it, that's a huge signal that something is wrong here.  That kobject
> > > > > will now no longer be part of the device "chain" in the system, uevents
> > > > > will get odd, and other strange things can happen.
> > > > > 
> > > > > Why can't you just use "normal" attributes attached to the device?  You
> > > > > shouldn't need a kobject here.  What am I missing?
> > > > 
> > > > Okay my understanding might be incorrect then. So we can have N links in
> > > > the system and each link would have a kobject for "link-N". Not sure how
> > > > device attributes would do link-N/clock-stop-modes and so on, if they can
> > > > let me know how and I will surely change that.
> > > 
> > > You can create a subdirectory for attributes quite easily.  If you don't
> > > want to make it a "full" object, and all you care about is the
> > > subdirectory, then do it that way.  Otherwise use a 'struct device'
> > > please.
> > 
> > Okay thanks this makes sense, yes all we do care about is creating
> > subdirectories and attributes under them. So in that sense we don't care
> > much about adding kobjects, it was means to the end.
> > 
> > So do you mind pointing an example, I though the way for that was kobjects
> > by looking at few examples I saw.
> 
> Create a dynamic attribute group on the fly and initialize it and set
> the name to the name you want for the subdirectory.  I know it's done in
> the kernel in some places, dig around :)

Hey Greg,

So I have spent couple of days on this but don't have a solution.

I can create a subdirectory using dynamic attribute group by giving it a
name. Works as advertised:). But I am unable to create subdirectory under
newly created subdir. The properties defined by MIPI follow a certain
hierarchy so we need subdirectories to represent that.

Second issue am facing with these is getting the sdw_bus context. I tried
adding it but nothing looks elegant. I tried making sdw_attributes on top of
struct attribute and pass around the bus but doesn't seem to work for me.

On the contrary, the current design of creating kobjects looked more
cleaner. It has been used in bunch of other places, I double checked ref
counting and cleanup looks okay to me. Btw I tested with libudev as well,
its works well as we do send the event using kobject_uevent().

> good luck!

Didn't help though :(

So let me know if you have any other suggestion, if not I
will send this once I add the Documentation for ABI.

-- 
~Vinod
