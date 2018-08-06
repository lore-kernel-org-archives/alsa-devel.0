From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: Fwd:  ALSA queries
Date: Mon, 6 Aug 2018 18:53:31 +0530
Message-ID: <CALW20Z3PrdQwB2orP3aXx9TqEeh_AKizEC+oPQ8B66FbBSOYEg@mail.gmail.com>
References: <CALW20Z3Bhp6Bhx8qWWcfcF9wcOSGV_V+KC5ct+ovFQ=o2HeoAw@mail.gmail.com>
 <s5h8t5nx5qs.wl-tiwai@suse.de>
 <CALW20Z1YFqnbUE51Wbm38VaNL2Yr4osyMeGJmHrabfQvAY_1VQ@mail.gmail.com>
 <CALW20Z27m4gjzJzL-Jc11SzE70u05oV1uoKdj5T2Gk+ABVD1ig@mail.gmail.com>
 <s5htvo8smce.wl-tiwai@suse.de>
 <CALW20Z08N9pOG6W_FCBSz8DO92ZNTHnRYSY=ausL1tgij9-tOQ@mail.gmail.com>
 <s5hbmafhd3t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 77E04267832
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 15:23:47 +0200 (CEST)
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so8832875qke.4
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2018 06:23:47 -0700 (PDT)
In-Reply-To: <s5hbmafhd3t.wl-tiwai@suse.de>
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

Hello Takashi,

> OK, so you are sure that the function is really called, not only in
> theory, right?  Then the next item to check is the pointer callback.
> The hwptr is updated based on the value returned from this callback.

I'm sure that I'm calling snd_pcm_period_elapsed() function and my
pointer function is given below:

