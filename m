From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/7] sound: core: Avoid using timespec for struct snd_pcm_status
Date: Fri, 22 Sep 2017 12:14:55 +0200
Message-ID: <CAK8P3a1QBpN6KdSYRX-T2H1gGxxoOWJAyPBwgZSaa1gw1LKkKw@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <78aa803db47d99c2bee1a4dc8d426621324785b8.1505973912.git.baolin.wang@linaro.org>
 <s5hlgl7dqqa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlgl7dqqa.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, dharageswari.r@intel.com, gudishax.kranthikumar@intel.com, guneshwor.o.singh@intel.com, hardik.t.shah@intel.com, jeeja.kp@intel.com, Naveen M <naveen.m@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Fabian Frederick <fabf@skynet.be>, SF Markus Elfring <elfring@users.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, 2017 at 11:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 21 Sep 2017 08:18:04 +0200,
> Baolin Wang wrote:
>>
>> The struct snd_pcm_status will use 'timespec' type variables to record
>> timestamp, which is not year 2038 safe on 32bits system.
>>
>> Userspace will use SNDRV_PCM_IOCTL_STATUS and SNDRV_PCM_IOCTL_STATUS_EXT
>> as commands to issue ioctl() to fill the 'snd_pcm_status' structure in
>> userspace. The command number is always defined through _IOR/_IOW/IORW,
>> so when userspace changes the definition of 'struct timespec' to use
>> 64-bit types, the command number also changes.
>>
>> Thus in the kernel, we now need to define two versions of each such ioctl
>> and corresponding ioctl commands to handle 32bit time_t and 64bit time_t
>> in native mode:
>> struct snd_pcm_status32 {
>>       ......
>>       struct { s32 tv_sec; s32 tv_nsec; } trigger_tstamp;
>>       struct { s32 tv_sec; s32 tv_nsec; } tstamp;
>>       ......
>> }
>>
>> struct snd_pcm_status64 {
>>       ......
>>       struct { s64 tv_sec; s64 tv_nsec; } trigger_tstamp;
>>       struct { s64 tv_sec; s64 tv_nsec; } tstamp;
>>       ......
>> }
>
> I'm confused.  It's different from timespec64?  So 32bit user-space
> would need to use a new own-type timespec instead of the standard
> timespec that is compliant with y2038?

It's complicated:

The definition of 'timespec' that user space sees comes from glibc,
and while that currently uses the traditional '{ long tv_sec;
long tv_nsec; }' definition, it will have to change to something like
(still simplified):

#if __32BIT && __64_BIT_TIME_T
typedef long long time_t;
#else
typedef long time_t;
#endif
struct timespec {
        time_t tv_sec;
#if __BIG_ENDIAN && __32BIT && __64_BIT_TIME_T
        unsigned int :32;
#endif
       long tv_nsec;
#if __LITTLE_ENDIAN && __32BIT && __64_BIT_TIME_T
        unsigned int pad;
#endif
} __attribute__((aligned(8)));

which matches the layout that a 64-bit kernel uses, aside
from the nanosecond padding.

The kernel uses timespec64 internally, which is defined as
"{ s64 tv_sec; long tv_nsec };", so this has the padding
in a different place on big-endian architectures, and has a
different alignment and size on i386. We plan to introduce
a 'struct __kernel_timespec' that is compatible with the
__64_BIT_TIME_T version of the user timespec, but that
doesn't exist yet.

If you prefer, we can probably introduce it now with Baolin's
series, I think Deepa was planning to post a patch to add
it soon anyway.

       Arnd
