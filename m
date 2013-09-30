From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] ALSA: Reduce delay for a blocking pcm_drain.
Date: Mon, 30 Sep 2013 21:26:01 +0800
Message-ID: <CAN8ccibYW3XaXMSGqGpb5-8aip0OTLyG5pyURjX8KL=RcmaYqQ@mail.gmail.com>
References: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
 <CAN8cciamcg3wqiDV75oZ6dms-aNtN2o-QMWg0n59otibpmfV7A@mail.gmail.com>
 <CAN8ccia8VzuubtiOZETTN5DAm_LjmQdaxqDHQQ6iv8S_NvtSBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B804261A5A
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 15:26:03 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc17so5590019pbc.32
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 06:26:01 -0700 (PDT)
In-Reply-To: <CAN8ccia8VzuubtiOZETTN5DAm_LjmQdaxqDHQQ6iv8S_NvtSBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> This can be worked around in user space as well by using a nonblocking
drain and
> sleeping based on how many samples are queued.  Would that be the right
thing to
> do or is this (or something similar) worth fixing here.
>
> To test this I opened a pcm and set no period wakeups, played a few
samples and
> then called drain, which hung indefinitely.  Using a USB headset with a
> max period size of 128k but only 15ms of the buffer filled, having the
> drain time shorter without losing samples makes a blocking call
> feasible.
>

Do you mean that you tested on a patched version of USB audio driver since
only three drivers support
SNDRV_PCM_INFO_NO_PERIOD_WAKEUP

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound?qt=grep&q=period+wakeup
