From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Fri, 26 Jul 2019 20:25:35 +0200
Message-ID: <20190726182534.GO16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> This thread became unreadable with interleaved top-posting, allow me restate
> the options and ask PM folks what they think
> 
> On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
> > Not all platforms support runtime_pm for now, let's use runtime_pm
> > only when enabled.
> > 
> > Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >   drivers/soundwire/bus.c | 25 ++++++++++++++++---------
> >   1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> > index 5ad4109dc72f..0a45dc5713df 100644
> > --- a/drivers/soundwire/bus.c
> > +++ b/drivers/soundwire/bus.c
> > @@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> >   	if (ret < 0)
> >   		return ret;
> > -	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >   	ret = sdw_transfer(slave->bus, &msg);
> > -	pm_runtime_put(slave->bus->dev);
> > +
> > +	if (pm_runtime_enabled(slave->bus->dev))
> > +		pm_runtime_put(slave->bus->dev);
> 
> This is option1: we explicitly test if pm_runtime is enabled before calling
> _get_sync() and _put()
> 
> option2 (suggested by Jan Kotas): catch the -EACCESS error code
> 
>  	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> 
> option3: ignore the return value as done in quite a few drivers
> 
> Are there any other options? I am personally surprised this is not handled
> in the pm_runtime core, not sure why users need to test for this?

option 4: fix this in runtime PM :-) This seems like the best option to me,
but probably not the easiest one. Otherwise I'd go with (2), I think, since
that's also the official purpose of the -EACCESS return code:

https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

Thanks
Guennadi
