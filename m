From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 3/7] sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
Date: Fri, 22 Sep 2017 14:47:34 +0800
Message-ID: <CAMz4kuK7=+fx+8qJKVxCDOL01UmZeoP8R7iRJg04B0zVmdXp0g@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <6781c7b4e5934ad65e3c5b401c0a1bbd7cb44db6.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a2+A4d7P27v7hn7777zyH1m65_1+DYNA4mUfqTxct9R_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2+A4d7P27v7hn7777zyH1m65_1+DYNA4mUfqTxct9R_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21 September 2017 at 20:50, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wro=
te:
>> The struct snd_pcm_sync_ptr will use 'timespec' type variables to record
>> timestamp, which is not year 2038 safe on 32bits system.
>>
>> Thus we introduced 'struct snd_pcm_sync_ptr32' and 'struct snd_pcm_sync_=
ptr64'
>> to handle 32bit time_t and 64bit time_t in native mode, which replace
>> timespec with s64 type.
>>
>> In compat mode, we renamed or introduced new structures to handle 32bit/=
64bit
>> time_t in compatible mode. The 'struct compat_snd_pcm_sync_ptr32' and
>> snd_pcm_ioctl_sync_ptr_compat() are used to handle 32bit time_t in compa=
t mode.
>> 'struct compat_snd_pcm_sync_ptr64' and snd_pcm_ioctl_sync_ptr_compat64()=
 are used
