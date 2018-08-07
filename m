From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: Fwd:  ALSA queries
Date: Tue, 7 Aug 2018 17:29:46 +0530
Message-ID: <CALW20Z2OzysCHqtpbJCnDvQ3hho5kk=fwJF_q-fRVGMVDTGOTQ@mail.gmail.com>
References: <CALW20Z3Bhp6Bhx8qWWcfcF9wcOSGV_V+KC5ct+ovFQ=o2HeoAw@mail.gmail.com>
 <s5h8t5nx5qs.wl-tiwai@suse.de>
 <CALW20Z1YFqnbUE51Wbm38VaNL2Yr4osyMeGJmHrabfQvAY_1VQ@mail.gmail.com>
 <CALW20Z27m4gjzJzL-Jc11SzE70u05oV1uoKdj5T2Gk+ABVD1ig@mail.gmail.com>
 <s5htvo8smce.wl-tiwai@suse.de>
 <CALW20Z08N9pOG6W_FCBSz8DO92ZNTHnRYSY=ausL1tgij9-tOQ@mail.gmail.com>
 <s5hbmafhd3t.wl-tiwai@suse.de>
 <CALW20Z3PrdQwB2orP3aXx9TqEeh_AKizEC+oPQ8B66FbBSOYEg@mail.gmail.com>
 <s5hk1p37h8t.wl-tiwai@suse.de>
 <CALW20Z2_vxVxjT_bCf2fZDPuuAt1hZyOVF+jusm+9YCLc=ppfQ@mail.gmail.com>
 <s5h36vr7bsk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC94267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 14:00:03 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so11132136qkb.10
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2018 05:00:03 -0700 (PDT)
In-Reply-To: <s5h36vr7bsk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

Trigger stop is getting called , because of this hwptr is zero and
pointer call back is not getting called. Below is my log from driver.

[  838.491681] Trigger:Start
[  839.522233] hwptr=0 buf_pos:3456
[  839.522244] buf_pos :3456 bytes_to_frames:864 uhdc_audio_pcm_pointer_253
[  839.522249] Trigger:Stop

In normal scenario, Trigger stop is not getting called and audio was
able to render in the VLC application. Below log for normal scenario,
[  802.785893] Trigger:Start
[  814.288309] hwptr=0 buf_pos:6272
[  814.288323] buf_pos :6272 bytes_to_frames:1568 uhdc_audio_pcm_pointer_253
[  814.288362] buf_pos :6272 bytes_to_frames:1568 uhdc_audio_pcm_pointer_253
[  814.288378] buf_pos :6272 bytes_to_frames:1568 uhdc_audio_pcm_pointer_253
[  814.305079] hwptr=6272 buf_pos:9472
[  814.305091] buf_pos :9472 bytes_to_frames:2368 uhdc_audio_pcm_pointer_253
[  814.321741] hwptr=9472 buf_pos:12672
[  814.321748] buf_pos :12672 bytes_to_frames:3168 uhdc_audio_pcm_pointer_253
[  814.321777] buf_pos :12672 bytes_to_frames:3168 uhdc_audio_pcm_pointer_253
[  814.321785] buf_pos :12672 bytes_to_frames:3168 uhdc_audio_pcm_pointer_253
[  814.338452] hwptr=12672 buf_pos:15872
[  814.338459] buf_pos :15872 bytes_to_frames:3968 uhdc_audio_pcm_pointer_253
[  814.355242] hwptr=15872 buf_pos:19072
[  814.355248] buf_pos :19072 bytes_to_frames:4768 uhdc_audio_pcm_pointer_253
[  814.355288] buf_pos :19072 bytes_to_frames:4768 uhdc_audio_pcm_pointer_253
[  814.355294] buf_pos :19072 bytes_to_frames:4768 uhdc_audio_pcm_pointer_253
[  814.371822] hwptr=19072 buf_pos:22272
...
...
[  830.739031] Trigger:Stop


I can not do rmmod for ALSA driver. If I do sudo rmmod mydriver then it says
"rmmod: ERROR: Module mydriver is in use"

