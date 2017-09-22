From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 7/7] sound: core: Avoid using timespec for struct snd_timer_tread
Date: Fri, 22 Sep 2017 11:00:58 +0800
Message-ID: <CAMz4kuKbo5NauhRW_UdSfL4m4q28B4=pcve=EvW5xDpZ_nyjeg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <1091b589bec6317ea686937060c0f9f9db10651a.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a1uPWYMCUnsYfTo3MjcqopYEd1TnrPVqEts=ZiEAFdr8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1uPWYMCUnsYfTo3MjcqopYEd1TnrPVqEts=ZiEAFdr8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21 September 2017 at 21:09, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> +static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
>> +                               unsigned int cmd)
>> +{
>> +       int __user *p = argp;
>> +       int xarg, old_tread;
>> +
>> +       if (tu->timeri) /* too late */
>> +               return -EBUSY;
>> +       if (get_user(xarg, p))
>> +               return -EFAULT;
>> +
>> +       old_tread = tu->tread;
>> +#if __BITS_PER_LONG == 64
>> +       tu->tread = xarg ? 2 : 0;
>> +#ifdef IA32_EMULATION
>> +       tu->tread = xarg ? 3 : 0;
>> +#endif
>> +#else
>> +       if (cmd == SNDRV_TIMER_IOCTL_TREAD64)
>> +               tu->tread = xarg ? 2 : 0;
>> +       else
>> +               tu->tread = xarg ? 1 : 0;
>> +#endif
>
> The 64-bit case looks broken here:
>
> - The tread flag is different for compat and native mode, so you
>    must pass a flag to identify whether you are called from
>    __snd_timer_user_ioctl or from snd_timer_user_ioctl_compat().

I have some confusion here. For 64-bit, we will set tu->tread = 2 no
matter it is native mode or compat mode, only we will set tu->tread =
3 for x86_32 in compat mode, right?
So I think we do not need to identify whether called from native mode
or compat mode.

>
> - On x86, you have to check whether calling user space process uses
>    the i386 or the x32 ABI by checking in_x32_syscall()

Make sense.

-- 
Baolin.wang
Best Regards
