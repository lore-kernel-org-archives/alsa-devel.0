From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
 detect CPUs
Date: Tue, 18 Jun 2019 13:02:06 +0200
Message-ID: <20190618130206.2c2ad38c@xxx>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
 <20190617144727.GR5316@sirena.org.uk>
 <29ad7270-9aa4-a002-0f0e-21b7a61fe8a4@linux.intel.com>
 <20190617161827.GH9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E2D7F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 12:58:12 +0200 (CEST)
In-Reply-To: <20190617161827.GH9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jun 2019 19:18:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 17, 2019 at 05:31:53PM +0200, Pierre-Louis Bossart wrote:
> > On 6/17/19 4:47 PM, Mark Brown wrote:  
> > > On Tue, May 28, 2019 at 03:02:55PM -0500, Pierre-Louis Bossart
> > > wrote: 
> > > > 2. is there a better way to do this for all Intel chips or do
> > > > we keep this in sound/? Andy?  
> 
> It's better to discuss with x86 maintainers.
> 
> > > ARM has platform detection stuff in the architecture code,
> > > something similar seems sensible for x86?  
> > 
> > Well yes, we already have x86_match_cpu() but that won't work with
> > COMPILE_TEST (asm/ headers don't exist) and this leads to
> > duplication of code. All we really need here is a yeah/nay answer
> > from a help that hides those details away.  
> 
> I don't see much advantage here. Without specific driver data it will
> be degraded to something like:
> 
> 	if (bootcpu.model == INTEL_CPU_...)
> 		...
> 
> with slight exception to heterogeneous SoCs.
> 
> In order to be compile tested we might introduce a header under
> include/platform_data/x86 with these inliners like:
> 
> static inline bool is_x86_model_XX(void)
> {
> 	return bootcpu.model == XX; // it might be done in more
> generic way? }
> 

You might also want to look at other drivers that do some kind of
platform detection.

There is:
tools/power/x86/turbostat/turbostat.c
which has few is_xxx() functions, and:
drivers/gpu/drm/i915/i915_drv.h
which has quite a lot of IS_XXX macros, although they are used to
detect PCI VGA devices, but maybe some code could be shared, with
separate device specific ids.

Amadeusz
