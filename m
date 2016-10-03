From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 3/7] ALSA: pcm: avoid mmap of control data
 if .update_appl_ptr is implemented
Date: Mon, 3 Oct 2016 10:13:22 +0530
Message-ID: <20161003044322.GC23816@subhransu-desktop>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-4-git-send-email-subhransu.s.prusty@intel.com>
 <s5h7f9t33qa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB0E2666A8
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 06:49:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7f9t33qa.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2016 at 03:40:45PM +0200, Takashi Iwai wrote:
> On Fri, 30 Sep 2016 14:43:26 +0200,
> Subhransu S. Prusty wrote:
> > 
> > From: Ramesh Babu <ramesh.babu@intel.com>
> > 
> > In case of mmap, by default alsa-lib mmaps both control & status data.
> > 
> > If driver subscribes for .appl_ptr_update, driver needs to get
> > notification whenever appl ptr changes. So with control & status mmaped,
> > driver won't get appl ptr notifications.
> > 
> > In alsa-lib IOCTL_SYNC_PTR can be forced using  sync_ptr_ioctl flag in
> > conf But this makes driver behavior dependent on a flag in the conf.
> > 
> > This patch conditionally checks for .appl_ptr_update and returns error
> > when user land asks for mmaping control & status data, thus forcing user
> > to issue IOCTL_SYNC_PTR.
> > 
> > One drawback with this approach is, if .appl_ptr_update is subscribed by
> > driver, the user space looses flexibility to mmap the control & status
> > data.
> 
> Yes, and it can be seen as an obvious regression, so I'm not sure
> whether this condition is the best choice.
> 
> OTOH, I now understand why you need it in this way -- alsa-lib does
> mmap ctrl/status pages at snd_pcm_open() and sync_ptr is used only as
> a fallback.  So, one solution would be to fix alsa-lib side.  Or, if
> we fix the kernel in this way, it would work with old alsa-lib, but it
> has another penalty.  Hmm...

I will check if it can be fixed in alsa-lib side.

Regards,
Subhransu
> 
> 

-- 
