From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: uninterruptible hang in
	snd_seq_oss_writeq_sync
Date: Tue, 1 Mar 2016 16:01:13 +0100
Message-ID: <CACT4Y+Z_j3=vx61_+iveEoVFWFs6TiVT9SeAeiVQVs6mWsrECg@mail.gmail.com>
References: <CACT4Y+Y4kD-aBGj37rf-xBw9bH3GMU6P+MYg4W1e-s-paVD2pg@mail.gmail.com>
 <s5ha8miuuj9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C3ED72614C2
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 16:01:33 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id n186so41191151wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2016 07:01:33 -0800 (PST)
In-Reply-To: <s5ha8miuuj9.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 1, 2016 at 3:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 01 Mar 2016 13:33:27 +0100,
> Dmitry Vyukov wrote:
>>
>> Hello,
>>
>> The following program creates an unkillable process:
> .....
>> The hang stack is:
>>
>> [<ffffffff85309f77>] snd_seq_oss_writeq_sync+0x327/0x790
>> sound/core/seq/oss/seq_oss_writeq.c:121
>
> This is
>         wait_event_interruptible_timeout(q->sync_sleep, ! q->sync_event_put, HZ);
>
> and this should return zero
>         if (signal_pending(current))
>                 /* interrupted - return 0 to finish sync */
>                 q->sync_event_put = 0;
>         if (! q->sync_event_put || q->sync_time >= time)
>                 return 0;
>         return 1;
>
>> [<ffffffff852fa353>] snd_seq_oss_drain_write+0x113/0x160
>
> ... and this loop should break:
>                 while (snd_seq_oss_writeq_sync(dp->writeq))
>                         ;
>
> So, I see no obvious error in the code, so far.
>
> I'm running your test program now with 8 parallel runs, but I couldn't
> reproduce it.  Any other specifics?
>
>
> thanks,
>
> Takashi
