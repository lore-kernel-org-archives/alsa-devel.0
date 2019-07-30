From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Date: Tue, 30 Jul 2019 18:59:25 +0300
Message-ID: <20190730155925.GT23480@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
 <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
 <20190730112157.GM23480@smile.fi.intel.com>
 <a1b383b3-7846-3545-38a5-beece3e52849@linux.intel.com>
 <20190730155809.GS23480@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730155809.GS23480@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, tiwai@suse.de, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 06:58:09PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 30, 2019 at 07:57:46AM -0500, Pierre-Louis Bossart wrote:
> > On 7/30/19 6:21 AM, Andy Shevchenko wrote:
> > > On Mon, Jul 29, 2019 at 05:07:39PM -0500, Pierre-Louis Bossart wrote:
> > > > On 7/26/19 2:08 PM, Andy Shevchenko wrote:

> > so marking it as last_busy+autosuspend, or using a plain vanilla put() will
> > not result in any action. I must be missing something here.
> 
> put_noidle(). Because if it failed on the first call and was resumed, put()
> will try to shut it down (since reference count goes to no-user base).

Sorry, this has to be read as (was -> wasn't)

> put_noidle(). Because if it failed on the first call and wasn't resumed, put()
> will try to shut it down (since reference count goes to no-user base).

-- 
With Best Regards,
Andy Shevchenko