>> to handle 64bit time_t with 64bit alignment. 'struct compat_snd_pcm_sync=
_ptr64_x86_32'
>> and snd_pcm_ioctl_sync_ptr_compat64_x86_32() are used to handle 64bit ti=
me_t with
>> 32bit alignment.
>>
>> When glibc changes time_t to 64bit, any recompiled program will issue io=
ctl
>> commands that the kernel does not understand without this patch.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  include/sound/pcm.h     |   46 +++++++++-
>>  sound/core/pcm.c        |    6 +-
>>  sound/core/pcm_compat.c |  228 ++++++++++++++++++++++++++++++++++++++--=
-------
>>  sound/core/pcm_lib.c    |    9 +-
>>  sound/core/pcm_native.c |  113 ++++++++++++++++++-----
>>  5 files changed, 329 insertions(+), 73 deletions(-)
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
>> index 114cc29..c253cbf 100644
>> --- a/include/sound/pcm.h
>> +++ b/include/sound/pcm.h
>> @@ -64,6 +64,15 @@ struct snd_pcm_hardware {
>>  struct snd_pcm_audio_tstamp_config; /* definitions further down */
>>  struct snd_pcm_audio_tstamp_report;
>>
>> +struct snd_pcm_mmap_status64 {
>> +       snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_X=
XXX */
>> +       int pad1;                       /* Needed for 64 bit alignment *=
/
>> +       snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) *=
/
>> +       struct { s64 tv_sec; s64 tv_nsec; } tstamp;             /* Times=
tamp */
>> +       snd_pcm_state_t suspended_state; /* RO: suspended stream state *=
/
>> +       struct { s64 tv_sec; s64 tv_nsec; } audio_tstamp;       /* from =
sample counter or wall clock */
>> +};
>
> This looks correct, but there is a subtlety here to note about x86-32
> that we discussed in a previous (private) review. To recall my earlier
> thoughts:
>
> Normal architectures insert 32 bit padding after 'suspended_state',
> and 32-bit architectures (including x32) also after hw_ptr,
> but x86-32 does not. You make that explicit in the compat code,
> this version just relies on the compiler using identical padding
> in user and kernel space. We could make that explicit using
>
> struct snd_pcm_mmap_status64 {
>        snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XXX=
X */
>        int pad1;                       /* Needed for 64 bit alignment */
>        snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
> #if !defined(CONFIG_64BIT) && !defined(CONFIG_X86_32)
>        int pad2;
> #endif
>       struct { s64 tv_sec; s64 tv_nsec; } tstamp;             /* Timestam=
p */
>        snd_pcm_state_t suspended_state; /* RO: suspended stream state */
> #if !defined(CONFIG_X86_32)
>        int pad3;
> #endif
>       struct { s64 tv_sec; s64 tv_nsec; } audio_tstamp;       /* from
> sample counter or wall clock */
> };

I am sorry I did not get you here, why we do not need pad2 and pad3
for x86_32? You missed =E2=80=98#if !defined(CONFIG_64BIT)=E2=80=9C at the =
second #if
condition?

>
> To make it clear that the layout is architecture specific. As a third
> alternative, we could define binary version of the structure explicitly,
> and have handlers for each layout, then call the correct handlers for
> both native and compat mode. This could use e.g.
>
> struct snd_pcm_mmap_status_time32 {
>        u32 state;
>        u32 pad1;
>        u32 hw_ptr;
>        s32 tstamp_sec;
>        s32 tstamp_usec;
>        u32 suspended_state;
>        s32 audio_tstamp_sec;
>        s32 audio_tstamp_usec;
> };
>
> struct snd_pcm_mmap_status_time64 {
>        u32 state;
>        u32 pad1;
>        u32 hw_ptr;
>        u32 pad2;
>        s64 tstamp_sec;
>        s64 tstamp_usec;
>        u32 suspended_state;
>        u32 pad3;
>        s64 audio_tstamp_sec;
>        s64 audio_tstamp_usec;
> };
>
> struct snd_pcm_mmap_status_time64_i386 {
>        u32 state;
>        u32 pad1;
>        u32 hw_ptr;
>        s64 tstamp_sec;
>        s64 tstamp_usec;
>        u32 suspended_state;
>        s64 audio_tstamp_sec;
>        s64 audio_tstamp_usec;
> } __packed __aligned(4);
>
> struct snd_pcm_mmap_status_64bit {
>        u32 state;
>        u32 pad1;
>        u64 hw_ptr;
>        s64 tstamp_sec;
>        s64 tstamp_usec;
>        u32 suspended_state;
>        u32 pad3;
>        s64 audio_tstamp_sec;
>        s64 audio_tstamp_usec;
> };
>
> My personal preference would be the third approach, but I'd like
> to hear from Takashi if he has a preference. The downside of that
> is that it requires the most changes to the existing code.

OK.

>
>> @@ -1459,8 +1468,21 @@ struct snd_pcm_status64 {
>>         unsigned char reserved[52-2*sizeof(struct { s64 tv_sec; s64 tv_n=
sec; })]; /* must be filled with zero */
>>  };
>>
>> +struct snd_pcm_sync_ptr64 {
>> +       unsigned int flags;
>> +       union {
>> +               struct snd_pcm_mmap_status64 status;
>> +               unsigned char reserved[64];
>> +       } s;
>> +       union {
>> +               struct snd_pcm_mmap_control control;
>> +               unsigned char reserved[64];
>> +       } c;
>> +};
>> +
>>  #define SNDRV_PCM_IOCTL_STATUS64       _IOR('A', 0x20, struct snd_pcm_s=
tatus64)
>>  #define SNDRV_PCM_IOCTL_STATUS_EXT64   _IOWR('A', 0x24, struct snd_pcm_=
status64)
>> +#define SNDRV_PCM_IOCTL_SYNC_PTR64     _IOWR('A', 0x23, struct snd_pcm_=
sync_ptr64)
>>
>>  #if __BITS_PER_LONG =3D=3D 32
>>  struct snd_pcm_status32 {
>> @@ -1481,8 +1503,30 @@ struct snd_pcm_status32 {
>>         unsigned char reserved[52-2*sizeof(struct { s32 tv_sec; s32 tv_n=
sec; })]; /* must be filled with zero */
>>  };
>>
>> +struct snd_pcm_mmap_status32 {
>> +       snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_X=
XXX */
>> +       int pad1;                       /* Needed for 64 bit alignment *=
/
>> +       snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) *=
/
>> +       struct { s32 tv_sec; s32 tv_nsec; } tstamp;             /* Times=
tamp */
>> +       snd_pcm_state_t suspended_state; /* RO: suspended stream state *=
/
>> +       struct { s32 tv_sec; s32 tv_nsec; } audio_tstamp;       /* from =
sample counter or wall clock */
>> +};
>> +
>> +struct snd_pcm_sync_ptr32 {
>> +       unsigned int flags;
>> +       union {
>> +               struct snd_pcm_mmap_status32 status;
>> +               unsigned char reserved[64];
>> +       } s;
>> +       union {
>> +               struct snd_pcm_mmap_control control;
>> +               unsigned char reserved[64];
>> +       } c;
>> +};
>> +
>>  #define SNDRV_PCM_IOCTL_STATUS32       _IOR('A', 0x20, struct snd_pcm_s=
tatus32)
>>  #define SNDRV_PCM_IOCTL_STATUS_EXT32   _IOWR('A', 0x24, struct snd_pcm_=
status32)
>> +#define SNDRV_PCM_IOCTL_SYNC_PTR32     _IOWR('A', 0x23, struct snd_pcm_=
sync_ptr32)
>>  #endif
>
> Unfortunately, this approach doesn't quite work in this particular
> case: it depends on snd_pcm_sync_ptr32 and snd_pcm_sync_ptr64
> having different sizes in order to result in distinct command codes
> for SNDRV_PCM_IOCTL_SYNC_PTR64 and
> SNDRV_PCM_IOCTL_SYNC_PTR32.
>
> However, the 64-byte 'reserved' fields mean that the unions are always
> the same size, and only the padding between 'flags' and 's' is different.

