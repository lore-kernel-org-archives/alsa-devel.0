From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
 detect CPUs
Date: Wed, 19 Jun 2019 14:08:26 +0300
Message-ID: <20190619110826.GC9224@smile.fi.intel.com>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
 <7ceb9ba8-74d9-4985-e760-40003dfbef3e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FA96F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 13:08:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7ceb9ba8-74d9-4985-e760-40003dfbef3e@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 18, 2019 at 09:26:50PM +0200, Cezary Rojewski wrote:
> On 2019-05-28 22:02, Pierre-Louis Bossart wrote:
> > We have duplicated code in multiple locations (atom, machine drivers,
> > SOF) to detect Baytrail, Cherrytrail and other SOCs. This is not very
> > elegant, and introduces dependencies on CONFIG_X86 that prevent
> > COMPILE_TEST from working.
> > 
> > Add common helpers to provide same functionality in a cleaner
> > way. This will also help support the DMI-based quirks being introduced
> > to handle SOF/SST autodetection.

> > +#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }

We have macros for this in intel-family.h.

> > +#define SOC_INTEL_IS_CPU(soc, type)				\
> > +static inline bool soc_intel_is_##soc(void)			\
> > +{								\
> > +	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
> > +		ICPU(type),					\
> 
> I understand there is a separate discussion going on, hope I don't get fried
> for throwing small code review.
> 
> Consider using same arg name for both ICPU and SOC_INTEL_IS_CPU macros,
> whether it's "model" or "type". It's more readable that way.
> 
> > +		{}						\
> > +	};							\
> > +	const struct x86_cpu_id *id;				\
> > +								\
> > +	id = x86_match_cpu(soc##_cpu_ids);			\
> > +	if (id)							\
> > +		return true;					\
> > +	return false;						\
> 
> Tenary operator should prove usefull here.

In this way it is simple
	return !!x86_match_cpu(...);

No conditional needed at all.

> 
> > +}

-- 
With Best Regards,
Andy Shevchenko
