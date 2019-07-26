From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Fri, 26 Jul 2019 22:11:08 +0300
Message-ID: <20190726191108.GE9224@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726182534.GO16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726182534.GO16003@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 08:25:35PM +0200, Guennadi Liakhovetski wrote:
> On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> > On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
> > > Not all platforms support runtime_pm for now, let's use runtime_pm
> > > only when enabled.

> > option2 (suggested by Jan Kotas): catch the -EACCESS error code
> > 
> >  	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)
> > +	if (ret < 0 && ret != -EACCES)
> >  		return ret;

> Otherwise I'd go with (2), I think, since
> that's also the official purpose of the -EACCESS return code:
> 
> https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

And at least we have examples in the kernel

drivers/gpu/drm/radeon/radeon_fb.c:57:  if (ret < 0 && ret != -EACCES) {

-- 
With Best Regards,
Andy Shevchenko