Ah, make sense.

>
> Again, I suppose this almost works: 64-bit architectures use only
> one possible layout in the .unlocked_ioctl handler, and on most
> 32-bit architectures the added padding will make the structure 4 bytes
> longer, but not on i386, which now doesn't know whether user
> space passed a snd_pcm_sync_ptr32  or a snd_pcm_sync_ptr64
> structure.
>
> Fixing this will require changing the uapi header file, in one of two
> ways:
>
> a) make the command number conditional:
>
> #if __BITS_PER_LONG =3D=3D 64 || !defined(__i386__)
> #define SNDRV_PCM_IOCTL_SYNC_PTR SNDRV_PCM_IOCTL_SYNC_PTR_OLD
> #else
> #define SNDRV_PCM_IOCTL_SYNC_PTR (sizeof(__kernel_long_t) =3D=3D sizeof(t=
ime_t) \
>      ? SNDRV_PCM_IOCTL_SYNC_PTR_OLD
>      :  SNDRV_PCM_IOCTL_SYNC_PTR_64)
> #endif
>
> b) change the user-visible structure definition to contain the
>     correct explicit padding on all architectures including i386
>
>  struct snd_pcm_mmap_status {
>         snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XX=
XX */
>         int pad1;                       /* Needed for 64 bit alignment */
>         snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
> +      char pad2[sizeof(time_t) - sizeof(snd_pcm_uframes_t)];
>         struct timespec tstamp;         /* Timestamp */
>         snd_pcm_state_t suspended_state; /* RO: suspended stream state */
> +      char pad2[sizeof(time_t) - sizeof(snd_pcm_state_t)];
>         struct timespec audio_tstamp;   /* from sample counter or wall cl=
ock */
>  };
>
>  struct snd_pcm_mmap_control {
>         snd_pcm_uframes_t appl_ptr;     /* RW: appl ptr (0...boundary-1) =
*/
>         snd_pcm_uframes_t avail_min;    /* RW: min available frames
> for wakeup */
>  };
>
>  struct snd_pcm_sync_ptr32 {
>        unsigned int flags;
> +     char __pad[sizeof(time_t) - sizeof(unsigned int)];
>        union {
>                struct snd_pcm_mmap_status status;
>                unsigned char reserved[64];
>        } s;
>        union {
>                struct snd_pcm_mmap_control control;
>                unsigned char reserved[64];
>        } c;
>  };

OK. I will check here again.

>
>> @@ -2995,8 +3058,12 @@ static int snd_pcm_common_ioctl(struct file *file=
,
>>                         return -EFAULT;
>>                 return 0;
>>         }
>> -       case SNDRV_PCM_IOCTL_SYNC_PTR:
>> -               return snd_pcm_sync_ptr(substream, arg);
>> +#if __BITS_PER_LONG =3D=3D 32
>> +       case SNDRV_PCM_IOCTL_SYNC_PTR32:
>> +               return snd_pcm_sync_ptr32(substream, arg);
>> +#endif
>> +       case SNDRV_PCM_IOCTL_SYNC_PTR64:
>> +               return snd_pcm_sync_ptr64(substream, arg);
>>  #ifdef CONFIG_SND_SUPPORT_OLD_API
>>         case SNDRV_PCM_IOCTL_HW_REFINE_OLD:
>>                 return snd_pcm_hw_refine_old_user(substream, arg);
>
> Without either of the two changes, this function should cause
> a build error on i386 since SNDRV_PCM_IOCTL_SYNC_PTR32
> has the same value as SNDRV_PCM_IOCTL_SYNC_PTR64.
>

Yes. Thanks for your useful comments.


--=20
Baolin.wang
Best Regards
