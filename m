From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: multi-channel playback regression
Date: Fri, 24 Jul 2009 13:32:51 +0800
Message-ID: <20090724053251.GB1550@localhost>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
	<20090723072253.GA15878@localhost> <s5hprbrx3dd.wl%tiwai@suse.de>
	<20090723075620.GA21405@localhost> <s5h7hxzxyj6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 164D9103A44
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 07:32:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7hxzxyj6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 10:30:05PM +0800, Takashi Iwai wrote:
> At Thu, 23 Jul 2009 15:56:20 +0800,
> Wu Fengguang wrote:
> > 
> > On Thu, Jul 23, 2009 at 03:30:54PM +0800, Takashi Iwai wrote:
> > > At Thu, 23 Jul 2009 15:22:53 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > On Thu, Jul 23, 2009 at 03:01:21PM +0800, Takashi Iwai wrote:
> > > > > At Thu, 23 Jul 2009 14:53:45 +0800,
> > > > > Wu Fengguang wrote:
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > When doing multi-channel playback tests on IbexPeak, I found that the
> > > > > > following patch makes the playback enter an infinite loop, repeatedly
> > > > > > playing a range of ~0.5s audio content. (Seems that some buffer
> > > > > > pointer can never advance.)
> > > > > 
> > > > > Could you set 1 to /proc/asound/card0/pcm0p/xrun_debug and give the
> > > > > messages?  Also, please show /proc/.../pcm0p/sub0/hw_params, too.
> > > > > 
> > > > > The change affects only the code path for the problematic hardware
> > > > > that reports wrong DMA position.  So, if this change regresses, it
> > > > > means that the device has been already problematic from the
> > > > > beginning...
> > > > 
> > > > I caught some messages:
> > > 
> > > Is this with the patched (as is on sound git tree) kernel?
> > 
> > Yes, it's unmodified latest git tree.
> > 
> > > What if changing from #if 1 to #if 0?
> > 
> > This makes 8-channel playback work again.
> 
> Mea culpa, that was a bug in my code :<
> 
> The patch below fixes the issue.  Already merged on GIT trees and
> snapshot tarballs.

Yes it works!

Thanks,
Fengguang

> ===
> >From 947ca210f1df7656e19890832cb71fc3bdd88707 Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Thu, 23 Jul 2009 16:21:08 +0200
> Subject: [PATCH] ALSA: pcm - Fix hwptr buffer-size overlap bug
> 
> The fix 79452f0a28aa5a40522c487b42a5fc423647ad98 introduced another
> bug due to the missing offset for the overlapped hwptr.
> When the hwptr goes back to zero, the delta value has to be corrected
> with the buffer size.  Otherwise this causes looping sounds.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_lib.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index d315f72..72cfd47 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -256,7 +256,7 @@ static int snd_pcm_update_hw_ptr_interrupt(struct snd_pcm_substream *substream)
>  			delta = new_hw_ptr - hw_ptr_interrupt;
>  	}
>  	if (delta < 0) {
> -		if (runtime->periods == 1)
> +		if (runtime->periods == 1 || new_hw_ptr < old_hw_ptr)
>  			delta += runtime->buffer_size;
>  		if (delta < 0) {
>  			hw_ptr_error(substream, 
> -- 
> 1.6.3.3
