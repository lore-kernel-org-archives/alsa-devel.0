From: Tommi Rantala <tt.rantala@gmail.com>
Subject: Re: snd_seq_timer_open() NULL pointer dereference
Date: Fri, 8 Mar 2013 20:59:11 +0200
Message-ID: <CA+ydwtriiYSkT5fN_VOw4kHodoadgC80dDg4K3iydjaT5c5jAA@mail.gmail.com>
References: <CA+ydwtpxXb2SSpyG9vn7mvvRU6Z+1BhOe5qi+QXf-6+E_iZ3kg@mail.gmail.com>
 <s5h6211lrx3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f54.google.com (mail-vb0-f54.google.com
 [209.85.212.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 13522261740
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 19:59:11 +0100 (CET)
Received: by mail-vb0-f54.google.com with SMTP id l1so771103vba.13
 for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2013 10:59:11 -0800 (PST)
In-Reply-To: <s5h6211lrx3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2013/3/8 Takashi Iwai <tiwai@suse.de>:
> At Thu, 7 Mar 2013 21:59:32 +0200,
> Tommi Rantala wrote:
>>
>> Hello,
>>
>> I'm hitting this while fuzzing the kernel with Trinity:
>
> The patch below fixes a clear bug in the code path.
> Could you check whether it'll fit?
>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq: Fix missing error handling in snd_seq_timer_open()
>
> snd_seq_timer_open() didn't catch the whole error path but let through
> if the timer id is a slave.  This may lead to Oops by accessing the
> uninitialized pointer.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Confirmed, this fixes the bug. Thanks!

Reported-and-tested-by: Tommi Rantala <tt.rantala@gmail.com>

> ---
>  sound/core/seq/seq_timer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
> index 160b1bd..24d44b2 100644
> --- a/sound/core/seq/seq_timer.c
> +++ b/sound/core/seq/seq_timer.c
> @@ -290,10 +290,10 @@ int snd_seq_timer_open(struct snd_seq_queue *q)
>                         tid.device = SNDRV_TIMER_GLOBAL_SYSTEM;
>                         err = snd_timer_open(&t, str, &tid, q->queue);
>                 }
> -               if (err < 0) {
> -                       snd_printk(KERN_ERR "seq fatal error: cannot create timer (%i)\n", err);
> -                       return err;
> -               }
> +       }
> +       if (err < 0) {
> +               snd_printk(KERN_ERR "seq fatal error: cannot create timer (%i)\n", err);
> +               return err;
>         }
>         t->callback = snd_seq_timer_interrupt;
>         t->callback_data = q;
> --
> 1.8.1.4
>
