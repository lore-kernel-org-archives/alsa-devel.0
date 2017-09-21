From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 5/7] sound: core: Avoid using timespec for struct snd_timer_status
Date: Thu, 21 Sep 2017 15:14:28 +0200
Message-ID: <CAK8P3a0dH4c7NhV2FjJVVf39E6G6+bV3Jh75_sHdFqZ2V1X7uQ@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <d706424c9f419d8276be83e53d007c96a8707e29.1505973912.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d706424c9f419d8276be83e53d007c96a8707e29.1505973912.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, fabf@skynet.be, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

>  static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
> @@ -158,12 +151,10 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
>                 return snd_timer_user_gparams_compat(file, argp);
>         case SNDRV_TIMER_IOCTL_INFO32:
>                 return snd_timer_user_info_compat(file, argp);
> -       case SNDRV_TIMER_IOCTL_STATUS32:
> +       case SNDRV_TIMER_IOCTL_STATUS_COMPAT32:
>                 return snd_timer_user_status_compat(file, argp);
> -#ifdef CONFIG_X86_X32
> -       case SNDRV_TIMER_IOCTL_STATUS_X32:
> -               return snd_timer_user_status_x32(file, argp);
> -#endif /* CONFIG_X86_X32 */
> +       case SNDRV_TIMER_IOCTL_STATUS_COMPAT64:
> +               return snd_timer_user_status64(file, argp);
>         }

I think the last line would fail to build since snd_timer_user_status64()
is defined 'static' in a different file.

Also, snd_timer_user_status_compat() seems to be the same as
snd_timer_user_status32(), so I think you can redirect it the same
way as snd_timer_user_status64 after making both functions globally
visible.

      Arnd
