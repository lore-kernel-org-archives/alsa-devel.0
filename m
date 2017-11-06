From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [RFC PATCH v2 7/7] sound: core: Avoid using timespec
 for struct snd_timer_tread
Date: Mon, 6 Nov 2017 17:33:26 +0100
Message-ID: <CAK8P3a39BOUa_2pnHZ6URjv6uKgEtiySEExhE5qEegqfk-CDkg@mail.gmail.com>
References: <cover.1509612175.git.baolin.wang@linaro.org> <b920cd22144c6136abf0c82df6e2f26deea38cfc.1509612176.git.baolin.wang@linaro.org>
 <s5hvaipxblf.wl-tiwai@suse.de> <CAK8P3a3B_QVJwQGQ5Uf07XzgZ3QBaybq_+K_wNeBH5-h5ThoLg@mail.gmail.com>
 <s5hr2tcy849.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr2tcy849.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 5, 2017 at 5:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 05 Nov 2017 14:16:28 +0100,
>> On Sun, Nov 5, 2017 at 11:29 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Thu, 02 Nov 2017 12:06:57 +0100,
>> > We should introduce SNDRV_TIMER_IOCTL_USER_PVERSION instead, where
>> > user-space can tell which protocol version it understands.  If the
>> > protocol version is higher than some definition, we can assume it's
>> > 64-bit ready.  The *_USER_PVERSION is issued from alsa-lib side.
>> > In that way, we can extend the ABI more flexibly.  A similar trick was
>> > already used in PCM ABI.  (Ditto for control and rawmidi API; we
>> > should have the same mechanism for all relevant APIs).
>> >
>> > Moreover, once when the new protocol is used, we can use the standard
>> > 64bit monotonic nsecs as a timestamp, so that we don't need to care
>> > about 32/64bit compatibility.
>>
>> I think that's fine, we can do that too, but I don't see how we get around
>> to doing something like Baolin's patch first. Without this, we will get
>> existing user space code compiling against our kernel headers using a
>> new glibc release that will inadvertently change the structure layout
>> on the read file descriptor.
>
> But it won't work in anyway in multiple ways, e.g. this timer read
> stuff and another the structs embedded in the mmappged page.  If you
> do rebuild things with new glibc, it should tell kernel about the new
> ABI in anyway more or less explicitly.  And if you need it, it means
> that some source-code level API change would be possible.

Right, you mentioned the mmap interface at the kernel summit. This
is certainly the most tricky part and will probably require source-level
changes.

Can you clarify a few things about the mmap() interface?
Is this specifically about "struct snd_pcm_mmap_status" on the
pcm device, or are there others?

>From what I can see, it's already fairly limited:
- on most architectures, it's completely disabled, only x86, ppc and
  alpha allow it to start with, and user space can work around
  the mmap not being available by falling back to ioctl if I read
  the comments correctly
- alpha is not affected since time_t is always 64-bit
- x86 and ppc disable the mmap() in compat mode already because
  of the same issue. If it comes to the worst, we can probably do
  the same for x86-32 and ppc32, disabling the existing status mmap
  for them as well, and change SNDRV_PCM_MMAP_OFFSET_STATUS
  to a new value for 32-bit kernels that exposes the same structure
  as 64-bit kernels.
- I think that since we always use an offset that is defined in the
  header file, we can use the same trick for mmap that we have
  for the ioctl command number:

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c227ccba60ae..bcdbdac097d9 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -306,10 +306,19 @@ typedef int __bitwise snd_pcm_state_t;

 enum {
        SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
-       SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
+       SNDRV_PCM_MMAP_OFFSET_STATUS_OLD = 0x80000000,
        SNDRV_PCM_MMAP_OFFSET_CONTROL = 0x81000000,
+       SNDRV_PCM_MMAP_OFFSET_STATUS64 = 0x82000000,
 };

+#if __BITS_PER_LONG == 64
+#define SNDRV_PCM_MMAP_OFFSET_STATUS SNDRV_PCM_MMAP_OFFSET_STATUS_OLD
+#else
+#define SNDRV_PCM_MMAP_OFFSET_STATUS ((sizeof(time_t) >
sizeof(__kernel_long_t)) ? \
+                                       SNDRV_PCM_MMAP_OFFSET_STATUS64 : \
+                                       SNDRV_PCM_MMAP_OFFSET_STATUS_OLD)
+#endif
+
 union snd_pcm_sync_id {
        unsigned char id[16];
        unsigned short id16[8];

Does that make sense?

> Of course, passing which data type is another question.  Maybe 64bit
> nsecs wouldn't fit all places, and timespec64 style would be still
> required.  But still, the current patch looks still too unnecessarily
> complex to me.  (Yeah I know that the problem is complex, but the code
> can be simpler, I hope!)

I think we can simplify the x86_32 case, but probably not much beyond
that. The trick above however can fix 32-bit compat mode for mmap
if we want to do that.

>> The trick with redefining SNDRV_TIMER_IOCTL_TREAD in that
>> configuration lets the kernel know what API the user space expects
>> without requiring source-level changes.
>
> Right, it works for this case, but not always.
> If jumping the API would give a cleaner way of implementation, I'd
> prefer that over too hackeries, IMO.

Generally speaking I try to avoid being incompatible since that causes
more problems for users when they either fail to build existing source
code, or get silent interface breakage after recompiling against a new
glibc. If the kernel can make it work, that should be the first priority.

>> If you want to for all users of SNDRV_TIMER_IOCTL_TREAD to move
>> to a new interface for y2038-safety, we'd have to redefined the structure
>> to avoid the libc-provided 'struct timespec' on 32-bit architectures, like:
>>
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index 299a822d2c4e..f93cace4cd24 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -801,7 +801,14 @@ enum {
>>
>>  struct snd_timer_tread {
>>         int event;
>> +#if __BITS_PER_LONG == 32
>> +       struct {
>> +               __kernel_long_t tv_sec;
>> +               __kernel_long_t tv_usec;
>> +       };
>> +#else
>>         struct timespec tstamp;
>> +#endif
>>         unsigned int val;
>>  };
>>
>> This has a somewhat higher risk of breaking existing code (since the type
>> changes), and it doesn't solve the overflow.
>
> Hm, how to define the timestamp type is one of the biggest questions
> indeed.  In general, there can't be any guarantee that just rebuilding
> with the 64bit timespec would work for all existing codes.  In theory
> it shouldn't break, but who knows...

Right we can capture most cases then user space gets the kernel
headers from /usr/include/linux and that gets created from a new enough
kernel, or when the ioctl command number is defined in terms of
the variable structure sizes that actually differ. This covers almost all
interfaces, but I've seen some exceptions that will be silently broken
no matter what we do. For all I can see, ALSA ioctls are fine, it's just a lot
of work to get right. The mmap() problem might be fairly easy to solve
in the end, or it may be very hard.

      Arnd
