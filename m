From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-lib][v1.1.19][pcm][multi plug] multi plug
 stuck in busy loop which caused high cpu loading.
Date: Sat, 27 Jul 2019 11:38:06 +0200
Message-ID: <b2634d02-1f09-fb4e-9674-c7932d0b8bc8@perex.cz>
References: <CAC0dki4GtTUbEBEuVVo0AynfRW13CdAFzc_m6Ss1POq2E3Q7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FA47F802BD
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2019 11:38:08 +0200 (CEST)
In-Reply-To: <CAC0dki4GtTUbEBEuVVo0AynfRW13CdAFzc_m6Ss1POq2E3Q7bQ@mail.gmail.com>
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
To: eleven xiang <eleven.xiang@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 25. 07. 19 v 11:59 eleven xiang napsal(a):
> Dear,
> 
> Currently, for Audio Echo Cancellation process, we combined both mic signal
> and reference signal into one pcm with the multi plug.
> And both the mic and ref signal are hw pcm devices, and they lived in the
> same sound card in driver.
> 
> Here is the issue:
> 
> 1. the master slave pcm device is already for read;
> 2. the second salve pcm is not ready for read, which means no data;
> 3. under this situation, snd_pcm_read_areas function will be stuck in busy
> loop as below:
> 
>         avail = snd_pcm_avail_update(pcm); * // here always return avail=0,
> due to the second salve pcm device wasn't ready*
>         if (avail < 0) {
>             err = avail;
>             goto _end;
>         }
>         if (avail == 0) {
>             if (state == SND_PCM_STATE_DRAINING)
>                 goto _end;
>             if (pcm->mode & SND_PCM_NONBLOCK) {
>                 err = -EAGAIN;
>                 goto _end;
>             }
> 
>             err = snd_pcm_wait(pcm, -1); * // return immediately, due to
> the master slave pcm was ready for read.*
>             if (err < 0)
>                 break;
>             goto _again; *// stuck in busy loop !! again and again until
> the second pcm data was ready !!!*
> 
>         }
> 
> it seemed that the root cause is that the two devices have obvious
> interrupt period gap , and we also found that this issue can be easily
> reproduced on our device under low memory case.
> 
> Currently we monitor this gap and return error to up layer to
> close-and-reopen device to fix this issue.
> So I wonder if there is any good solution ?

I tried to resolve this sync in my latest pcm_multi updates (all are in 1.1.9
already). Could you trace, why snd_pcm_wait() does not really wait for the
slave when avail == 0? There should not be the busy loop. The
snd_pcm_multi_may_wait_for_avail_min() callback should be called inside the
multi plugin.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
