From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: ALSA queries
Date: Sun, 5 Aug 2018 23:37:06 +0530
Message-ID: <CALW20Z13KPpi8LffUyCDQ16rYkQ0tw7bQ4zOMQ9OgNirrpuYzg@mail.gmail.com>
References: <CALW20Z3Bhp6Bhx8qWWcfcF9wcOSGV_V+KC5ct+ovFQ=o2HeoAw@mail.gmail.com>
 <s5h8t5nx5qs.wl-tiwai@suse.de>
 <CALW20Z1YFqnbUE51Wbm38VaNL2Yr4osyMeGJmHrabfQvAY_1VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D744267365
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 20:08:23 +0200 (CEST)
Received: by mail-qt0-f170.google.com with SMTP id n6-v6so11475967qtl.4
 for <alsa-devel@alsa-project.org>; Sun, 05 Aug 2018 11:08:22 -0700 (PDT)
In-Reply-To: <CALW20Z1YFqnbUE51Wbm38VaNL2Yr4osyMeGJmHrabfQvAY_1VQ@mail.gmail.com>
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

On Sun 5 Aug, 2018, 14:19 Chakravarthi Pradeep, <doubleq7@gmail.com> wrote:

> Hello Takashi,
>
> Thanks for your reply.
>
>  periods_min = the minimal number of periods
>  period_bytes_min = the minimal size of bytes for one period
>  period_bytes_max = the maximal size of bytes for one period
>
>
> periods_min = the minimal number of periods :  what is meaning of
> periods , is it minimal number of interrupts ?
> period_bytes_min = the minimal size of bytes for one period : it
> means, minimal size of bytes per interrupt in case of device, Is it
> correct ?
> what about period_max ?
>
> It's most likely the ALSA PCM core's safety stop; your driver seem to
> have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> with the own timer.
>
> I'm attaching my driver thread along with this mail. Can you please
> let me know if I have missed something in audio thread. ?. How to make
> sure in driver that, trigger stop should be called only when stop
> command is sent from application.
>
> I'm getting cut cut cut ... noise along with audio in VLC application.
> Initially for 2 or 4 seconds, cut cut cut noise is not heard in VLC
> application, However after almost after 5 sec ,I can hear cut cut cut
> noise in VLC application. With my analysis, hwptr is getting updated
> properly however I have doubt in app_ptr. I'm attaching the excl sheet
> with hw_ptr,app_ptr and buf_pos values.
>
> How to remove the cut cut cut ... noise in audio ?
>
> Regards,
> Chakravarthi
>
> On Fri, Aug 3, 2018 at 1:05 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 02 Aug 2018 16:31:13 +0200,
> > Chakravarthi Pradeep wrote:
> > >
> > > I'm working on ALSA driver for PCIe card. My ALSA driver and it's
> > > initializing struct snd_pcm_hardware with below parameter.
> > >
> > > /************************ code  start
> > > ************************************************/
> > > static struct snd_pcm_hardware audio_pcm_hardware = {
> > > .info = (SNDRV_PCM_INFO_INTERLEAVED  | SNDRV_PCM_INFO_MMAP |
> > > SNDRV_PCM_INFO_MMAP_VALID |
> > > SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > > SNDRV_PCM_INFO_RESUME ),
> > > .formats  =       (SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S24_LE),
> > > .rates  = (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> > > SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
> > > .rate_min  = 44100,
> > > .rate_max  = 192000,
> > > .channels_min  = 2,
> > > .channels_max  = 8,
> > > .buffer_bytes_max  = 76800, /*75 kbytes */
> > > .period_bytes_min  = 512,//4410, /* (channel (2) * sample_rate (44100)
> > > * bit width (24)) / (60 * 8)  */
> > > .period_bytes_max  = 16*1024,
> > > .periods_min  = 10,
> > > .periods_max  = 255,
> > >
> > > };
> > > /************************ code  end
> > > ************************************************/
> > >
> > > 1) I did not understand what is significance of periods_min ,
> > > period_bytes_min ,  period_bytes_max and periods_max. Can you please
> > > tell me what is importance of these parameter and what value should be
> > > mentioned according into ALSA.
> >
> > These three defines the values your hardware may accept:
> >  periods_min = the minimal number of periods
> >  period_bytes_min = the minimal size of bytes for one period
> >  period_bytes_max = the maximal size of bytes for one period
> >
> > > 2) snd_pcm_ops trigger callback is getting called in the driver when
> > > application sends "start" command. But ALSA driver is stopping by
> > > itself after one frame is copied to ALSA framework, without waiting
> > > for "stop" command.
> > >
> > > For instance:
> > > In trigger callback , I'm getting these logs after one frame is copied.
> > > Trigger:Start (When Play button is selected/clicked in application,
> > > Start command is sent to ALSA driver)
> > > Dma transfer is completed.
> > > Trigger:Stop. (When Stop button is selected/clicked in application,
> > > Stop command is sent to ALSA driver. But stop button is not clicked in
> > > this case)
> >
> > It's most likely the ALSA PCM core's safety stop; your driver seem to
> > have missed snd_pcm_period_elapsed() calls, so the hwptr isn't
> > updated, resulting in XRUN.  ALSA PCM core checks such XRUN condition
> > with the own timer.
> >
> >
> > Takashi
>
>
>
> --
> Thanks and Regards
> Chakravarthi Pradeep.K
> Ph: 91 9980434900
>
