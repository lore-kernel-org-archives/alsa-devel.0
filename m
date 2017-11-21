From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: KASAN: use-after-free Read in snd_timer_user_info_compat
Date: Tue, 21 Nov 2017 16:30:24 +0100
Message-ID: <CACT4Y+a-eV+pPwUuHskqs6ZKTAKRyYEyQ=gt1Ssujfm0+tozQw@mail.gmail.com>
References: <089e082686ac9b482e055c832617@google.com> <s5h7evegt84.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7evegt84.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <bot+e5f3c9783e7048a74233054febbe9f1bdf54b6da@syzkaller.appspotmail.com>, alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 29, 2017 at 11:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 27 Oct 2017 10:34:01 +0200,
> syzbot wrote:
>>
>> Hello,
>>
>> syzkaller hit the following crash on
>> 33d930e59a98fa10a0db9f56c7fa2f21a4aef9b9
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>>
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>>
>>
>> BUG: KASAN: use-after-free in
>> snd_timer_user_info_compat.isra.6+0x46c/0x480
>> sound/core/timer_compat.c:71
>> Read of size 8 at addr ffff8801d0dd9d00 by task syz-executor0/3342
>
> OK, this is a real bug, and obviously a forgotten code path from the
> previous fixes.  The patch below should address it, but I checked only
> compile-tested, so far.  Let me know if it really works.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: timer: Add missing mutex lock for compat ioctls
>
> The races among ioctl and other operations were protected by the
> commit af368027a49a ("ALSA: timer: Fix race among timer ioctls") and
> later fixes, but one code path was forgotten in the scenario: the
> 32bit compat ioctl.  As syzkaller recently spotted, a very similar
> use-after-free may happen with the combination of compat ioctls.
>
> The fix is simply to apply the same ioctl_lock to the compat_ioctl
> callback, too.
>
> Fixes: af368027a49a ("ALSA: timer: Fix race among timer ioctls")
> Reference: http://lkml.kernel.org/r/089e082686ac9b482e055c832617@google.com
> Reported-by: syzbot <bot+e5f3c9783e7048a74233054febbe9f1bdf54b6da@syzkaller.appspotmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/timer_compat.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
> index 6a437eb66115..59127b6ef39e 100644
> --- a/sound/core/timer_compat.c
> +++ b/sound/core/timer_compat.c
> @@ -133,7 +133,8 @@ enum {
>  #endif /* CONFIG_X86_X32 */
>  };
>
> -static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
> +static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
> +                                         unsigned long arg)
>  {
>         void __user *argp = compat_ptr(arg);
>
> @@ -153,7 +154,7 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
>         case SNDRV_TIMER_IOCTL_PAUSE:
>         case SNDRV_TIMER_IOCTL_PAUSE_OLD:
>         case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
> -               return snd_timer_user_ioctl(file, cmd, (unsigned long)argp);
> +               return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp);
>         case SNDRV_TIMER_IOCTL_GPARAMS32:
>                 return snd_timer_user_gparams_compat(file, argp);
>         case SNDRV_TIMER_IOCTL_INFO32:
> @@ -167,3 +168,15 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
>         }
>         return -ENOIOCTLCMD;
>  }
> +
> +static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
> +                                       unsigned long arg)
> +{
> +       struct snd_timer_user *tu = file->private_data;
> +       long ret;
> +
> +       mutex_lock(&tu->ioctl_lock);
> +       ret = __snd_timer_user_ioctl_compat(file, cmd, arg);
> +       mutex_unlock(&tu->ioctl_lock);
> +       return ret;
> +}


#syz fix: ALSA: timer: Add missing mutex lock for compat ioctls