/************************* pointer callback *****************
static snd_pcm_uframes_t uhdc_audio_pcm_pointer(struct
snd_pcm_substream *substream)
{
struct snd_pcm_runtime *runtime = substream->runtime;
uhdc_t3_card_driver *drv = runtime->private_data;
return bytes_to_frames(runtime, drv->buf_pos);
}


Regards,
Chakravarthi Pradeep K


On Mon, Aug 6, 2018 at 6:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 06 Aug 2018 14:29:26 +0200,
> Chakravarthi Pradeep wrote:
> >
> > Hello Takashi,
> >
> > Thanks for your explanation about period and periods.
> >
> > > Erm, I'm no consultant.  Does your driver issue really
> > > snd_pcm_period_elapsed() or not?  You should know that.
> > >
> > > If the problem happens even if the driver really calls
> > > snd_pcm_period_elapsed(), then it's another cause
> >
> > I'm calling  snd_pcm_period_elapsed() in my audio thread
> > snd_pcm_period_elapsed(drv->substream);
> > I'm calling this <snd_pcm_period_elapsed()> function after one frame
> > is copied to from PCIe device. However, hwptr is not updated and no
> > sound in the VLC application.
>
> OK, so you are sure that the function is really called, not only in
> theory, right?  Then the next item to check is the pointer callback.
> The hwptr is updated based on the value returned from this callback.
>
>
> Takashi
>
> >
> > Regards,
> > Chakravarthi Pradeep K
> > On Mon, Aug 6, 2018 at 2:09 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Sun, 05 Aug 2018 20:09:47 +0200,
> > > Chakravarthi Pradeep wrote:
> > > >
> > > > ---------- Forwarded message ---------
> > > > From: Chakravarthi Pradeep <doubleq7@gmail.com>
> > > > Date: Sun 5 Aug, 2018, 14:19
> > > > Subject: Re: [alsa-devel] ALSA queries
> > > > To: <tiwai@suse.de>
> > > >
> > > >
> > > > Hello Takashi,
> > > >
> > > > Thanks for your reply.
> > > >
> > > >  periods_min = the minimal number of periods
> > > >  period_bytes_min = the minimal size of bytes for one period
> > > >  period_bytes_max = the maximal size of bytes for one period
> > > >
> > > >
> > > > periods_min = the minimal number of periods :  what is meaning of
> > > > periods , is it minimal number of interrupts ?
> > >
> > > The "period" in ALSA PCM definition represents the interval time (or
> > > frames) of the periodical interrupts on the ring buffer.  If the irq
> > > is issued for each 256 frames while the ring buffer size is 1024
> > > frames, periods = 1024/256 = 4.  The periods_min defines the minimal
> > > number of periods the hardware may accept.
> > >
> > > > period_bytes_min = the minimal size of bytes for one period : it
> > > > means, minimal size of bytes per interrupt in case of device, Is it
> > > > correct ?
> > >
> > > Correct.
> > >
> > > > what about period_max ?
> > >
> > > The maximal number of periods, the counter-part of periods_min.
> > >
> > >
> > > > It's most likely the ALSA PCM core's safety stop; your driver seem to
> > > > have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> > > > updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> > > > with the own timer.
> > > >
> > > > I'm attaching my driver thread along with this mail. Can you please
> > > > let me know if I have missed something in audio thread. ?. How to make
> > > > sure in driver that, trigger stop should be called only when stop
> > > > command is sent from application.
> > >
> > > Erm, I'm no consultant.  Does your driver issue really
> > > snd_pcm_period_elapsed() or not?  You should know that.
> > >
> > > If the problem happens even if the driver really calls
> > > snd_pcm_period_elapsed(), then it's another cause.
> > >
> > > > I'm getting cut cut cut ... noise along with audio in VLC application.
> > > > Initially for 2 or 4 seconds, cut cut cut noise is not heard in VLC
> > > > application, However after almost after 5 sec ,I can hear cut cut cut
> > > > noise in VLC application. With my analysis, hwptr is getting updated
> > > > properly however I have doubt in app_ptr. I'm attaching the excl sheet
> > > > with hw_ptr,app_ptr and buf_pos values.
> > >
> > > Do the buffer size and period size are set really as expected?
> > > Often the driver misses the fact that PCM core doesn't guarantee the
> > > alignment of buffer size and period size unless specified explicitly
> > > via hw constraints.  That is, as default, it's possible to set a
> > > buffer size 3000 bytes for the period size 64 bytes.  Then the last
> > > period is partial.
> > >
> > > For aligning the period and the buffer sizes, call
> > >         snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> > > in the open callback.
> > >
> > >
> > > Takashi
> > >
> > > >
> > > > How to remove the cut cut cut ... noise in audio ?
> > > >
> > > > Regards,
> > > > Chakravarthi
> > > >
> > > > On Fri, Aug 3, 2018 at 1:05 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Thu, 02 Aug 2018 16:31:13 +0200,
> > > > > Chakravarthi Pradeep wrote:
> > > > > >
> > > > > > I'm working on ALSA driver for PCIe card. My ALSA driver and it's
> > > > > > initializing struct snd_pcm_hardware with below parameter.
> > > > > >
> > > > > > /************************ code  start
> > > > > > ************************************************/
> > > > > > static struct snd_pcm_hardware audio_pcm_hardware = {
> > > > > > .info = (SNDRV_PCM_INFO_INTERLEAVED  | SNDRV_PCM_INFO_MMAP |
> > > > > > SNDRV_PCM_INFO_MMAP_VALID |
> > > > > > SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > > > > > SNDRV_PCM_INFO_RESUME ),
> > > > > > .formats  =       (SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S24_LE),
> > > > > > .rates  = (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> > > > > > SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
> > > > > > .rate_min  = 44100,
> > > > > > .rate_max  = 192000,
> > > > > > .channels_min  = 2,
> > > > > > .channels_max  = 8,
> > > > > > .buffer_bytes_max  = 76800, /*75 kbytes */
> > > > > > .period_bytes_min  = 512,//4410, /* (channel (2) * sample_rate (44100)
> > > > > > * bit width (24)) / (60 * 8)  */
> > > > > > .period_bytes_max  = 16*1024,
> > > > > > .periods_min  = 10,
> > > > > > .periods_max  = 255,
> > > > > >
> > > > > > };
> > > > > > /************************ code  end
> > > > > > ************************************************/
> > > > > >
> > > > > > 1) I did not understand what is significance of periods_min ,
> > > > > > period_bytes_min ,  period_bytes_max and periods_max. Can you please
> > > > > > tell me what is importance of these parameter and what value should be
> > > > > > mentioned according into ALSA.
> > > > >
> > > > > These three defines the values your hardware may accept:
> > > > >  periods_min = the minimal number of periods
> > > > >  period_bytes_min = the minimal size of bytes for one period
> > > > >  period_bytes_max = the maximal size of bytes for one period
> > > > >
> > > > > > 2) snd_pcm_ops trigger callback is getting called in the driver when
> > > > > > application sends "start" command. But ALSA driver is stopping by
> > > > > > itself after one frame is copied to ALSA framework, without waiting
> > > > > > for "stop" command.
> > > > > >
> > > > > > For instance:
> > > > > > In trigger callback , I'm getting these logs after one frame is copied.
> > > > > > Trigger:Start (When Play button is selected/clicked in application,
> > > > > > Start command is sent to ALSA driver)
> > > > > > Dma transfer is completed.
> > > > > > Trigger:Stop. (When Stop button is selected/clicked in application,
> > > > > > Stop command is sent to ALSA driver. But stop button is not clicked in
> > > > > > this case)
> > > > >
> > > > > It's most likely the ALSA PCM core's safety stop; your driver seem to
> > > > > have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> > > > > updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> > > > > with the own timer.
> > > > >
> > > > >
> > > > > Takashi
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks and Regards
> > > > Chakravarthi Pradeep.K
> > > > Ph: 91 9980434900
> > > > [1.2  <text/html; UTF-8 (quoted-printable)>]
> > > >
> > > > static int uhdc_audio_thread(void *data)
> > > > {
> > > >       char *audio_frame = NULL;
> > > >       int count = 0;
> > > >       uhdc_t3_card_driver *drv = (uhdc_t3_card_driver *)data;
> > > >       struct snd_pcm_runtime *runtime = drv->substream->runtime;
> > > >
> > > >
> > > >       audio_frame = kmalloc(MAX_AUDIO_SIZE, GFP_DMA);
> > > >       if(!audio_frame)
> > > >       {
> > > >               return -ENOMEM;
> > > >       }
> > > >       while(1)
> > > >       {
> > > >
> > > >               if (kthread_should_stop())
> > > >               {
> > > >                       dbg_alsa( "###### %s %d\n",__FUNCTION__,__LINE__);
> > > >                       break;
> > > >               }
> > > >               dbg_alsa( "###### Waiting for audio signal %s_%d\n",__FUNCTION__,__LINE__);
> > > >               wait_event_interruptible (audio_interrupt, (atomic_read (&audio_data_ready)));
> > > >               atomic_set (&audio_data_ready, 0);
> > > >               g_count = get_audio_size(g_temp_lro);
> > > >               count = g_count;
> > > >               printk( "######audio signal received and audio size:%d runtime->period_size:%d  %s_%d\n",g_count,runtime->period_size,__func__,__LINE__);
> > > >
> > > >               /* dma read is done here */
> > > >               /* audio_frame contains audio data */
> > > >               memcpy(drv->substream->runtime->dma_area + drv->buf_pos ,audio_frame,count);
> > > >
> > > >               /* update the buf_pos */
> > > >               // here the (auto)increase of buf_pos is handled
> > > >               drv->buf_pos += count;
> > > >               drv->buf_pos %= drv->pcm_buffer_size;
> > > >
> > > >
> > > >               printk("\n\n\n hwptr=%d appl=%d pos=%d\n",
> > > >                       (int)frames_to_bytes(runtime,runtime->status->hw_ptr),(int)frames_to_bytes(runtime, runtime->control->appl_ptr),drv->buf_pos);
> > > >               /* Below line needs to be uncommented for pointer to be updated in the alsa lib */
> > > >               snd_pcm_period_elapsed(drv->substream);
> > > >
> > > >               try_to_freeze();
> > > >
> > > >       }
> > > >
> > > >       kfree(audio_frame);
> > > >       audio_frame = NULL;
> > > >
> > > >       return 0 ;
> > > >
> > > > }
> > > > [3 hwptr_app_ptr_buf_pos_analysis.xlsx <application/vnd.openxmlformats-officedocument.spreadsheetml.sheet (base64)>]
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
