From: "Ning Zhang" <ning.zhang06@gmail.com>
Subject: Re: Ends up with write error (Ning Zhang)
Date: Wed, 27 Feb 2008 18:15:16 +0800
Message-ID: <48a1cba90802270215n54d3e94j9b6d73f6961c1bf3@mail.gmail.com>
References: <48a1cba90802240218s6ece8c8av1990495bf29351@mail.gmail.com>
	<s5hwsottem1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 58961246C7
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 11:15:18 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2606440wag.8
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 02:15:17 -0800 (PST)
In-Reply-To: <s5hwsottem1.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi and all,

Thanks a lot for your help.

Now I would like to explain my hardware. It's an ARM_based platform and
there is a DSP which takes charge of audio processing. The ARM communicates
with the DSP via a shared-memory. i.e,  the ARM  put  the sound data to the
shared-memory then enable the DSP ,then the DSP can get the data from the
shared-memory and makes sounds. The shared-memory can be treaded as a ring.
The DSP would not stop fetching the data until the ARM disables it. e,g, if
the ARM does not stop the DSP, the DSP will always get data from the
shared-memory for a loop. Of course, the ARM can get the current address of
the processing date via a register, but it is not very accurate.
So I think that my hardware belongs to the devices that needs the explicit
write-loop and block, right?

If I want to use the workqueue, can I take the sound/sh/aica,c as an
example? because I only found that this driver uses the workqueue mechanism.

Because the PCM core works between the device driver and the application, so
I call it meddle-level driver. :-). Now could you please explain the
mechanism of PCM core ?

Thanks a lot.

BRs,
David.




