From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix pm_runtime_get_sync return
 code checks
Date: Sun, 14 Apr 2019 15:56:02 +0530
Message-ID: <20190414102601.GM28103@vkoul-mobl>
References: <20190405072655.25995-1-jank@cadence.com>
 <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
 <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
 <ace7e7f7-c3bf-f38c-0e70-da826175e3c5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ace7e7f7-c3bf-f38c-0e70-da826175e3c5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jan Kotas <jank@cadence.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 08-04-19, 12:43, Pierre-Louis Bossart wrote:
> 
> 
> On 4/8/19 2:12 AM, Jan Kotas wrote:
> > 
> > 
> > > On 5 Apr 2019, at 17:04, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> > > 
> > > On 4/5/19 2:26 AM, Jan Kotas wrote:
> > > > 
> > > >   	ret = pm_runtime_get_sync(slave->bus->dev);
> > > > -	if (ret < 0)
> > > > +	if (ret < 0 && ret != -EACCES)
> > > > 
> > > There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested an alternate solution for exactly the same code.
> > > 
> > > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > > +		if (ret < 0)
> > > +			return ret;
> > > 
> > > I am far from an expert on pm_runtime but Srinivas' solution looks more elegant to me.
> > 
> > Hello Pierre,
> > 
> > Please take a look at this patch, that was my inspiration:
> > https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html
> 
> The two patches seems to be identical:
> 
> static inline bool pm_runtime_enabled(struct device *dev)
> {
> 	return !dev->power.disable_depth;
> }
> 
> static int rpm_resume()
> [...]
> else if (dev->power.disable_depth > 0)
> 		retval = -EACCES;
> 
> 
> However I am still not clear on why this might fail.
> 
> I can only think of one possible explanation: there is no explicit
> pm_runtime_enable() in the soundwire code, so maybe the expectation is that
> the pm_runtime status is inherited from the parent (in the intel case the
> PCI driver), and that's missing in non-intel configurations?

IIRC that needs to be called by the Intel driver and those patches were
not upstreamed. So we dont have fully supported PM on upstream yet!

> 
> > I also took a look, and it seems the value returned by
> > pm_runtime_get_syncis simply ignored in a lot of places,
> > so checking its value may be excessive.
> But not checking seems careless at best...

-- 
~Vinod
