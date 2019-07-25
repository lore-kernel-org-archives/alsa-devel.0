From: eleven xiang <eleven.xiang@gmail.com>
Subject: [alsa-lib][v1.1.19][pcm][multi plug] multi plug stuck
 in busy loop which caused high cpu loading.
Date: Thu, 25 Jul 2019 17:59:42 +0800
Message-ID: <CAC0dki4GtTUbEBEuVVo0AynfRW13CdAFzc_m6Ss1POq2E3Q7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14CDFF8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 11:59:45 +0200 (CEST)
Received: by mail-oi1-x22f.google.com with SMTP id l12so37270212oil.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 02:59:45 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear,

Currently, for Audio Echo Cancellation process, we combined both mic signal
and reference signal into one pcm with the multi plug.
And both the mic and ref signal are hw pcm devices, and they lived in the
same sound card in driver.

Here is the issue:

1. the master slave pcm device is already for read;
2. the second salve pcm is not ready for read, which means no data;
3. under this situation, snd_pcm_read_areas function will be stuck in busy
loop as below:

        avail = snd_pcm_avail_update(pcm); * // here always return avail=0,
due to the second salve pcm device wasn't ready*
        if (avail < 0) {
            err = avail;
            goto _end;
        }
        if (avail == 0) {
            if (state == SND_PCM_STATE_DRAINING)
                goto _end;
            if (pcm->mode & SND_PCM_NONBLOCK) {
                err = -EAGAIN;
                goto _end;
            }

            err = snd_pcm_wait(pcm, -1); * // return immediately, due to
the master slave pcm was ready for read.*
            if (err < 0)
                break;
            goto _again; *// stuck in busy loop !! again and again until
the second pcm data was ready !!!*

        }

it seemed that the root cause is that the two devices have obvious
interrupt period gap , and we also found that this issue can be easily
reproduced on our device under low memory case.

Currently we monitor this gap and return error to up layer to
close-and-reopen device to fix this issue.
So I wonder if there is any good solution ?

Thanks
-- 
BR,

eleven_xiang
