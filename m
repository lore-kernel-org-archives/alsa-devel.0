From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 02/14] soundwire: Add SoundWire bus type
Date: Fri, 17 Nov 2017 09:22:37 +0530
Message-ID: <20171117035237.GI3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-3-git-send-email-vinod.koul@intel.com>
 <cb4fbc87-7857-5ab3-a2cd-413ee57c463e@linaro.org>
 <20171116170221.GD3187@localhost>
 <20171116172437.k64r5c6ehujwvogd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171116172437.k64r5c6ehujwvogd@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 05:24:37PM +0000, Mark Brown wrote:
> On Thu, Nov 16, 2017 at 10:32:21PM +0530, Vinod Koul wrote:
> > On Thu, Nov 16, 2017 at 04:05:17PM +0000, Srinivas Kandagatla wrote:
> 
> > > >+static const struct sdw_device_id *
> > > >+sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> > > Indentation looks Odd here,
> 
> > not really, the return type in preceding line is a perfect way to define
> > things...
> 
> Yeah, that's fairly normal - just ugly long.  You could also do it by
> splitting the arguments over two lines.

IMO that makes it look even worse :(

static const struct sdw_device_id *sdw_get_device_id(
					struct sdw_slave *slave,
					struct sdw_driver *drv)

current one seemed lesser evil :)

> 
> > > >+	ret = dev_pm_domain_attach(dev, false);
> > > >+	if (ret) {
> 
> > > I think we discussed this in v1, but erring out here means that all the
> > > devices need to have pm domain  attached, which might not be true all the
> > > time.
> 
> > oh yes, sorry i missed this one. will fix
> 
> Looking at this pattern here I'm wondering if this should be folded into
> the domain code, everything attaching a domain is going to need to take
> care of this at the minute.

Yes, but then only busses call this, handful of users and some like platform
core have bit different handling, so it may not work for them

-- 
~Vinod
