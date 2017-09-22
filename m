From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 3/7] sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
Date: Fri, 22 Sep 2017 10:48:50 +0200
Message-ID: <CAK8P3a1Rw3H5TA6VDB0_vH+vVk57bCGemT1Xw=z03Tbv4Hfm6Q@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <6781c7b4e5934ad65e3c5b401c0a1bbd7cb44db6.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a2+A4d7P27v7hn7777zyH1m65_1+DYNA4mUfqTxct9R_A@mail.gmail.com> <CAMz4kuK7=+fx+8qJKVxCDOL01UmZeoP8R7iRJg04B0zVmdXp0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuK7=+fx+8qJKVxCDOL01UmZeoP8R7iRJg04B0zVmdXp0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, 2017 at 8:47 AM, Baolin Wang <baolin.wang@linaro.org> wrote=
:
> On 21 September 2017 at 20:50, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wr=
ote:
>>> The struct snd_pcm_sync_ptr will use 'timespec' type variables to recor=
d
>>
>> This looks correct, but there is a subtlety here to note about x86-32
>> that we discussed in a previous (private) review. To recall my earlier
>> thoughts:
>>
>> Normal architectures insert 32 bit padding after 'suspended_state',
>> and 32-bit architectures (including x32) also after hw_ptr,
>> but x86-32 does not. You make that explicit in the compat code,
>> this version just relies on the compiler using identical padding
>> in user and kernel space. We could make that explicit using
>>
>> struct snd_pcm_mmap_status64 {
>>        snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XX=
XX */
>>        int pad1;                       /* Needed for 64 bit alignment */
>>        snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
>> #if !defined(CONFIG_64BIT) && !defined(CONFIG_X86_32)
>>        int pad2;
>> #endif
>>       struct { s64 tv_sec; s64 tv_nsec; } tstamp;             /* Timesta=
mp */
>>        snd_pcm_state_t suspended_state; /* RO: suspended stream state */
>> #if !defined(CONFIG_X86_32)
>>        int pad3;
>> #endif
>>       struct { s64 tv_sec; s64 tv_nsec; } audio_tstamp;       /* from
>> sample counter or wall clock */
>> };
>
> I am sorry I did not get you here, why we do not need pad2 and pad3
> for x86_32?

This is again the x86-32 alignment quirk: the structure as defined
in the uapi header does not have padding, and the new s64 fields
have 32-bit alignment on x86, so the compiler does not add implicit
padding in user space.

On all other architectures, the fields do get padded implicitly
in user space, I'm just listing the padding explicitly.

> You missed =E2=80=98#if !defined(CONFIG_64BIT)=E2=80=9C at the second #if
> condition?

No, that was intentional:

snd_pcm_uframes_t is 'unsigned long', so on 64-bit architectures
we have no padding between two 64-bit values (hw_ptr and tstamp),
and on x86-32 we have no padding because both have 32-bit
alignment.

However, snd_pcm_state_t is 'int', which is always 32-bit wide,
so we do have padding on both 32-bit and 64-bit architectures
between syspended_state and audio_tstamp, with the exception
of x86-32.

      Arnd
