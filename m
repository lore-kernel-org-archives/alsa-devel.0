From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 5/7] sound: core: Avoid using timespec
	for struct snd_timer_status
Date: Fri, 22 Sep 2017 10:03:07 +0800
Message-ID: <CAMz4kuL4GOz1105PJvxCmBPinv9cSzji5+Cg=mkXxd+PpUzsGg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org>
 <d706424c9f419d8276be83e53d007c96a8707e29.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a0dH4c7NhV2FjJVVf39E6G6+bV3Jh75_sHdFqZ2V1X7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 860792669F3
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 04:03:08 +0200 (CEST)
Received: by mail-io0-f169.google.com with SMTP id i197so12082ioe.9
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 19:03:08 -0700 (PDT)
In-Reply-To: <CAK8P3a0dH4c7NhV2FjJVVf39E6G6+bV3Jh75_sHdFqZ2V1X7uQ@mail.gmail.com>
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

On 21 September 2017 at 21:14, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>>  static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
>> @@ -158,12 +151,10 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
>>                 return snd_timer_user_gparams_compat(file, argp);
>>         case SNDRV_TIMER_IOCTL_INFO32:
>>                 return snd_timer_user_info_compat(file, argp);
>> -       case SNDRV_TIMER_IOCTL_STATUS32:
>> +       case SNDRV_TIMER_IOCTL_STATUS_COMPAT32:
>>                 return snd_timer_user_status_compat(file, argp);
>> -#ifdef CONFIG_X86_X32
>> -       case SNDRV_TIMER_IOCTL_STATUS_X32:
>> -               return snd_timer_user_status_x32(file, argp);
>> -#endif /* CONFIG_X86_X32 */
>> +       case SNDRV_TIMER_IOCTL_STATUS_COMPAT64:
>> +               return snd_timer_user_status64(file, argp);
>>         }
>
> I think the last line would fail to build since snd_timer_user_status64()
> is defined 'static' in a different file.

I saw the timer_compat.c file will be included into timer.c file, so I
think it will not. (My arm32 platform can not build compat mode, but I
will try again to make sure it can build successfully.)

>
> Also, snd_timer_user_status_compat() seems to be the same as
> snd_timer_user_status32(), so I think you can redirect it the same
> way as snd_timer_user_status64 after making both functions globally
> visible.

OK. Let me check again.

-- 
Baolin.wang
Best Regards
