From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 27 Oct 2017 10:57:39 +0200
Message-ID: <20171027085739.GA28825@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com>
 <20171020160134.GT30097@localhost>
 <20171026083342.GW936@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026083342.GW936@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 26, 2017 at 02:03:42PM +0530, Vinod Koul wrote:
> On Fri, Oct 20, 2017 at 09:31:34PM +0530, Vinod Koul wrote:
> > On Fri, Oct 20, 2017 at 12:45:28PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> 
> > > > +struct bus_type sdw_bus_type = {
> > > > +	.name = "soundwire",
> > > > +	.match = sdw_bus_match,
> > > > +	.uevent = sdw_uevent,
> > > > +};
> > > > +EXPORT_SYMBOL(sdw_bus_type);
> > > 
> > > No release callback?  Who frees the device?
> 
> Hmmm, bus_type doesn't seem to have a release callback. The sdw_device has
> release and that is added in the next patch. So I am not changing anything
> here. Let me know If I missed anything...

Ok, as long as you really have a release callback for when the device
goes away, and you have tested device removal...
