From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 0/7] Fix year 2038 issue for sound subsystem
Date: Fri, 22 Sep 2017 13:30:04 +0800
Message-ID: <CAMz4ku+HEv_eftg4WMS5rh-O8MBzH8Uc3HuhXgxrdoxr2bh3Eg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <b0390c03-ed0e-b9c1-ba34-5b55df5fabbb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0390c03-ed0e-b9c1-ba34-5b55df5fabbb@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 22 September 2017 at 12:07, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
> Hi,
>
>
> On Sep 21 2017 15:18, Baolin Wang wrote:
>>
>> Since many structures will use timespec type variables to record time
>> stamp
>> in uapi/asound.h, which are not year 2038 safe on 32bit system. This
>> patchset
>> tries to introduce new structures removing timespec type to compatible
>> native
>> mode and compat mode.
>>
>> Moreover this patchset also converts the internal structrures to use
>> timespec64
>> type and related APIs.
>>
>> Baolin Wang (7):
>>    sound: Replace timespec with timespec64
>>    sound: core: Avoid using timespec for struct snd_pcm_status
>>    sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
>>    sound: core: Avoid using timespec for struct snd_rawmidi_status
>>    sound: core: Avoid using timespec for struct snd_timer_status
>>    uapi: sound: Avoid using timespec for struct snd_ctl_elem_value
>>    sound: core: Avoid using timespec for struct snd_timer_tread
>>
>>   include/sound/pcm.h               |  113 ++++++++-
>>   include/sound/timer.h             |    4 +-
>>   include/uapi/sound/asound.h       |   15 +-
>>   sound/core/pcm.c                  |   14 +-
>>   sound/core/pcm_compat.c           |  466
>> +++++++++++++++++++++++++++++--------
>>   sound/core/pcm_lib.c              |   33 +--
>>   sound/core/pcm_native.c           |  227 ++++++++++++++----
>>   sound/core/rawmidi.c              |   74 +++++-
>>   sound/core/rawmidi_compat.c       |   90 +++++--
>>   sound/core/timer.c                |  247 ++++++++++++++++----
>>   sound/core/timer_compat.c         |   25 +-
>>   sound/pci/hda/hda_controller.c    |   10 +-
>>   sound/soc/intel/skylake/skl-pcm.c |    4 +-
>>   13 files changed, 1046 insertions(+), 276 deletions(-)
>
>
> I'm a minor Takashi in this subsystem and not those who you'd like to
> talk about this issue. But I have interests in it and would like to
> assist you, as long as I can do for it.

Thanks a lot.

>
> As a nitpicking, your patchset brings compilation error at
> configurations for x86, and x86-64 with x32 ABI support.
>
>
> ## x86-64 architecture and amd64 ABI support
> CONFIG_64BIT=y
> CONFIG_X86_64=y
>
> Success.
>
>
> ## x86-64 architecture and amd64/x32 ABI support
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86_X32=y
>
> ```
> sound/core/timer_compat.c:124:54: error: array type has incomplete element
> type 'struct snd_timer_status32'
>   SNDRV_TIMER_IOCTL_STATUS32 = _IOW('T', 0x14, struct snd_timer_status32),
> ```
>
> This error comes from a commit 1229cccbefe7 ('sound: core: Avoid using
> timespec for struct snd_timer_status').
>
> ```
> sound/core/pcm_compat.c: In function 'snd_pcm_ioctl_sync_ptr_compat':
> sound/core/pcm_compat.c:623:9: error: assignment from incompatible pointer
> type [-Werror=incompatible-pointer-types]
>   status = runtime->status;
>          ^
> sound/core/pcm_compat.c: In function 'snd_pcm_ioctl_sync_ptr_x32':
> sound/core/pcm_compat.c:711:9: error: assignment from incompatible pointer
> type [-Werror=incompatible-pointer-types]
>   status = runtime->status;
> ```
>
> This error comes from a commit 947c463adc00('sound: core: Avoid using
> timespec
> for struct snd_pcm_status').
>
>
> ## x86 architecture and i386 ABI support
> CONFIG_X86_32=y
>
> ```
> sound/core/pcm_native.c: In function 'snd_pcm_common_ioctl':
> sound/core/pcm_native.c:3065:2: error: duplicate case value
>   case SNDRV_PCM_IOCTL_SYNC_PTR64:
>   ^~~~
> sound/core/pcm_native.c:3062:2: error: previously used here
>   case SNDRV_PCM_IOCTL_SYNC_PTR32:
>
> ```
>
> This error comes from a commit c0513348a7b39 ('sound: core: Avoid using
> timespec for struct snd_pcm_sync_ptr').
>
>
> Your patchset brought conflicts to 'for-next' branch in a repository
> which Iwai-san maintains[1]. I rebased your patchset on a commit
> 729fbfc92a45 ('ALSA: line6: add support for POD HD DESKTOP') which is a HEAD
> of 'for-next' branch and pushed into my repository on github[2].
>
>
> I respect your work for this issue, however it's better to check whether
> your patchset is buildable or not on major configurations before
> posting.

Sorry for the building errors, since I can not build CONFIG_COMPAT
mode on my arm32 platform. But I will try to fix these build errors in
next version. This RFC patchset, I just want to show how to fix the
y2038 issue and to see if it is on the correct way. Sorry for the
building errors again.

>
> I note that at a development period for v4.5 kernel, ALSA developers
> (mainly Iwai-san) fixed x32 ABI compatibility bugs. Then I prepared for
> a rough set of test for ioctl command[3] to check his work. The set will
> partly help your work, I think (but it's really rough).

Ah, thanks.

>
> I need more time for reviewing. At least, this week is for recovery from
> my tough work to rewrite aplay[4].

Understood. Very appreciated for your comments.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> [2] https://github.com/takaswie/sound/tree/topic/year2038-rfc1
> [3] https://github.com/takaswie/alsa-ioctl-test/
> [4] [alsa-devel] [RFCv2][PATCH 00/38] alsa-utils: axfer: rewrite aplay
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/125574.html
>
> Thanks
>
> Takashi Sakamoto



-- 
Baolin.wang
Best Regards