2008/2/25, Takashi Iwai <tiwai@suse.de>:
>
> At Sun, 24 Feb 2008 18:18:34 +0800,
>
> Ning Zhang wrote:
> >
> > Hi all,
> >
> > There is no response so far, maybe I am not clear. So in sum, here are
> the
> > questions:
> > 1. In meddle-level driver, how comes the runtime->control->avail_min? I
> mean
> > which function set the value, and according what to set the value?  Does
> it
> > have some relationship to the hardware configuration in the device
> driver(
> > i.e snd_pcm_hardware )?
>
>
> It's not what you change in the driver code but you refer to.  This is
> a parameter that application sets.
>
>
> > 2. Should I  use the snd_pcm_period_elapsed function even I don't use
> the
> > interrupt mechanism?
>
>
> Yes.  This is independent from the IRQ or whatever.  The driver has to
> notify to the PCM core when the period has been processed.
>
>
> >  If yes, In which callback function should I call
> > it(snd_pcm_period_elapsed)?
>
>
> > 3,Can anybody do me a favor to explain the mechanism of the middle-level
> > driver or give me some hints?
>
>
> It's not sure what do you mean as "the middle-level driver".  Could
> you clarify this as a first step?  Or, explain a bit more about your
> hardware.
>
> In the ALSA framework, the driver needs to have a certain notification
> mechanism.  The PCM callbacks are all passive and invoked from the PCM
> core stuff.  And, the PCM core is driven asynchronously.
>
> My rough guess is that you expect that the copy callback blocks the
> operation until the write completion.  It's actually not.  The copy
> callback is to copy the given data to the hardware buffer as quickly
> as possible and return.  Then, PCM core blocks the operation until
> it's notified via snd_pcm_period_elapsed().
>
> Unfortunately, ALSA PCM core implementation isn't well suited for the
> hardwares that need the explicit write-loop and blocking.  In such a
> case, you need some workarounds, e.g. using workqueue.
>
>
>
> Takashi
>
>
>
> > BRs,
> >
> > David
> >
> >
> >
> > >
> > > ------------------------------
> > >
> > > Message: 7
> > > Date: Wed, 20 Feb 2008 16:30:54 +0800
> > > From: "Ning Zhang" <ning.zhang06@gmail.com>
> > > Subject: [alsa-devel] Ends up with write error
> > > To: alsa-devel <alsa-devel@alsa-project.org>
> > > Message-ID:
> > >         <48a1cba90802200030v65794b96j7c956406fdc0df9c@mail.gmail.com>
> > > Content-Type: text/plain; charset=GB2312
> > >
> > > Hi all,
> > > I am writing a ALSA driver for my ARM 926 platform. The ARM
> communicates
> > > with the DSP by accessing a 128-byte shared memory. I don't use IRQ
> > > mechanism.(In fact, I am not sure the platform has this mechanism)
> > > Here is some code slices:
> > >
> > > static struct snd_pcm_hardware snd_arch_playback_hw = {
> > >
> > >    .info = (SNDRV_PCM_INFO_MMAP |
> > >
> > >             SNDRV_PCM_INFO_INTERLEAVED |
> > >
> > >             SNDRV_PCM_INFO_BLOCK_TRANSFER),
> > >
> > >    .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > >
> > >    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
> > >
> > >              SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> > >
> > >              SNDRV_PCM_RATE_48000),
> > >
> > >    .rate_min = 8000,
> > >
> > >    .rate_max = 48000,
> > >
> > >    .channels_min = 2,
> > >
> > >    .channels_max = 2,
> > >
> > >    .buffer_bytes_max = 128,
> > >
> > >    .period_bytes_min = 2,
> > >
> > >    .period_bytes_max = 128,
> > >
> > >    .periods_min = 1,
> > >
> > >    .periods_max = 64,
> > >
> > > };
> > >
> > >
> > >
> > > static snd_pcm_uframes_t snd_arch_pcm_pointer(struct snd_pcm_substream
> > >
> > >                                                 *substream)
> > >
> > > {    ?
> > >
> > >    /*
> > >
> > >     * get the current hardware pointer
> > >
> > >     */
> > >
> > >    current_ptr = arch_fw_read_dsp_reg(chip, AFE_RWADDR) & AFE_RD_ADDR;
> > >
> > >
> > > return bytes_to_frames(runtime, current_ptr);
> > >
> > > }
> > >
> > > static int snd_arch_pcm_playback_copy(struct snd_pcm_substream
> *substream,
> > >
> > >                                         int channel,
> > >
> > >                                         snd_pcm_uframes_t pos,
> > >
> > >                                         void __user *src,
> > >
> > >                                         snd_pcm_uframes_t count)
> > >
> > > {  ??
> > >
> > >
> > >
> > >    count = frames_to_bytes(runtime, count);
> > >
> > >    pos = frames_to_bytes(runtime, pos);
> > >
> > >    chip->bufpos = pos;
> > >
> > >                ?.
> > >
> > >    spin_lock(chip->reg_lock);
> > >
> > >    if ( count > 0 && count <= MAX_BUF_SIZE ) {
> > >
> > >            if ( copy_from_user(chip->bufptr, src, count) ) {
> > >
> > >                     snd_printk(KERN_ERR "can not copy user data!\n");
> > >
> > >                     return -EFAULT;
> > >
> > >            }
> > >
> > >            if ( arch_fill_rx_buf(chip,
> > >
> > >                                         (signed short*)(chip->bufptr),
> > > count) < 0 ) {
> > >
> > >                     snd_printk(KERN_ERR "fill rx buffer failed!\n");
> > >
> > >                     return -1;
> > >
> > >            }
> > >
> > >              ?????
> > >
> > >    }
> > >            spin_unlock(chip->reg_lock);
> > >
> > >    return 0;
> > >
> > > }
> > >
> > > The problem is my driver can make sounds, but ends up a write
> > > error.  After
> > > much debugging, I think there might be some problem in the
> > > interworking  between
> > > middle-level driver and the device driver.
> > >
> > >            I found the runtime->control->avail_min=32,  and the
> > > runtime->buffer_size and runtime->period_size are both 32. So at first
> > > middle-level driver call snd_pcm_lib_write1 transfers 32 frames(128
> bytes)
> > > to the device driver's copy callback function and trigger
> function.  Then
> > > when middle-level driver wants to transfer another 32 frames, it calls
> the
> > > pointer callback function and gets the position, because at this time
> the
> > > whole bytes has not been processed completely, so the pointer
> function's
> > > return value must less than 32, and the avail must less than
> > > runtime->control_->avail_min, and goes to this flow and ends up a
> write
> > > error.
> > >
> > >
> > >
> _______________________________________________________________________________
> > >
> > > if (((avail < runtime->control->avail_min && size > avail) ||
> > >
> > >                      (size >= runtime->xfer_align && avail <
> > > runtime->xfer_align))) {
> > >
> > >                             ?????...
> > >
> > >                           long tout;
> > >
> > >                           init_waitqueue_entry(&wait, current);
> > >
> > >                           add_wait_queue(&runtime->sleep, &wait);
> > >
> > >                           while (1) {
> > >
> > >                                    if (signal_pending(current)) {
> > >
> > >                                             state = SIGNALED;
> > >
> > >                                             break;
> > >
> > >                                    }
> > >
> >
> >                                    set_current_state(TASK_INTERRUPTIBLE);
> > >
> >
> >                                    snd_pcm_stream_unlock_irq(substream);
> > >
> > >                                    tout = schedule_timeout(10 * HZ);
> > >
> > >                                    snd_pcm_stream_lock_irq(substream);
> > >
> > >                                    if (tout == 0) {
> > >
> > >                                             if (runtime->status->state
> !=
> > > SNDRV_PCM_STATE_PREPARED &&
> > >
> > >                                                 runtime->status->state
> !=
> > > SNDRV_PCM_STATE_PAUSED) {
> > >
> > >                                                      state =
> > > runtime->status->state == SNDRV_PCM_STATE_SUSPENDED ? SUSPENDED :
> EXPIRED;
> > >
> > >                                                      break;
> > >
> > >                                             }
> > >
> > >                                    }
> > >
> > >                                    switch (runtime->status->state) {
> > >
> > >
> > > ????..
> > >
> > >                                    :
> > >
> > >                                             state = ERROR;
> > >
> > >                                             goto _end_loop;
> > >
> > >
> > >
> > >                                    default:
> > >
> > >                                             break;
> > >
> > >                                    }
> > >
> > >                                    avail =
> > > snd_pcm_playback_avail(runtime);
> > >
> > >                                    if (avail >=
> > > runtime->control->avail_min)
> > > {
> > >
> > >                                             state = READY;
> > >
> > >                                             break;
> > >
> > >                                    }
> > >
> > >                           }
> > >
> > >                          _end_loop:
> > >
> > >                           remove_wait_queue(&runtime->sleep, &wait);
> > >
> > >
> > >
> > >                           switch (state) {
> > >
> > >                           ??.
> > >
> > >                           case EXPIRED:
> > >
> > >                                    snd_printd("playback write error
> (DMA
> > > or
> > > IRQ trouble?)\n");
> > >
> > >                                    err = -EIO;
> > >
> > >                                    goto _end_unlock;
> > >
> > >                           ???
> > >
> > >                           }
> > >
> > >                   }
> > >
> > > This code is a  part of  snd_pcm_lib_write1() in sound/core/pcm_lib.c
> > >
> > >   I think that I misunderstood the mechanism of middle-level driver.
> Could
> > > you please correct me?
> > >
> > > What should the pointer callback function return?  What's it  for?
> > >
> > > How comes the runtime->control->avail_min?
> > >
> > > Because I don't use the IRQ, so should I use the
> snd_pcm_period_elapsed
> > > function? And where?
> > >
> > > ALSA Version is 1.0.14rc1 and I use alsa-lib-1.0.15.
> > >
> > > Can someone comment on this and give me some hints to solve this
> > > problem?  Thanks
> > > in advance.
> > >
> > >   BRs,
> > >
> > > David
> > >
> > > ------------------------------
> > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> > >
> > > End of Alsa-devel Digest, Vol 12, Issue 69
> > > ******************************************
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
