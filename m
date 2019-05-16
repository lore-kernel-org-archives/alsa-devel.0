From: "Channaiah Vanitha (RBEI/ECF3)" <Vanitha.Channaiah@in.bosch.com>
Subject: Re: [PATCH v2 6/6] pcm: Update pcm->avail_min with
 needed_slave_avail_min, after reading unaligned frames
Date: Thu, 16 May 2019 17:26:06 +0000
Message-ID: <293476c61233469cbffdd5a7688a8879@in.bosch.com>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
 <1557901597-19215-7-git-send-email-vanitha.channaiah@in.bosch.com>
 <s5hk1erhgx2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de-out1.bosch-org.com (de-out1.bosch-org.com [139.15.230.186])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 022F8F8078F
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 19:26:11 +0200 (CEST)
In-Reply-To: <s5hk1erhgx2.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Wischer Timo (ADITG/ESS)" <twischer@de.adit-jv.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello  Takashi-san,

>  Can we avoid adding such a hack in the core code?
>  Basically the issue is very specific to direct-plugins, so this sort of workaround should be implemented locally there instead.  I guess we can do similar tricks by overriding the calls in the callbacks.

Issue can be seen without direct plugins too with involvement of only hw which reports unaligned hw ptr. As I have explained in below  detailed description:
"Also, this issue can be seen without dsnoop plugin, when HW reports unaligned hw_ptr For e.g. "

Best regards,
Vanitha Channaiah
RBEI/ECF3

Tel. +91 80 6136-4436



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
Sent: Wednesday, May 15, 2019 9:03 PM
To: Channaiah Vanitha (RBEI/ECF3) <Vanitha.Channaiah@in.bosch.com>
Cc: alsa-devel@alsa-project.org; Wischer Timo (ADITG/ESS) <twischer@de.adit-jv.com>
Subject: Re: [PATCH v2 6/6] pcm: Update pcm->avail_min with needed_slave_avail_min, after reading unaligned frames

