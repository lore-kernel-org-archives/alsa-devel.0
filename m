From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [RFC PATCH v2 2/7] sound: core: Avoid using timespec
 for struct snd_pcm_status
Date: Sun, 5 Nov 2017 14:48:38 +0100
Message-ID: <CAK8P3a0ifqMW5Fsa7mHcMHXhgc=y9aSZm2jtOSHZL9uFxDULcA@mail.gmail.com>
References: <cover.1509612175.git.baolin.wang@linaro.org> <b5dc1b18ff61f6b8d99aa953fe050353666be293.1509612176.git.baolin.wang@linaro.org>
 <s5hwp35xbvk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwp35xbvk.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 5, 2017 at 11:23 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 02 Nov 2017 12:06:52 +0100,
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
>>
>> Moreover in compat file, we renamed or introduced new structures to handle
>> 32bit/64bit time_t in compatible mode. 'struct compat_snd_pcm_status32' and
>> snd_pcm_status_user_compat() are used to handle 32bit time_t in compat mode.
>> 'struct compat_snd_pcm_status64' and snd_pcm_status_user_compat64() are used
>> to handle 64bit time_t with 64bit alignment. 'struct compat_snd_pcm_status64_x86_32'
>> and snd_pcm_status_user_compat64_x86_32() are used to handle 64bit time_t with
>> 32bit alignment.
>
> Hmm...  I don't get why you need to redefine these in
> include/sound/pcm.h and define even IOCTLs there.  These are the
> things for ABI, no?  If yes, we don't need to have it globally in the
> public header but define/convert them locally.

The problem is that the ABI is currently defined in terms of a mix of data
structures from kernel and glibc. We have to be very careful about changing the
public header files to avoid breaking applications that were built against new
headers but run on old kernels, so we can't just make the time_t fields 64-bit
wide in the header and change the ioctl number for everyone.

The new structure definitions in the internal are representations of
the possible
binary layouts that user space will actually see with the possible combinations
of 32-bit and 64-bit toolchains, the x86-32 quirk (64-bit variables
being misaligned),
the x32 hack (makeing __kernel_long_t 64-bit) and new glibc using 64-bit time_t.

>  And, renaming snd_pcm_status64 allover the places for internal doesn't look good.

Would you prefer adding another distinct type for the kernel-internal structure?
That would probably be cleaner overall, but also complicate the one
case in which
the user-space representation is actually the same as the one in the kernel.
Note that we can't use snd_pcm_status here, because that is based on 'time_t',
which in the kernel has to remain defined as 'long', so we'd still suffer from
the overflow.

One more thing: as we discussed in Prague, I think the additional
compat_snd_pcm_status64_x86_32 structure can be avoided if we
make slight changes to the user-visible definition of snd_pcm_status
that only take effect on x86-32 with a modified libc, i.e.

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 299a822d2c4e..40be757de124 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -447,6 +447,7 @@ enum {

 struct snd_pcm_status {
        snd_pcm_state_t state;          /* stream state */
+       __u8 __pad0[sizeof(time_t) - sizeof(__kernel_long_t)];
        struct timespec trigger_tstamp; /* time when stream was
started/stopped/paused */
        struct timespec tstamp;         /* reference timestamp */
        snd_pcm_uframes_t appl_ptr;     /* appl ptr */

With that change, some of the other changes should get simpler too.

      Arnd
