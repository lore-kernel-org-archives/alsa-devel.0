From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Tue, 30 Jul 2019 14:21:57 +0300
Message-ID: <20190730112157.GM23480@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
 <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 05:07:39PM -0500, Pierre-Louis Bossart wrote:
> On 7/26/19 2:08 PM, Andy Shevchenko wrote:
> > On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:

> > > -	if (ret < 0)
> > > +	if (ret < 0 && ret != -EACCES)
> > 
> > ...and here, the pm_runtime_put_noidle() call is missed.
> 
> yes but in the example you provided, they actually do more work than just
> decrement the device usage counter:

In their case they would like to do that. You decide what is appropriate call
in your case.

My point is, that reference counter in case of error handling should be
returned back to its value.

-- 
With Best Regards,
Andy Shevchenko