On Wed, 15 May 2019 08:26:37 +0200,
<vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>> wrote:
>
> From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>>
>
> This Fix was analyzed for below usecase :
>
> alsa configuration:
> pcm.line_in {
>     type dsnoop
>     ipc_key  INT
>     slave {
>         pcm hardware
>       channels 2
>       period_time 8000
>         rate 48000
>         format S16_LE
>     }
>    bindings {
>        0 0
>        1 1
>    }
> }
> pcm.hardware {
>     type hw
>     card "gmd-card"
>     device 0
>     subdevice 0
>     channels 2
>     period_time 2000
>     rate 48000
>     format S16_LE
> }
>
> command:
> $arecord -v -D line_in -r 48000 -c 2 -f S16_LE recordfile.wav Direct
> Snoop PCM Its setup is:
>   stream       : CAPTURE
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 1536
>   period_size  : 384
>   period_time  : 8000
>   tstamp_mode  : NONE
>   tstamp_type  : MONOTONIC
>   period_step  : 1
>   avail_min    : 384
>   period_event : 0
>   start_threshold  : 1
>   stop_threshold   : 1536
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : huge value
> Hardware PCM card 3 'gmd-card' device 0 subdevice 0 Its setup is:
>   stream       : CAPTURE
>   access       : MMAP_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 1536
>   period_size  : 96
>   period_time  : 2000
>   tstamp_mode  : ENABLE
>   tstamp_type  : MONOTONIC
>   period_step  : 1
>   avail_min    : 96
>   period_event : 0
>   start_threshold  : 1
>   stop_threshold   : huge value
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : huge value
>   appl_ptr     : 0
>   hw_ptr       : 576
>
> Here, there are no other plugins apart from Dsnoop.
>
> Issue: After partial read of unaligned frames(not one period frames),
> snd_pcm_wait() would  block for the pcm->avail_min which would result
> in blocking for longer periods i.e more than one period as specified
> by
> pcm->avail_min
>
> For e.g.:
> Slave period size = 0x60
> Client period-size=0x180
> No. of Ticks = 4
> pcm->avail_min = one period size = 0x180
>
> Issue:
> - During the start of streaming, the position of slave hw_ptr returned
>   from the driver is 0x20.
> - avail is 0x20
> - hw_ptr is calculated by new_slave_hw_ptr - old_slave_hw_ptr i.e.
>   0x20 - 0 = 0x20
> - hw_ptr updated to 0x20
> - avail is 0x20
> - app_ptr updated to 0x20
> - Now, avail = 0
> - snd_pcm_wait() waits till avail=0x180 because pcm->avail_min = 0x180
> - After 4 snd_pcm_elapsed(), slave_hw_ptr = 0x180
> - Since app_ptr has updated with 0x20, avail becomes 0x160
>   There is a shortage of 0x20 frames and hence snd_pcm_wait()
>   goes back to wait again.
> - Now, snd_pcm_wait is locked.
> - After another 4 snd_pcm_elapsed() slave_hw_ptr = 0x300
> - avail = 0x2e0
> - snd_pcm_wait() unlocks.
> So, here snd_pcm_wait() is locked for more than 1 period(exactly 2
> periods)
>
> Also, this issue can be seen without dsnoop plugin, when HW reports
> unaligned hw_ptr For e.g.
> period size = 0x60
> pcm->avail_min = 0x60
> - During the start of streaming, the position of slave hw_ptr returned
>   from the driver is 0x20.
> - hw_ptr is calculated by new_slave_hw_ptr - old_slave_hw_ptr i.e.
>   0x20 - 0 = 0x20
> - hw_ptr updated to 0x20
> - avail is 0x20
> - app_ptr updated to 0x20
> - Now, avail = 0
> - snd_pcm_wait() waits till avail=0x60 because pcm->avail_min=0x60
> - After 1 snd_pcm_elapsed(), slave_hw_ptr = 0x60
> - Since app_ptr has updated with 0x20, avail becomes 0x40
>   There is a shortage of 0x20 frames and hence snd_pcm_wait()
>   goes back to wait again.
> - Now, snd_pcm_wait is locked.
> - After another 1 snd_pcm_elapsed(), slave_hw_ptr = 0x120
> - avail = 0xe0
> - snd_pcm_wait() unlocks.
> So, here snd_pcm_wait() is locked for more than 1 period (exactly 2
> periods)
>
> Fix: After reading unaligned frames(not one period frames), set the
> pcm->avail_min to the needed_avail_slave_min frames so that
> snd_pcm_wait() blocks till needed_avail_slave_min available Once
> needed_avail_slave_min frames are read, set back the original
> pcm->avail_min
>
> For ex:
> Slave period size = 0x60
> Client period-size=0x180
> No. of Ticks = 4
> pcm->avail_min = one period size = 0x180
>
> Fix:
> - During the start of streaming, the position of slave_hw_ptr returned
>   from the driver is 0x20.
>   - hw_ptr is calculated by new_slave_hw_ptr - old_slave_hw_ptr
>   i.e. 0x20 - 0 = 0x20
> - hw_ptr updated to 0x20
> - avail is 0x20
> - app_ptr updated to 0x20
> - Now, avail = 0
> - calculate needed_avail_slave_min = 0x160
> - update the needed_avail_slave_min to pcm->avail_min
>   i.e. pcm->avail_min = 0x160
> - snd_pcm_wait() waits till avail=0x160
> - After 4 snd_pcm_elapsed(), slave_hw_ptr = 0x180
> - snd_pcm_wait() unlocks.
> - Once needed_avail_slave_min frames are read, set back the
>   original pcm->avail_min to 0x180
> So, here snd_pcm_wait() is locked for 1 period only.
>
> Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>>
> ---
>  src/pcm/pcm.c       | 21 +++++++++++++++++++++
>  src/pcm/pcm_local.h |  2 ++
>  2 files changed, 23 insertions(+)
>
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c index f0db545..f361eb1
> 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -973,6 +973,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
>               __snd_pcm_unlock(pcm);
>               return err;
>       }
> +     pcm->original_avail_min = pcm->avail_min;
>       __snd_pcm_unlock(pcm);
>       return 0;
>  }
> @@ -7267,6 +7268,17 @@ void snd_pcm_areas_from_bufs(snd_pcm_t *pcm, snd_pcm_channel_area_t *areas,
>       snd_pcm_unlock(pcm);
>  }
>
> +static void snd_pcm_set_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t
> +avail) {
> +     if (avail != pcm->avail_min) {
> +             snd_pcm_sw_params_t swparams;
> +
> +             snd_pcm_sw_params_current(pcm, &swparams);
> +             swparams.avail_min = avail;
> +             _snd_pcm_sw_params_internal(pcm, &swparams);
> +     }
> +}
> +
>  snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_t *areas,
>                                    snd_pcm_uframes_t offset, snd_pcm_uframes_t size,
>                                    snd_pcm_xfer_areas_func_t func) @@ -7274,6 +7286,7 @@
> snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
>       snd_pcm_uframes_t xfer = 0;
>       snd_pcm_sframes_t err = 0;
>       snd_pcm_state_t state;
> +     snd_pcm_uframes_t needed_slave_avail_min = 0;
>
>       if (size == 0)
>               return 0;
> @@ -7332,6 +7345,14 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
>               if (err < 0)
>                       break;
>               frames = err;
> +             pcm->unaligned_frames += frames;
> +             pcm->unaligned_frames %= pcm->period_size;
> +             if (pcm->unaligned_frames) {
> +                     needed_slave_avail_min = pcm->period_size - pcm->unaligned_frames;
> +                     snd_pcm_set_avail_min(pcm, needed_slave_avail_min);
> +             } else {
> +                     snd_pcm_set_avail_min(pcm, pcm->original_avail_min);
> +             }
>               offset += frames;
>               size -= frames;
>               xfer += frames;
> diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h index
> e103f72..3fdffb4 100644
> --- a/src/pcm/pcm_local.h
> +++ b/src/pcm/pcm_local.h
> @@ -210,6 +210,8 @@ struct _snd_pcm {
>       snd_pcm_tstamp_type_t tstamp_type;      /* timestamp type */
>       unsigned int period_step;
>       snd_pcm_uframes_t avail_min;    /* min avail frames for wakeup */
> +     snd_pcm_uframes_t unaligned_frames;
> +     snd_pcm_uframes_t original_avail_min;
>       int period_event;
>       snd_pcm_uframes_t start_threshold;
>       snd_pcm_uframes_t stop_threshold;

Can we avoid adding such a hack in the core code?

Basically the issue is very specific to direct-plugins, so this sort of workaround should be implemented locally there instead.  I guess we can do similar tricks by overriding the calls in the callbacks.


thanks,

Takashi
