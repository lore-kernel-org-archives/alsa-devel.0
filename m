From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] mips/ad1843: convert time to jiffies HZ independent
Date: Mon, 15 Jun 2015 18:27:27 +0200
Message-ID: <20150615162727.GB24137@opentech.at>
References: <1434270059-20472-1-git-send-email-hofrat@osadl.org> <s5h4mma5izh.wl-tiwai@suse.de> <20150614171659.GA15401@opentech.at> <s5hpp4xgqsf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hpp4xgqsf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Jun 2015, Takashi Iwai wrote:

> At Sun, 14 Jun 2015 19:16:59 +0200,
> Nicholas Mc Guire wrote:
> > 
> > On Sun, 14 Jun 2015, Takashi Iwai wrote:
> > 
> > > At Sun, 14 Jun 2015 10:20:59 +0200,
> > > Nicholas Mc Guire wrote:
> > > > 
> > > > PI compliance scanning with coccinelle flagged:
> > > > ./sound/mips/ad1843.c:503:2-32: WARNING: 
> > > > 	timeout (5) seems HZ dependent
> > > > 
> > > > This was introduced in 'commit 862c2c0a61c5 ("ALSA: ALSA driver for SGI O2
> > > > audio board")'. schedule_timeout_interruptible() expects a timeout in
> > > > jiffies so the numeric constant makes the effective timeout HZ dependent.
> > > > Simply put it through msecs_to_jiffies() to make it HZ independent.
> > > > 
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > ---
> > > > 
> > > > The loop here is bounded by 500 jiffies and it does not seem reasonable that
> > > > it would loop 10 times faster on HZ=1000 configs over HZ=100 configs. The
> > > > conversion via msecs_to_jiffies(5) ensures that it will loop at most 100
> > > > times for all configs of HZ which seems reasonable (to me) but needs to be
> > > > checked by someone that knows the details of this driver. 
> > > 
> > > Using 5ms looks reasonable for this case.  However,
> > > schedule_timeout_interruptible() isn't.  This is a loop that won't
> > > break.  So, the best would be to replace it with msleep() or its
> > > friends.
> > > 
> > > > Note that the CONFIG_SND_PCM_OSS dependency was not listed in the 
> > > > Depends on: in Kconfig (which it probably should)
> > > 
> > > Why at all?  It has nothing to do with OSS.
> > >
> > the procedure to see the problem I used was
> > (linux-next 20150612)
> > make ip32_defconfig ARCH=mips
> > make menuconfig ARCH=mips
> >   Device Drivers
> >     ...
> >     <M> Sound card support  --->
> >         <M>   Advanced Linux Sound Architecture  --->
> >             [*]   MIPS sound devices  --->
> >                   <M>   SGI O2 Audio
> > 
> > compiling fails with:
> >   MODPOST 95 modules
> > ERROR: "snd_pcm_period_elapsed" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "snd_pcm_set_ops" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "snd_pcm_lib_get_vmalloc_page" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "snd_pcm_lib_ioctl" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "_snd_pcm_lib_alloc_vmalloc_buffer" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "snd_pcm_new" [sound/mips/snd-sgi-o2.ko] undefined!
> > ERROR: "snd_pcm_lib_free_vmalloc_buffer" [sound/mips/snd-sgi-o2.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> > 
> > as the pcm_lib functions depend on SND_PCM I added that - So
> > if I add the below patch the problem goes away and the module 
> > build correclty - not saying that this is the right fix though
> > (did not look into it in more detail yet)
> 
> Yes, this dependency fix is correct, and I queued your patch now.
> But the dependency on CONFIG_SND_PCM_OSS is wrong.
>

Not too suprised I got this wrong - which is also why I did not submit
this patch - but if you took care of it all the better !

> A similar fix is needed for HAL2, and I fixed it, too.
>

thx!
hofrat
 
