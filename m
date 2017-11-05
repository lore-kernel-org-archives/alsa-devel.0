From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [RFC PATCH v2 7/7] sound: core: Avoid using timespec
 for struct snd_timer_tread
Date: Sun, 5 Nov 2017 14:16:28 +0100
Message-ID: <CAK8P3a3B_QVJwQGQ5Uf07XzgZ3QBaybq_+K_wNeBH5-h5ThoLg@mail.gmail.com>
References: <cover.1509612175.git.baolin.wang@linaro.org> <b920cd22144c6136abf0c82df6e2f26deea38cfc.1509612176.git.baolin.wang@linaro.org>
 <s5hvaipxblf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvaipxblf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 5, 2017 at 11:29 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 02 Nov 2017 12:06:57 +0100,
> Baolin Wang wrote:
>>
>> The struct snd_timer_tread will use 'timespec' type variables to record
>> timestamp, which is not year 2038 safe on 32bits system.
>>
>> Since the struct snd_timer_tread is passed through read() rather than
>> ioctl(), and the read syscall has no command number that lets us pick
>> between the 32-bit or 64-bit version of this structure.
>>
>> Thus we introduced one new command SNDRV_TIMER_IOCTL_TREAD64 and new
>> struct snd_timer_tread64 replacing timespec with s64 type to handle
>> 64bit time_t. Also add one struct compat_snd_timer_tread64_x86_32 to
>> handle 64bit time_t with 32bit alignment. That means we will set
>> tu->tread = TREAD_FORMAT_64BIT when user space has a 64bit time_t,
>> then we will copy to user with struct snd_timer_tread64. For x86_32
>> mode, we will set tu->tread = TREAD_FORMAT_TIME32_X86 to copy
>> struct compat_snd_timer_tread64_x86_32 for user. Otherwise we will
>> use 32bit time_t variables when copying to user.
>
> We should introduce SNDRV_TIMER_IOCTL_USER_PVERSION instead, where
> user-space can tell which protocol version it understands.  If the
> protocol version is higher than some definition, we can assume it's
> 64-bit ready.  The *_USER_PVERSION is issued from alsa-lib side.
> In that way, we can extend the ABI more flexibly.  A similar trick was
> already used in PCM ABI.  (Ditto for control and rawmidi API; we
> should have the same mechanism for all relevant APIs).
>
> Moreover, once when the new protocol is used, we can use the standard
> 64bit monotonic nsecs as a timestamp, so that we don't need to care
> about 32/64bit compatibility.

I think that's fine, we can do that too, but I don't see how we get around
to doing something like Baolin's patch first. Without this, we will get
existing user space code compiling against our kernel headers using a
new glibc release that will inadvertently change the structure layout
on the read file descriptor.

The trick with redefining SNDRV_TIMER_IOCTL_TREAD in that
configuration lets the kernel know what API the user space expects
without requiring source-level changes.

If you want to for all users of SNDRV_TIMER_IOCTL_TREAD to move
to a new interface for y2038-safety, we'd have to redefined the structure
to avoid the libc-provided 'struct timespec' on 32-bit architectures, like:

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 299a822d2c4e..f93cace4cd24 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -801,7 +801,14 @@ enum {

 struct snd_timer_tread {
        int event;
+#if __BITS_PER_LONG == 32
+       struct {
+               __kernel_long_t tv_sec;
+               __kernel_long_t tv_usec;
+       };
+#else
        struct timespec tstamp;
+#endif
        unsigned int val;
 };

This has a somewhat higher risk of breaking existing code (since the type
changes), and it doesn't solve the overflow.

      Arnd
