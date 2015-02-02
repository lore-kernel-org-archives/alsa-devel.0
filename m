From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 00/10] audio timestamping evolutions
Date: Mon, 02 Feb 2015 09:52:35 -0600
Message-ID: <54CF9D43.1030901@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hsieofud5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 423FA260583
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 16:52:39 +0100 (CET)
In-Reply-To: <s5hsieofud5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review Takashi.

>> The first 4 patches are corrections for misses in the way the system
>> and trigger timestamps are handled, and the last 6 provide the
>> additional audio timestamping selection. A second batch is planned to
>> enable hardware capabilities in a low-level drivers.
>
> Thanks for the patches.  They look almost good to me.  There are a few
> minor coding-style issues, but the implementation details appear good
> enough.

I will resubmit a new patchset for the coding style and true/false 
fixes. ETA end of week.

> I can merge at least the first four patches as an improvement of the
> current code base.  The rest API change needs more reviews.  I'll take
> a closer look at them later, but I think the new API design is almost
> acceptable as is.

You had comments only on patches 2,3 and 4, so I understand that you'd 
merge these four patches after the fixes?
It's fine with me to spend more time on the API changes and deal with 
the patches in separate steps, the first four are really different in 
nature and only internal fixes without impact on userspace.

>
>
> thanks,
>
> Takashi
>
>
>>
>> A corresponding set of patches is available for alsa-lib.
>>
>> V2 changes:
>>
>> trigger_tstamp:
>> trigger_tstamp_latched, pending redefined as bool
>> trigger_tstamp_latched reset in snd_pcm_pre_start()
>>
>> audio_ts_config, report:
>> keep separate structure but use different bitfields for in and out.
>> use u32 instead of __u32, add comments that these structures are internal
>> COMPAT backwards compatible mode, uses WALL_CLOCK/LINK for HDAudio
>> playback and DEFAULT (hw_ptr) everywhere else
>>
>> INFO bits:
>> reclaimed 32-bits from hw_params, renamed as info_ext
>> moved all timestamp info to info_ext
>>
>> snd_pcm_status:
>> read only 32-bit audio_tstamp_data, ignore all other fields
>>
>> V3/4:
>> Addressed feedback from Jaroslav:
>> no change to STATUS ioctl, new functionality introduced in STATUS_EXT
>> ioctl with r/w params.
>> bumped PCM protocol for detection on STATUS_EXT in userspace
>> used 32-bit word for accuracy report, no mantissa/exponent packing
>> rolled back info_ext changes, all INFO fields remain in same word
>>
>> Merged comments from Liam (code simplifications)
>> fixed packing
>>
>> Added driver_tstamp field in case there is a delay in passing the
>> tstamp and audio_tstamp over IPC.
>>
>>
>>
>> Pierre-Louis Bossart (10):
>>    ALSA: core: don't override timestamp unconditionally
>>    ALSA: core: allow for trigger_tstamp snapshot in .trigger
>>    ALSA: hda: read trigger_timestamp immediately after starting DMA
>>    ALSA: usb: update trigger timestamp on first non-zero URB submitted
>>    ALSA: core: selection of audio_tstamp type and accuracy reports
>>    ALSA: core: pass audio tstamp config from userspace
>>    ALSA: core: pass audio tstamp config from userspace in compat mode
>>    ALSA: core: replace .wall_clock by .get_time_info
>>    ALSA: hda: replace .wallclock by .get_time_info
>>    ALSA: bump PCM protocol to 2.0.13
>>
>>   Documentation/sound/alsa/timestamping.txt | 200 ++++++++++++++++++++++++++++++
>>   include/sound/pcm.h                       |  67 +++++++++-
>>   include/uapi/sound/asound.h               |  36 +++++-
>>   sound/core/pcm_compat.c                   |  36 +++++-
>>   sound/core/pcm_lib.c                      |  88 ++++++++-----
>>   sound/core/pcm_native.c                   |  58 ++++++++-
>>   sound/pci/hda/hda_controller.c            |  43 +++++--
>>   sound/usb/pcm.c                           |   9 ++
>>   8 files changed, 478 insertions(+), 59 deletions(-)
>>   create mode 100644 Documentation/sound/alsa/timestamping.txt
>>
>> --
>> 1.9.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
