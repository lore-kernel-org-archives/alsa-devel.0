From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: multi-channel playback regression
Date: Thu, 23 Jul 2009 15:22:53 +0800
Message-ID: <20090723072253.GA15878@localhost>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 21484103999
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 09:22:56 +0200 (CEST)
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
> 
> The change affects only the code path for the problematic hardware
> that reports wrong DMA position.  So, if this change regresses, it
> means that the device has been already problematic from the
> beginning...

I caught some messages:


# speaker-test -c8 -twav -D surround71

speaker-test 1.0.16

Playback device is surround71
Stream parameters are 48000Hz, S16_LE, 8 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 16 to 4096
Period size range from 8 to 2048
Using max buffer size 4096
Periods = 4
was set period_size = 1024
was set buffer_size = 4096
 0 - Front Left
^C


% cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 8
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 4096


[  382.621466] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x10
[  382.629314] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x17
[  382.644691] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x3, stream=0x5, channel=2, format=0x17
[  382.656644] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x4, stream=0x5, channel=4, format=0x17
[  382.672593] ALSA sound/pci/hda/hda_codec.c:1080: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=6, format=0x17
[  382.863277] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1, intr_ptr=4096)
[  382.885281] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1064, intr_ptr=4096)
[  382.906399] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2080, intr_ptr=4096)
[  382.927436] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3092, intr_ptr=4096)
[  382.948556] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=12, intr_ptr=4096)
[  382.969675] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  382.991708] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2088, intr_ptr=4096)
[  383.012827] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3104, intr_ptr=4096)
[  383.033863] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=20, intr_ptr=4096)
[  383.054983] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1036, intr_ptr=4096)
[  387.886967] __ratelimit: 226 callbacks suppressed
[  387.889543] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=20, intr_ptr=4096)
[  387.908087] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1036, intr_ptr=4096)
[  387.929206] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2049, intr_ptr=4096)
[  387.951239] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3112, intr_ptr=4096)
[  387.972358] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=32, intr_ptr=4096)
[  387.993561] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1052, intr_ptr=4096)
[  388.014680] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2068, intr_ptr=4096)
[  388.035717] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3080, intr_ptr=4096)
[  388.057584] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=36, intr_ptr=4096)
[  388.078703] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1052, intr_ptr=4096)
[  392.910772] __ratelimit: 226 callbacks suppressed
[  392.913025] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=40, intr_ptr=4096)
[  392.931891] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1056, intr_ptr=4096)
[  392.952846] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2064, intr_ptr=4096)
[  392.974047] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3084, intr_ptr=4096)
[  392.995167] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1, intr_ptr=4096)
[  393.017201] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1064, intr_ptr=4096)
[  393.038320] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2080, intr_ptr=4096)
[  393.059521] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3100, intr_ptr=4096)
[  393.080561] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=16, intr_ptr=4096)
[  393.101761] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1036, intr_ptr=4096)
[  397.933743] __ratelimit: 226 callbacks suppressed
[  397.939240] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=20, intr_ptr=4096)
[  397.954697] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  397.976647] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2084, intr_ptr=4096)
[  397.997600] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3092, intr_ptr=4096)
[  398.018719] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=12, intr_ptr=4096)
[  398.039839] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  398.061788] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=2084, intr_ptr=4096)
[  398.082741] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=3092, intr_ptr=4096)
[  398.103862] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=12, intr_ptr=4096)
[  398.124981] ALSA sound/core/pcm_lib.c:254: PCM: Unexpected hw_pointer value (stream=0, pos=1025, intr_ptr=4096)
[  400.777479] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x2
[  400.786903] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x3
[  400.795795] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x4
[  400.804357] ALSA sound/pci/hda/hda_codec.c:1093: hda_codec_cleanup_stream: NID=0x5

> 
> Takashi
> 
> 
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
