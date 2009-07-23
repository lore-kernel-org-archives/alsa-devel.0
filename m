From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: multi-channel playback regression
Date: Thu, 23 Jul 2009 15:08:02 +0800
Message-ID: <20090723070802.GA30268@localhost>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D08FC10391E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 09:08:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskgnx4qm.wl%tiwai@suse.de>
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

On Thu, Jul 23, 2009 at 03:01:21PM +0800, Takashi Iwai wrote:
> At Thu, 23 Jul 2009 14:53:45 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Takashi,
> > 
> > When doing multi-channel playback tests on IbexPeak, I found that the
> > following patch makes the playback enter an infinite loop, repeatedly
> > playing a range of ~0.5s audio content. (Seems that some buffer
> > pointer can never advance.)
> 
> Could you set 1 to /proc/asound/card0/pcm0p/xrun_debug and give the
> messages?  Also, please show /proc/.../pcm0p/sub0/hw_params, too.

echo 1 > /proc/asound/card0/pcm0p/xrun_debug
(no error messages, will test it with the patch)

% cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 8
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 4096

> The change affects only the code path for the problematic hardware
> that reports wrong DMA position.  So, if this change regresses, it
> means that the device has been already problematic from the
> beginning...

Very likely.. 

> > 
> > Thanks,
> > Fengguang
> > ---
> > 
> > 79452f0a28aa5a40522c487b42a5fc423647ad98
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Wed Jul 22 12:51:51 2009 +0200
> > 
> >     ALSA: pcm - Fix regressions with VMware
> > 
> >     VMware tends to report PCM positions and period updates at utterly
> >     wrong timing.  This screws up the recent PCM core code that tries
> >     to correct the position based on the irq timing.
> > 
> >     Now, when a backward irq position is detected, skip the update
> >     instead of rebasing.  (This is almost the old behavior before
> >     2.6.30.)
> >     
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > index 333e4dd..3b673e2 100644
> > --- a/sound/core/pcm_lib.c
> > +++ b/sound/core/pcm_lib.c
> > @@ -244,18 +244,27 @@ static int snd_pcm_update_hw_ptr_interrupt(struct snd_pcm_substream *substream)
> >                         delta = new_hw_ptr - hw_ptr_interrupt;
> >         }
> >         if (delta < 0) {
> > -               delta += runtime->buffer_size;
> > +               if (runtime->periods == 1)
> > +                       delta += runtime->buffer_size;
> >                 if (delta < 0) {
> >                         hw_ptr_error(substream,
> >                                      "Unexpected hw_pointer value "
> >                                      "(stream=%i, pos=%ld, intr_ptr=%ld)\n",
> >                                      substream->stream, (long)pos,
> >                                      (long)hw_ptr_interrupt);
> > +#if 1
> > +                       /* simply skipping the hwptr update seems more
> > +                        * robust in some cases, e.g. on VMware with
> > +                        * inaccurate timer source
> > +                        */
> > +                       return 0; /* skip this update */
> > +#else                  
> >                         /* rebase to interrupt position */
> >                         hw_base = new_hw_ptr = hw_ptr_interrupt;
> >                         /* align hw_base to buffer_size */
> >                         hw_base -= hw_base % runtime->buffer_size;
> > 
