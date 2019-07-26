From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm
 when enabled
Date: Fri, 26 Jul 2019 22:08:23 +0300
Message-ID: <20190726190823.GD9224@smile.fi.intel.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> This thread became unreadable with interleaved top-posting, allow me restate
> the options and ask PM folks what they think
> 
> On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
> > Not all platforms support runtime_pm for now, let's use runtime_pm
> > only when enabled.

Just a side note below...

> > -	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)

Here...

> > -		return ret;
> > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > +		if (ret < 0)

...and thus here...

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

...and here, the pm_runtime_put_noidle() call is missed.

>  		return ret;
> 
> option3: ignore the return value as done in quite a few drivers
> 
> Are there any other options? I am personally surprised this is not handled
> in the pm_runtime core, not sure why users need to test for this?

-- 
With Best Regards,
Andy Shevchenko
