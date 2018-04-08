From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in io_playback_transfer
Date: Sun, 8 Apr 2018 15:09:55 +0200
Message-ID: <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
References: <00000000000014ed1e056928bb60@google.com>
 <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 36C4C266D69
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 15:10:17 +0200 (CEST)
Received: by mail-pf0-f170.google.com with SMTP id q9so4078724pff.1
 for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2018 06:10:17 -0700 (PDT)
In-Reply-To: <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, syzbot <syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 8, 2018 at 2:58 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I manually simplified the reproducer.
>
> It is quite strange that removing unshare() hides this lockup bug.
> Also, explicitly closing by "close()" hides this lockup bug.
> Triggering "fput() from do_exit()" from "different namespace"
> somehow affects this lockup bug?
>
> ----------------------------------------
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <sched.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/soundcard.h>
>
> int main(int argc, char *argv[])
> {
>         const int fd = open("/dev/dsp1", O_RDWR);
>         int frag = (0 << 16) | 0;
>         char buf[48] = { };
>         unshare(CLONE_NEWNS);
>         ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
>         write(fd, buf, sizeof(buf));
>         return 0;
> }
> ----------------------------------------


Takashi has already fixed this. See this thread:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22INFO$3A$20rcu$20detected$20stall$20in$20snd_pcm_oss_write3$20(2)%22%7Csort:date/syzkaller-bugs/D2xWV7WTRDk/sCw_gImmCAAJ

The fix commit includes tag this bug:
Reported-by: syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com
But it's just that it's mentioned in the thread for another bug.