How can I remove mydriver module from linux kernel ?

Regards,
Chakravarthi Pradeep


On Mon, Aug 6, 2018 at 9:00 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 06 Aug 2018 17:24:49 +0200,
> Chakravarthi Pradeep wrote:
> >
> > Hello Takashi,
> >
> > >You confirmed with putting the debug print, etc?
> > Yes, its confirmed.
> >
> > >And drv->buf_pos is the correct position that matches with the
> > >expected hwptr?  Basically there only these two things.
> >
> > If DMA size per interrupt is of 4K bytes then drv->buf_pos is updated
> > with 4K bytes in audio thread. However the same being updated in
> > pointer call back also.
> >
> > From the debug log , sometimes pointer callback is not getting called
> > and hwptr is zero at this point. When hwptr is zero then no audio in
> > VLC application. Why pointer call back is not gettting called ?
>
> If the pointer callback isn't called from snd_pcm_period_elapsed(),
> the only reason would be that the stream isn't in the running state,
> which is already inconsistent for the condition to call
> snd_pcm_period_elapsed().  Otherwise it calls snd_pcm_update_hw_ptr0()
> and there the pointer callback gets called unconditionally.
>
> So, either the measurement is wrong, or the stream is already screwed
> up at the time you call snd_pcm_period_elapsed().
>
> Again, snd_pcm_period_elapsed() itself calls the pointer callback,
> hence the driver must know the exact position at that timing.  If
> you're using a multi threading, make sure that the updated pointer has
> been already propagated at snd_pcm_period_elapsed() is called in
> another thread, for example.
>
>
> Takashi
>
> >
> > Regards,
> > Chakravarthi Pradeep K
> > On Mon, Aug 6, 2018 at 7:02 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Mon, 06 Aug 2018 15:23:31 +0200,
> > > Chakravarthi Pradeep wrote:
> > > >
> > > > Hello Takashi,
> > > >
> > > > > OK, so you are sure that the function is really called, not only in
> > > > > theory, right?  Then the next item to check is the pointer callback.
> > > > > The hwptr is updated based on the value returned from this callback.
> > > >
> > > > I'm sure that I'm calling snd_pcm_period_elapsed() function
> > >
> > > You confirmed with putting the debug print, etc?
> > >
> > > > and my
> > > > pointer function is given below:
> > > >
> > > > /************************* pointer callback *****************
> > > > static snd_pcm_uframes_t uhdc_audio_pcm_pointer(struct
> > > > snd_pcm_substream *substream)
> > > > {
> > > > struct snd_pcm_runtime *runtime = substream->runtime;
> > > > uhdc_t3_card_driver *drv = runtime->private_data;
> > > > return bytes_to_frames(runtime, drv->buf_pos);
> > > > }
> > >
> > > And drv->buf_pos is the correct position that matches with the
> > > expected hwptr?  Basically there only these two things.
> > >
> > >
> > > Takashi
> > >
> > > >
> > > >
> > > > Regards,
> > > > Chakravarthi Pradeep K
> > > >
> > > >
> > > > On Mon, Aug 6, 2018 at 6:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Mon, 06 Aug 2018 14:29:26 +0200,
> > > > > Chakravarthi Pradeep wrote:
> > > > > >
> > > > > > Hello Takashi,
> > > > > >
> > > > > > Thanks for your explanation about period and periods.
> > > > > >
> > > > > > > Erm, I'm no consultant.  Does your driver issue really
> > > > > > > snd_pcm_period_elapsed() or not?  You should know that.
> > > > > > >
> > > > > > > If the problem happens even if the driver really calls
> > > > > > > snd_pcm_period_elapsed(), then it's another cause
> > > > > >
> > > > > > I'm calling  snd_pcm_period_elapsed() in my audio thread
> > > > > > snd_pcm_period_elapsed(drv->substream);
> > > > > > I'm calling this <snd_pcm_period_elapsed()> function after one frame
> > > > > > is copied to from PCIe device. However, hwptr is not updated and no
> > > > > > sound in the VLC application.
> > > > >
> > > > > OK, so you are sure that the function is really called, not only in
> > > > > theory, right?  Then the next item to check is the pointer callback.
> > > > > The hwptr is updated based on the value returned from this callback.
> > > > >
> > > > >
> > > > > Takashi
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Chakravarthi Pradeep K
> > > > > > On Mon, Aug 6, 2018 at 2:09 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > >
> > > > > > > On Sun, 05 Aug 2018 20:09:47 +0200,
> > > > > > > Chakravarthi Pradeep wrote:
> > > > > > > >
> > > > > > > > ---------- Forwarded message ---------
> > > > > > > > From: Chakravarthi Pradeep <doubleq7@gmail.com>
> > > > > > > > Date: Sun 5 Aug, 2018, 14:19
> > > > > > > > Subject: Re: [alsa-devel] ALSA queries
> > > > > > > > To: <tiwai@suse.de>
> > > > > > > >
> > > > > > > >
> > > > > > > > Hello Takashi,
> > > > > > > >
> > > > > > > > Thanks for your reply.
> > > > > > > >
> > > > > > > >  periods_min = the minimal number of periods
> > > > > > > >  period_bytes_min = the minimal size of bytes for one period
> > > > > > > >  period_bytes_max = the maximal size of bytes for one period
> > > > > > > >
> > > > > > > >
> > > > > > > > periods_min = the minimal number of periods :  what is meaning of
> > > > > > > > periods , is it minimal number of interrupts ?
> > > > > > >
> > > > > > > The "period" in ALSA PCM definition represents the interval time (or
> > > > > > > frames) of the periodical interrupts on the ring buffer.  If the irq
> > > > > > > is issued for each 256 frames while the ring buffer size is 1024
> > > > > > > frames, periods = 1024/256 = 4.  The periods_min defines the minimal
> > > > > > > number of periods the hardware may accept.
> > > > > > >
> > > > > > > > period_bytes_min = the minimal size of bytes for one period : it
> > > > > > > > means, minimal size of bytes per interrupt in case of device, Is it
> > > > > > > > correct ?
> > > > > > >
> > > > > > > Correct.
> > > > > > >
> > > > > > > > what about period_max ?
> > > > > > >
> > > > > > > The maximal number of periods, the counter-part of periods_min.
> > > > > > >
> > > > > > >
> > > > > > > > It's most likely the ALSA PCM core's safety stop; your driver seem to
> > > > > > > > have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> > > > > > > > updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> > > > > > > > with the own timer.
> > > > > > > >
> > > > > > > > I'm attaching my driver thread along with this mail. Can you please
> > > > > > > > let me know if I have missed something in audio thread. ?. How to make
> > > > > > > > sure in driver that, trigger stop should be called only when stop
> > > > > > > > command is sent from application.
> > > > > > >
> > > > > > > Erm, I'm no consultant.  Does your driver issue really
> > > > > > > snd_pcm_period_elapsed() or not?  You should know that.
> > > > > > >
> > > > > > > If the problem happens even if the driver really calls
> > > > > > > snd_pcm_period_elapsed(), then it's another cause.
> > > > > > >
> > > > > > > > I'm getting cut cut cut ... noise along with audio in VLC application.
> > > > > > > > Initially for 2 or 4 seconds, cut cut cut noise is not heard in VLC
> > > > > > > > application, However after almost after 5 sec ,I can hear cut cut cut
> > > > > > > > noise in VLC application. With my analysis, hwptr is getting updated
> > > > > > > > properly however I have doubt in app_ptr. I'm attaching the excl sheet
> > > > > > > > with hw_ptr,app_ptr and buf_pos values.
> > > > > > >
> > > > > > > Do the buffer size and period size are set really as expected?
> > > > > > > Often the driver misses the fact that PCM core doesn't guarantee the
> > > > > > > alignment of buffer size and period size unless specified explicitly
> > > > > > > via hw constraints.  That is, as default, it's possible to set a
> > > > > > > buffer size 3000 bytes for the period size 64 bytes.  Then the last
> > > > > > > period is partial.
> > > > > > >
> > > > > > > For aligning the period and the buffer sizes, call
> > > > > > >         snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> > > > > > > in the open callback.
> > > > > > >
> > > > > > >
> > > > > > > Takashi
> > > > > > >
> > > > > > > >
> > > > > > > > How to remove the cut cut cut ... noise in audio ?
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Chakravarthi
> > > > > > > >
> > > > > > > > On Fri, Aug 3, 2018 at 1:05 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, 02 Aug 2018 16:31:13 +0200,
> > > > > > > > > Chakravarthi Pradeep wrote:
> > > > > > > > > >
> > > > > > > > > > I'm working on ALSA driver for PCIe card. My ALSA driver and it's
> > > > > > > > > > initializing struct snd_pcm_hardware with below parameter.
> > > > > > > > > >
> > > > > > > > > > /************************ code  start
> > > > > > > > > > ************************************************/
> > > > > > > > > > static struct snd_pcm_hardware audio_pcm_hardware = {
> > > > > > > > > > .info = (SNDRV_PCM_INFO_INTERLEAVED  | SNDRV_PCM_INFO_MMAP |
> > > > > > > > > > SNDRV_PCM_INFO_MMAP_VALID |
> > > > > > > > > > SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > > > > > > > > > SNDRV_PCM_INFO_RESUME ),
> > > > > > > > > > .formats  =       (SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S24_LE),
> > > > > > > > > > .rates  = (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> > > > > > > > > > SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
> > > > > > > > > > .rate_min  = 44100,
> > > > > > > > > > .rate_max  = 192000,
> > > > > > > > > > .channels_min  = 2,
> > > > > > > > > > .channels_max  = 8,
> > > > > > > > > > .buffer_bytes_max  = 76800, /*75 kbytes */
> > > > > > > > > > .period_bytes_min  = 512,//4410, /* (channel (2) * sample_rate (44100)
> > > > > > > > > > * bit width (24)) / (60 * 8)  */
> > > > > > > > > > .period_bytes_max  = 16*1024,
> > > > > > > > > > .periods_min  = 10,
> > > > > > > > > > .periods_max  = 255,
> > > > > > > > > >
> > > > > > > > > > };
> > > > > > > > > > /************************ code  end
> > > > > > > > > > ************************************************/
> > > > > > > > > >
> > > > > > > > > > 1) I did not understand what is significance of periods_min ,
> > > > > > > > > > period_bytes_min ,  period_bytes_max and periods_max. Can you please
> > > > > > > > > > tell me what is importance of these parameter and what value should be
> > > > > > > > > > mentioned according into ALSA.
> > > > > > > > >
> > > > > > > > > These three defines the values your hardware may accept:
> > > > > > > > >  periods_min = the minimal number of periods
> > > > > > > > >  period_bytes_min = the minimal size of bytes for one period
> > > > > > > > >  period_bytes_max = the maximal size of bytes for one period
> > > > > > > > >
> > > > > > > > > > 2) snd_pcm_ops trigger callback is getting called in the driver when
> > > > > > > > > > application sends "start" command. But ALSA driver is stopping by
> > > > > > > > > > itself after one frame is copied to ALSA framework, without waiting
> > > > > > > > > > for "stop" command.
> > > > > > > > > >
> > > > > > > > > > For instance:
> > > > > > > > > > In trigger callback , I'm getting these logs after one frame is copied.
> > > > > > > > > > Trigger:Start (When Play button is selected/clicked in application,
> > > > > > > > > > Start command is sent to ALSA driver)
> > > > > > > > > > Dma transfer is completed.
> > > > > > > > > > Trigger:Stop. (When Stop button is selected/clicked in application,
> > > > > > > > > > Stop command is sent to ALSA driver. But stop button is not clicked in
> > > > > > > > > > this case)
> > > > > > > > >
> > > > > > > > > It's most likely the ALSA PCM core's safety stop; your driver seem to
> > > > > > > > > have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> > > > > > > > > updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> > > > > > > > > with the own timer.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Takashi
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks and Regards
> > > > > > > > Chakravarthi Pradeep.K
> > > > > > > > Ph: 91 9980434900
> > > > > > > > [1.2  <text/html; UTF-8 (quoted-printable)>]
> > > > > > > >
> > > > > > > > static int uhdc_audio_thread(void *data)
> > > > > > > > {
> > > > > > > >       char *audio_frame = NULL;
> > > > > > > >       int count = 0;
> > > > > > > >       uhdc_t3_card_driver *drv = (uhdc_t3_card_driver *)data;
> > > > > > > >       struct snd_pcm_runtime *runtime = drv->substream->runtime;
> > > > > > > >
> > > > > > > >
> > > > > > > >       audio_frame = kmalloc(MAX_AUDIO_SIZE, GFP_DMA);
> > > > > > > >       if(!audio_frame)
> > > > > > > >       {
> > > > > > > >               return -ENOMEM;
> > > > > > > >       }
> > > > > > > >       while(1)
> > > > > > > >       {
> > > > > > > >
> > > > > > > >               if (kthread_should_stop())
> > > > > > > >               {
> > > > > > > >                       dbg_alsa( "###### %s %d\n",__FUNCTION__,__LINE__);
> > > > > > > >                       break;
> > > > > > > >               }
> > > > > > > >               dbg_alsa( "###### Waiting for audio signal %s_%d\n",__FUNCTION__,__LINE__);
> > > > > > > >               wait_event_interruptible (audio_interrupt, (atomic_read (&audio_data_ready)));
> > > > > > > >               atomic_set (&audio_data_ready, 0);
> > > > > > > >               g_count = get_audio_size(g_temp_lro);
> > > > > > > >               count = g_count;
> > > > > > > >               printk( "######audio signal received and audio size:%d runtime->period_size:%d  %s_%d\n",g_count,runtime->period_size,__func__,__LINE__);
> > > > > > > >
> > > > > > > >               /* dma read is done here */
> > > > > > > >               /* audio_frame contains audio data */
> > > > > > > >               memcpy(drv->substream->runtime->dma_area + drv->buf_pos ,audio_frame,count);
> > > > > > > >
> > > > > > > >               /* update the buf_pos */
> > > > > > > >               // here the (auto)increase of buf_pos is handled
> > > > > > > >               drv->buf_pos += count;
> > > > > > > >               drv->buf_pos %= drv->pcm_buffer_size;
> > > > > > > >
> > > > > > > >
> > > > > > > >               printk("\n\n\n hwptr=%d appl=%d pos=%d\n",
> > > > > > > >                       (int)frames_to_bytes(runtime,runtime->status->hw_ptr),(int)frames_to_bytes(runtime, runtime->control->appl_ptr),drv->buf_pos);
> > > > > > > >               /* Below line needs to be uncommented for pointer to be updated in the alsa lib */
> > > > > > > >               snd_pcm_period_elapsed(drv->substream);
> > > > > > > >
> > > > > > > >               try_to_freeze();
> > > > > > > >
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       kfree(audio_frame);
> > > > > > > >       audio_frame = NULL;
> > > > > > > >
> > > > > > > >       return 0 ;
> > > > > > > >
> > > > > > > > }
> > > > > > > > [3 hwptr_app_ptr_buf_pos_analysis.xlsx <application/vnd.openxmlformats-officedocument.spreadsheetml.sheet (base64)>]
> > > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks and Regards
> > > > > > Chakravarthi Pradeep.K
> > > > > > Ph: 91 9980434900
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks and Regards
> > > > Chakravarthi Pradeep.K
> > > > Ph: 91 9980434900
> > > >
> >
> >
> >
> > --
> > Thanks and Regards
> > Chakravarthi Pradeep.K
> > Ph: 91 9980434900
> >



-- 
Thanks and Regards
Chakravarthi Pradeep.K
Ph: 91 9980434900
