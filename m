From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/7] sound: core: Avoid using timespec for struct snd_pcm_status
Date: Fri, 22 Sep 2017 13:43:16 +0200
Message-ID: <CAK8P3a0Mw+yPCf_SMmoJuAQ-JhrtGxzw0T4-yEK5fYc+P2=dCg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <78aa803db47d99c2bee1a4dc8d426621324785b8.1505973912.git.baolin.wang@linaro.org>
 <s5hlgl7dqqa.wl-tiwai@suse.de> <CAK8P3a1QBpN6KdSYRX-T2H1gGxxoOWJAyPBwgZSaa1gw1LKkKw@mail.gmail.com>
 <s5hfubfdn4h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfubfdn4h.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, dharageswari.r@intel.com, gudishax.kranthikumar@intel.com, guneshwor.o.singh@intel.com, hardik.t.shah@intel.com, jeeja.kp@intel.com, Naveen M <naveen.m@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Fabian Frederick <fabf@skynet.be>, SF Markus Elfring <elfring@users.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, 2017 at 12:49 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 22 Sep 2017 12:14:55 +0200,
> Arnd Bergmann wrote:
>> The kernel uses timespec64 internally, which is defined as
>> "{ s64 tv_sec; long tv_nsec };", so this has the padding
>> in a different place on big-endian architectures, and has a
>> different alignment and size on i386. We plan to introduce
>> a 'struct __kernel_timespec' that is compatible with the
>> __64_BIT_TIME_T version of the user timespec, but that
>> doesn't exist yet.
>>
>> If you prefer, we can probably introduce it now with Baolin's
>> series, I think Deepa was planning to post a patch to add
>> it soon anyway.
>
> Yes, this sounds like a saner solution than defining the own timespec
> at each place individually.  Then we can have better conversion
> macros, too, I suppose.

Thinking about it again, we unfortunately can't use
__kernel_timespec until after all 32-bit architectures have
been converted to use the new syscalls that we still need
to introduce: In the meantime the plan is that '__kernel_timespec'
is an alias for the usual 'timespec' in user space and may still
be 32-bit wide.

I definitely agree that open-coding 'struct { s64 tv_sec;
s64 tv_nsec}' in a dozen locations is not overly helpful.

I suggested a different alternative in my reply to patch 3/7.
Can you have a look at that? The idea would be that we just
flatten all the structures in the ioctl implementation and make
the structure definition very explicit using u32/s32/u64/s64
members with no implied padding or architecture-specific
types.

> And, if we have kernel_timespec (or kernel_timespec64 or such), can
> this deprecate the existing timespec64 usages, too?  I see that
> timespec64 is internal only, so consolidation would be beneficial for
> code simplification.

Our current longterm plan is to only use __kernel_timespec on the
ABI side, where we have to watch out for the tricky conversion of
tv_nsec: Any timespec copied from a 32-bit process into the kernel
must ignore the upper half of the nanoseconds, while copying the
same structure from a 64-bit process must return an error if the
64-bit nanoseconds are larger than 999999999. When copying a
timespec into user space, we have to be careful to zero the upper
half of tv_nsec to avoid leaking uninitialized kernel data.

Inside of the kernel, we can ignore those constraints, so I'd keep
using the timespec64. We certainly don't want to use the 64-bit
nanoseconds field for internal uses on 32-bit kernels, as that
would introduce expensive 64-bit arithmetic in a lot of places
that don't need it.

My hope is also that we can eventually deprecate any use of the
plain 'timespec' in the kernel: all internal users should migrate
to timespec64 (one at a time, so we can properly review the
changes), and the uapi uses should either have the 64-bit
version of __kernel_timespec, or use compat_timespec once
that becomes usable on 32-bit architectures.

        Arnd
