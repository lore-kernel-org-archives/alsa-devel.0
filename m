From: "Channaiah Vanitha (RBEI/ECF3)" <Vanitha.Channaiah@in.bosch.com>
Subject: Re: [PATCH v2 4/6] pcm: direct: Round up of
 slave_app_ptr pointer if buffer size is less than 2 period size.
Date: Thu, 16 May 2019 17:40:35 +0000
Message-ID: <fd0cc77803324450b34819774eb9d946@in.bosch.com>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
 <1557901597-19215-5-git-send-email-vanitha.channaiah@in.bosch.com>
 <s5h1s10hzrc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de-out1.bosch-org.com (de-out1.bosch-org.com [139.15.230.186])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B9ECF806E7
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 19:40:39 +0200 (CEST)
In-Reply-To: <s5h1s10hzrc.wl-tiwai@suse.de>
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

Hello Takashi-san,

> It's still not clear to me why this change is made.
> The example mentioned in the above (period_size=96, buffer_size=191) also matches with the condition before the change, so there should be behavior change by the patch.
> IOW, your patch does nothing but modifying the condition to drop the case buffer_size == period_size * 2.  Why this condition can't
> (shouldn't) be a target of the round up?  That needs the clarification in the patch description.


In case of Buffer_size = 2 * period_size, round down of slave_hw_ptr was necessary which otherwise leads to
Blocking of snd_pcm_wait() for longer time(i.e. more than 1n period)
An example of capture case is explained here:

Issue occurs in case of round up:

- During the start, slave_hw_ptr = 128
- After round up: slave_app_ptr: 192 slave_hw_ptr: 128
- avail:0 app_ptr:0 hw_ptr:0
- snd_pcm_wait() locks
- new slave hw ptr updated to plugins: new_slave_hw_ptr = 192
- hw_ptr = new_slave_hw_ptr - old_slave_hw_ptr = 192 - 128 = 64
- avail:64 app_ptr:0 hw_ptr:64
- snd_pcm_wait() still blocked --------------------> [issue occurs]
- new slave hw ptr updated to plugins: new_slave_hw_ptr = 288
- avail:160 app_ptr:0 hw_ptr:160(64+96)
- snd_pcm_wait() is released

In case of round down:

- During the start, slave_hw_ptr = 128
- After round up: slave_app_ptr:96 slave_hw_ptr:96
- avail:0 app_ptr:0 hw_ptr:0
- snd_pcm_wait() locks
- new slave hw ptr updated to plugins: new_slave_hw_ptr = 192
- hw_ptr = new_slave_hw_ptr - old_slave_hw_ptr = 192 - 96 = 96
- avail:96 app_ptr:0 hw_ptr:96
- snd_pcm_wait() is released--------------------> [issue does not occurs]
- avail:160 app_ptr:0 hw_ptr:160(64+96)

Also, No other issue is introduced in case of playback scenario.

Best regards,
Vanitha Channaiah
RBEI/ECF3

Tel. +91 80 6136-4436



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
Sent: Wednesday, May 15, 2019 2:16 PM
To: Channaiah Vanitha (RBEI/ECF3) <Vanitha.Channaiah@in.bosch.com>
Cc: alsa-devel@alsa-project.org; Wischer Timo (ADITG/ESS) <twischer@de.adit-jv.com>
Subject: Re: [PATCH v2 4/6] pcm: direct: Round up of slave_app_ptr pointer if buffer size is less than 2 period size.

On Wed, 15 May 2019 08:26:35 +0200,
<vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>> wrote:
>
> From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>>
>
> For buffer size less than two period size, the start position of
> slave_app_ptr is rounded up in order to avoid xruns For e.g.:
> Considering below parameters and its values Period size = 96 Buffer
> size = 191 slave_appl_ptr = slave_hw_ptr = unaligned value
>
> Issue:
> - During the start of the stream, app_ptr = hw_ptr = 0
> - Application writes one period of data in the buffer i.e
>   app_ptr = 96, hw_ptr = 0
> - Now, the avail is just period-1 frames available.
>   avail = hw_ptr + buffer_size - app_ptr = 95
>   i.e. shortage of 1 frame space
> - so application is waiting for the 1frame space to be available.
> - slave_app_ptr and slave_hw_ptr would get updated to lower values
> - This could lead to under run to occur.
>
> Fix:
> If we round Up the slave_app_ptr pointer,
> - During the start of the stream, app_ptr = hw_ptr = 0
> - Application writes one period of data in the buffer i.e
>   app_ptr = 96, hw_ptr = 0
> - Round Up of slave_app_ptr pointer leads to below calculation:
> - slave_app_ptr rounded to 96
> - slave_app_ptr and slave_hw_ptr would get updated to larger value
> nearing to 2 period size
> - avail = greater than period size.
> - Here, there is a lower chance of under run.
>
> Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com<mailto:vanitha.channaiah@in.bosch.com>>
> ---
>  src/pcm/pcm_direct.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c index
> 54d9900..b56da85 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -2043,10 +2043,12 @@ int
> snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
>
>  void snd_pcm_direct_reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t
> *dmix)  {
> -
> +     /* For buffer size less than two period size, the start position
> +      * of slave app ptr is rounded up in order to avoid xruns
> +      */
>       if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
>               (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
> -             pcm->buffer_size <= pcm->period_size * 2))
> +             pcm->buffer_size < pcm->period_size * 2))
>               dmix->slave_appl_ptr =
>                       ((dmix->slave_appl_ptr + dmix->slave_period_size - 1) /
>                       dmix->slave_period_size) * dmix->slave_period_size;

It's still not clear to me why this change is made.

The example mentioned in the above (period_size=96, buffer_size=191) also matches with the condition before the change, so there should be behavior change by the patch.

IOW, your patch does nothing but modifying the condition to drop the case buffer_size == period_size * 2.  Why this condition can't
(shouldn't) be a target of the round up?  That needs the clarification in the patch description.


thanks,

Takashi
