From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock involving snd_hrtimer_callback
Date: Sun, 24 Apr 2016 17:16:32 +0200
Message-ID: <CACT4Y+Y4m5=KGRQLa8qwT5DT52a99ODFk3auPEW+cUheY6OJ4w@mail.gmail.com>
References: <CACT4Y+YsEOFvJVk_AafL+OvOC9_njym7xr-KLQKK3pKRyo8oKQ@mail.gmail.com>
 <s5hpotgqbs5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DF2712604D6
 for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2016 17:16:52 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id v188so71265040wme.1
 for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2016 08:16:52 -0700 (PDT)
In-Reply-To: <s5hpotgqbs5.wl-tiwai@suse.de>
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

On Sat, Apr 23, 2016 at 11:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 23 Apr 2016 15:40:21 +0200,
> Dmitry Vyukov wrote:
>>
>> Hi Takashi,
>>
>> I've incorporated your hrtimer fixes (but also updated to
>> ddce192106e4f984123884f8e878f66ace94b573) and now I am seeing lots of
>> the following deadlock messages:
>>
>>
>> [ INFO: possible circular locking dependency detected ]
>> 4.6.0-rc4+ #351 Not tainted
>> -------------------------------------------------------
>> swapper/0/0 is trying to acquire lock:
>>  (&(&timer->lock)->rlock){-.-...}, at: [<ffffffff8537a749>]
>> snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701
>>
>> but task is already holding lock:
>>  (&(&stime->lock)->rlock){-.....}, at: [<ffffffff85383d3f>]
>> snd_hrtimer_callback+0x4f/0x2b0 sound/core/hrtimer.c:54
>>
>> which lock already depends on the new lock.
>
> Oh crap, my second patch is buggy, it leads to ABBA lock, indeed.
> The first patch is still OK, as it just adds a new behavior mode.
>
> Could you replace the second patch with the below one?


I've replaced the second path with this one. The deadlocks has gone,
but I've hit these two hangs that look related:

https://gist.githubusercontent.com/dvyukov/805718ea249c49d17ae759d1b0160684/raw/20891f7e87fe9af3967565559d465d296469244b/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/7f397ea4aeb9e35596e0c8053cf35a11/raw/3fc22f24f7bab5941e47bab604f96487b5f1944d/gistfile1.txt
