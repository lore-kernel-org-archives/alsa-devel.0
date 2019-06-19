From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
 detect CPUs
Date: Wed, 19 Jun 2019 16:04:13 +0300
Message-ID: <20190619130413.GG9224@smile.fi.intel.com>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
 <7ceb9ba8-74d9-4985-e760-40003dfbef3e@intel.com>
 <20190619110826.GC9224@smile.fi.intel.com>
 <8710d43c-4612-14ab-46e4-4f95ceb4c70b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADF23F80CC4
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 15:04:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8710d43c-4612-14ab-46e4-4f95ceb4c70b@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 19, 2019 at 01:52:57PM +0200, Pierre-Louis Bossart wrote:
> 
> > > > Add common helpers to provide same functionality in a cleaner
> > > > way. This will also help support the DMI-based quirks being introduced
> > > > to handle SOF/SST autodetection.
> > 
> > > > +#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> > 
> > We have macros for this in intel-family.h.
> 
> Andy, just to double-check, were you referring to the following macro?
> #define INTEL_CPU_FAM6(_model, _driver_data)

Yes, and my patch to move pointer elsewhere.
Now I realize that the macro without data pointer wasn't accepted by some reason.

-- 
With Best Regards,
Andy Shevchenko
