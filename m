From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [RFC PATCH v2 7/7] sound: core: Avoid using timespec
 for struct snd_timer_tread
Date: Fri, 10 Nov 2017 00:20:10 +0100
Message-ID: <CAK8P3a02v9ypuWisK0jktLjoHL3ZTHTxGYDkhCrXnxN8BM8WtQ@mail.gmail.com>
References: <cover.1509612175.git.baolin.wang@linaro.org> <b920cd22144c6136abf0c82df6e2f26deea38cfc.1509612176.git.baolin.wang@linaro.org>
 <s5hvaipxblf.wl-tiwai@suse.de> <CAK8P3a3B_QVJwQGQ5Uf07XzgZ3QBaybq_+K_wNeBH5-h5ThoLg@mail.gmail.com>
 <s5hr2tcy849.wl-tiwai@suse.de> <CAK8P3a39BOUa_2pnHZ6URjv6uKgEtiySEExhE5qEegqfk-CDkg@mail.gmail.com>
 <s5h1sl7e6np.wl-tiwai@suse.de> <CAK8P3a2a2hummJN8AiQmngKm53CArGsWdEESmjovLyz=Qc+uFQ@mail.gmail.com>
 <s5hinejuxtd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hinejuxtd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 9, 2017 at 7:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 09 Nov 2017 18:01:47 +0100,
> Arnd Bergmann wrote:
>>
>> On Thu, Nov 9, 2017 at 5:52 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >
>> > IOW, is there any macro indicating the 64bit user time_t?
>>
>> There is a macro defined by the C library, but so far we have not
>> started relying on it in kernel headers, because there is no guarantee
>> that this symbol is visible before sys/time.h has been included,
>> and there are some cases where it's possible to include a kernel
>> header before sys/time.h.
>>
>> In case of sound/asound.h, that should be no problem since we rely
>> on having seen the definition on 'struct timeval' already today, and
>> that must come from sys/time.h. Then we just need to make sure that
>> all C libraries define the same macro.
>>
>> Are you sure about the switch()/case problem? I thought that worked
>> in C99, the only problem would be using the macro outside of a
>> function, e.g. as initalizer for a variable
>
> Hmm, OK it seems working.
>
> But, honestly speaking, it's too scaring.  I'm OK if it were only in
> the kernel local code.  But it's the API/ABI definition, which is
> referred by user-space...
>
> A more solid condition would be really appreciated.

I understand your concern here and agree it's really ugly. It did take us
many attempts to come up with this trick for other cases, so my initial
reaction would be to use the same thing everywhere since I know
it works,  but we can use #ifdef instead if you prefer that. I think we
can use a single #ifdef variant to cover all cases, but I'd have to think
about the x32 and x86-32 some more here. With this trick, we can
make user space with new glibc use data structures that are compatible
with 64-bit kernels and avoid the additional translation helpers:

enum {
      SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
      SNDRV_PCM_MMAP_OFFSET_CONTROL = 0x81000000,
#if (__BITS_PER_LONG == 64) || !defined(__USE_TIME_BITS64)
      SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
#else
      /* New snd_pcm_mmap_status layout on 32-bit architectures */
      SNDRV_PCM_MMAP_OFFSET_STATUS = 0x82000000,
#endif
};

struct snd_pcm_mmap_status {
        snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XXXX */
        int pad1;                                 /* Needed for 64 bit
alignment */
#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)
        __u64 hw_ptr;                        /* for compatibility with
64-bit layout */
#else
       snd_pcm_uframes_t hw_ptr;   /* RO: hw ptr (0...boundary-1) */
#endif
        struct timespec tstamp;          /* Timestamp */
        snd_pcm_state_t suspended_state; /* RO: suspended stream state */
#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)
        int pad2;
#endif
        struct timespec audio_tstamp;   /* from sample counter or wall clock */
};
#endif

struct snd_pcm_mmap_control {
#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)
       __u64 appl_ptr;     /* RW: appl ptr (0...boundary-1) */
        __u64 avail_min;    /* RW: min available frames for wakeup */
#else
        snd_pcm_uframes_t appl_ptr;     /* RW: appl ptr (0...boundary-1) */
        snd_pcm_uframes_t avail_min;    /* RW: min available frames
for wakeup */
#endif
};

struct snd_pcm_sync_ptr {
        unsigned int flags;
#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)
        __u32 __pad; /* for x86-32 */
#endif
       union {
                struct snd_pcm_mmap_status status;
                unsigned char reserved[64];
        } s;
        union {
                struct snd_pcm_mmap_control control;
                unsigned char reserved[64];
        } c;
};

struct snd_timer_tread {
        int event;
#if (__BITS_PER_LONG == 32) && defined(__USE_TIME_BITS64)
        int __pad0; /* make alignment sane on x86_32 */
#endif
       struct timespec tstamp;
        unsigned int val;
#if (__BITS_PER_LONG == 32) && defined(__USE_TIME_BITS64)
        int __pad1;
#endif
};

/* note: on x32, the number will change with a new glibc, but the
behavior will not */
#if (__BITS_PER_LONG == 32) && defined(__USE_TIME_BITS64)
#define SNDRV_TIMER_IOCTL_TREAD         _IOW('T', 0x62, int)
#else
#define SNDRV_TIMER_IOCTL_TREAD         _IOW('T', 0x02, int)
#endif
