From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Bad rever-select of CONFIG_SND_HDA_I915
Date: Fri, 18 Mar 2016 13:36:49 +0530
Message-ID: <20160318080648.GH2490@localhost>
References: <s5hk2l0utly.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D583261293
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 09:02:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk2l0utly.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 08:34:49AM +0100, Takashi Iwai wrote:
> Hi,
> 
> while build testing, I noticed the following warning:
>   warning: (SND_SOC_INTEL_SKYLAKE) selects SND_HDA_I915 which has unmet direct dependencies (SOUND && !M68K && !UML && SND && DRM_I915 && SND_HDA_CORE)

Thanks Takashi for reporting,

> And it's indeed broken: you can't select CONFIG_SND_HDA_I915 from the
> driver side.  This is the condition depending on DRM i915 driver.

But who selects CONFIG_SND_HDA_I915. It is a bool symbol, so someone needs
to select it. I didn't see anyone select it, either from Gfx side or HDA
side?

> 
> Fixing this doesn't look too trivial, though.  Since
> SND_SOC_INTEL_SKYLAKE is the item to be selected, it can't have
> "depends on".  So, the top-level configs that select
> SND_SOC_INTEL_SKYLAKE need to have "depends on DRM_I915" lines, or
> modify the driver to be built without i915 binding.

can you please share the config where you saw this...

-- 
~Vinod
