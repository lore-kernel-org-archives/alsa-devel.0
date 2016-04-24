From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock involving snd_hrtimer_callback
Date: Sun, 24 Apr 2016 19:09:48 +0200
Message-ID: <CACT4Y+ZZP2iNKruWUPmCTWetzH9meuorR7Eh7dOYngtwbCYZhg@mail.gmail.com>
References: <CACT4Y+YsEOFvJVk_AafL+OvOC9_njym7xr-KLQKK3pKRyo8oKQ@mail.gmail.com>
 <s5hpotgqbs5.wl-tiwai@suse.de> <CACT4Y+Y4m5=KGRQLa8qwT5DT52a99ODFk3auPEW+cUheY6OJ4w@mail.gmail.com>
 <s5heg9vq8xf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5heg9vq8xf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, Sasha Levin <sasha.levin@oracle.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 24, 2016 at 6:16 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 24 Apr 2016 17:16:32 +0200,
> Dmitry Vyukov wrote:
>>
>> On Sat, Apr 23, 2016 at 11:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Sat, 23 Apr 2016 15:40:21 +0200,
>> > Dmitry Vyukov wrote:
>> >>
>> >> Hi Takashi,
>> >>
>> >> I've incorporated your hrtimer fixes (but also updated to
>> >> ddce192106e4f984123884f8e878f66ace94b573) and now I am seeing lots of
>> >> the following deadlock messages:
>> >>
>> >>
>> >> [ INFO: possible circular locking dependency detected ]
>> >> 4.6.0-rc4+ #351 Not tainted
>> >> -------------------------------------------------------
>> >> swapper/0/0 is trying to acquire lock:
>> >>  (&(&timer->lock)->rlock){-.-...}, at: [<ffffffff8537a749>]
>> >> snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701
>> >>
>> >> but task is already holding lock:
>> >>  (&(&stime->lock)->rlock){-.....}, at: [<ffffffff85383d3f>]
>> >> snd_hrtimer_callback+0x4f/0x2b0 sound/core/hrtimer.c:54
>> >>
>> >> which lock already depends on the new lock.
>> >
>> > Oh crap, my second patch is buggy, it leads to ABBA lock, indeed.
>> > The first patch is still OK, as it just adds a new behavior mode.
>> >
>> > Could you replace the second patch with the below one?
>>
>>
>> I've replaced the second path with this one. The deadlocks has gone,
>> but I've hit these two hangs that look related:
>>
>> https://gist.githubusercontent.com/dvyukov/805718ea249c49d17ae759d1b0160684/raw/20891f7e87fe9af3967565559d465d296469244b/gistfile1.txt
>> https://gist.githubusercontent.com/dvyukov/7f397ea4aeb9e35596e0c8053cf35a11/raw/3fc22f24f7bab5941e47bab604f96487b5f1944d/gistfile1.txt
>
> Hmm, so it wasn't a good idea to call hrtimer_cancel() in the
> spinlock, in anyway.  Scratch the previous one.
>
> OK, below is the yet revised two patches.  One is the simplified
> version of the patch, and another is to call hrtimer_cancel() in a new
> timer op without spinlock.  Apply these after the first patch
> "ALSA: timer: Allow backend disabling start/stop from handler".

Done. I will let you know if I see any failures.
