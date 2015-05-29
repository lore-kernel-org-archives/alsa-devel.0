From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix broadwell module removing
	failed issue
Date: Fri, 29 May 2015 07:46:37 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553BB6C@SHSMSX101.ccr.corp.intel.com>
References: <1432793658-9463-1-git-send-email-yang.jie@intel.com>
 <s5hegm07n7v.wl-tiwai@suse.de> <1432827874.2726.57.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C83260417
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 09:46:47 +0200 (CEST)
In-Reply-To: <1432827874.2726.57.camel@loki>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam R" <liam.r.girdwood@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Girdwood, Liam R
> Sent: Thursday, May 28, 2015 11:45 PM
> To: Takashi Iwai
> Cc: Jie, Yang; broonie@kernel.org; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ASoC: Intel: fix broadwell module removing failed issue
> 
> On Thu, 2015-05-28 at 17:09 +0200, Takashi Iwai wrote:
> > At Thu, 28 May 2015 14:14:18 +0800,
> > Jie Yang wrote:
> > >
> > > From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > >
> > > In haswell-pcm module unloading, we can't free runtime modules
> > > directly, for they may be already freed in runtime suspend.
> > >
> > > Here add executing suspend call to unload runtime modules, only for
> > > status not equal to RPM_SUSPEND, to fix broadwell module removing
> > > failed issue.
> >
> > What if a kernel is built without PM support?  (Practically seen, it's
> > never any serious problem, though.)
 
I think or kernel built without PM, empty pm_runtime_xxx()s are called and
no problems for that.

> >
> 
> Keyon, it sounds like you will still need hsw_pcm_free_modules() and should
> call it after the PM put/disable on module remove. You will need to add
> some code too that will check the memory state prior to doing any unloading
> though....
 
Yes, I plan to add both check before runtime_module_free() and set
pcm_data->runtime to NULL after that. At the same time, make sure
hsw_pcm_free_modules() is called before fw_unload() called.

With those implemented, suppose the issue can be fixed neatly.

I will test it and submit then.

~Keyon

> 
> Liam
> 
> 
