From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix broadwell module removing
	failed issue
Date: Thu, 28 May 2015 16:44:34 +0100
Message-ID: <1432827874.2726.57.camel@loki>
References: <1432793658-9463-1-git-send-email-yang.jie@intel.com>
 <s5hegm07n7v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 564F42604BC
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 17:44:50 +0200 (CEST)
In-Reply-To: <s5hegm07n7v.wl-tiwai@suse.de>
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
Cc: broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-05-28 at 17:09 +0200, Takashi Iwai wrote:
> At Thu, 28 May 2015 14:14:18 +0800,
> Jie Yang wrote:
> > 
> > From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > 
> > In haswell-pcm module unloading, we can't free runtime modules
> > directly, for they may be already freed in runtime suspend.
> > 
> > Here add executing suspend call to unload runtime modules, only
> > for status not equal to RPM_SUSPEND, to fix broadwell module
> > removing failed issue.
> 
> What if a kernel is built without PM support?  (Practically seen, it's
> never any serious problem, though.)
> 

Keyon, it sounds like you will still need hsw_pcm_free_modules() and
should call it after the PM put/disable on module remove. You will need
to add some code too that will check the memory state prior to doing any
unloading though....

Liam



---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
