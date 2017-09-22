From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 7/7] sound: core: Avoid using timespec
	for struct snd_timer_tread
Date: Fri, 22 Sep 2017 16:38:54 +0800
Message-ID: <CAMz4kuKJH5U6gZgfqmpEax385fanCpoDyU5JGq5YD4bPJcz6AA@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org>
 <1091b589bec6317ea686937060c0f9f9db10651a.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a1uPWYMCUnsYfTo3MjcqopYEd1TnrPVqEts=ZiEAFdr8g@mail.gmail.com>
 <CAMz4kuKbo5NauhRW_UdSfL4m4q28B4=pcve=EvW5xDpZ_nyjeg@mail.gmail.com>
 <CAK8P3a1oyUinL5vxuysRQHh7dq2kHyNzsOHb6Mk8MJobXyNgaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id F2C8B26764C
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 10:38:56 +0200 (CEST)
Received: by mail-io0-f174.google.com with SMTP id m103so1467836iod.13
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 01:38:56 -0700 (PDT)
In-Reply-To: <CAK8P3a1oyUinL5vxuysRQHh7dq2kHyNzsOHb6Mk8MJobXyNgaw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, dharageswari.r@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, Takashi Iwai <tiwai@suse.com>, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Deepa Dinamani <deepa.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 22 September 2017 at 15:57, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 22, 2017 at 5:00 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 21 September 2017 at 21:09, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>
>>>> +static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
>>>> +                               unsigned int cmd)
>>>> +{
>>>> +       int __user *p = argp;
>>>> +       int xarg, old_tread;
>>>> +
>>>> +       if (tu->timeri) /* too late */
>>>> +               return -EBUSY;
>>>> +       if (get_user(xarg, p))
>>>> +               return -EFAULT;
>>>> +
>>>> +       old_tread = tu->tread;
>>>> +#if __BITS_PER_LONG == 64
>>>> +       tu->tread = xarg ? 2 : 0;
>>>> +#ifdef IA32_EMULATION
>>>> +       tu->tread = xarg ? 3 : 0;
>>>> +#endif
>>>> +#else
>>>> +       if (cmd == SNDRV_TIMER_IOCTL_TREAD64)
>>>> +               tu->tread = xarg ? 2 : 0;
>>>> +       else
>>>> +               tu->tread = xarg ? 1 : 0;
>>>> +#endif
>>>
>>> The 64-bit case looks broken here:
>>>
>>> - The tread flag is different for compat and native mode, so you
>>>    must pass a flag to identify whether you are called from
>>>    __snd_timer_user_ioctl or from snd_timer_user_ioctl_compat().
>>
>> I have some confusion here. For 64-bit, we will set tu->tread = 2 no
>> matter it is native mode or compat mode, only we will set tu->tread =
>> 3 for x86_32 in compat mode, right?
>> So I think we do not need to identify whether called from native mode
>> or compat mode.
>
> When we have a user space program with 32-bit time_t in compat mode
> (i.e. cmd==SNDRV_TIMER_IOCTL_TREAD) on a 64-bit kernel, we want
> to set tread=1, and that is different from the native mode that wants to
> set tread=2.

I understand your meaning now, thanks for explanation.

>
> For determining whether to use tread=2 or tread=3, we have to check
> both compat mode and x32 mode. This could be done by checking for
> "if (IS_ENABLED(CONFIG_IA32_EMULATION) && in_compat_syscall() &&
> is_x32_task())", but the in_compat_syscall() check can be skipped when
> you know that you were called from .compat_ioct().

OK.

-- 
Baolin.wang
Best Regards
