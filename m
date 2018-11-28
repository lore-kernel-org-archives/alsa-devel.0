From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/6] ASoC:Intel:Skylake: Enable HDaudio legacy
 fallback
Date: Wed, 28 Nov 2018 12:09:19 -0600
Message-ID: <5854417f-5e36-4397-5644-99c9b5f4ed40@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <s5h36rud8lg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h36rud8lg.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 11/21/18 4:32 AM, Takashi Iwai wrote:
> On Tue, 20 Nov 2018 22:36:38 +0100,
> Pierre-Louis Bossart wrote:
>> This patchset is provided as an RFC and should not be merged as is
>> (Turkey break in the USA and more validation needed). This is however
>> a good time to gather comments. This work is the result of multiple
>> email discussions to finally provide more flexibility for
>> distributions to chose whether to stick with the legacy HDaudio driver
>> or to enable the SST/Skylake driver for newer platforms (required
>> e.g. for digital microphone support)
>>
>> The patches add support for CoffeeLake, simplify the probe for the
>> Skylake driver, introduce more compile-time granularity so that
>> platforms can be selected individually and last provide a dynamic
>> fallback mechanism when two drivers are registered for the same PCI
>> ID.
>>
>> When the SOF driver is released, the same mechanism will be used to
>> enable the SOF-legacy fallback. There will be no plans to enable an
>> SOF->SST falback.
> This looks like a sensible way to go, thanks for working on this!
>
> While the fallback stuff might need more testing, the other patches
> (addition of CFL-S and split of configs) are rather systematic, so we
> can merge this at first soonish.
>
> And we may need a bit more comments in Kconfig help for the fallback
> behavior.  Or document it properly and refer to it from Kconfig help.
> The git commit log isn't present in the released kernel code, after
> all.

I will indeed put the dynamic fallback on the back-burner, of course the 
tests work on NUCs and recent devices but fail on a HP SKL device I 
tried on, so additional code needs to be added to check if the DSP is 
present or not, remove silly dependencies on NHLT that make no sense for 
HDaudio, etc.

I'd like however to follow your idea of a 'shared' caps but use it for 
static mutual-exclusion to start, e.g. to let distributions use legacy 
for Broadwell but SST for SKL/KBL without requiring the user to play 
with blacklists.  Once we have this in place, and the additional code 
added for DSP detection the dynamic fallback is an 'easy' transition.

>
>
> thanks,
>
> Takashi
>
>> Pierre-Louis Bossart (4):
>>    ASoC: Intel: Skylake: stop init/probe if DSP is not present
>>    ASoC: Intel: Skylake: remove useless tests on DSP presence
>>    ASoC: Intel: Skylake: Add more platform granularity
>>    ALSA: hda: add fallback capabilities for SKL+ platforms
>>
>> Takashi Iwai (2):
>>    ASoC: Intel: Skylake: Add CFL-S support
>>    ALSA: hda: Allow fallback binding with legacy HD-audio for Intel SKL+
>>
>>   include/sound/hdaudio.h                |   6 +
>>   sound/pci/hda/Kconfig                  |  40 +++++++
>>   sound/pci/hda/hda_controller.h         |   2 +-
>>   sound/pci/hda/hda_intel.c              |  51 ++++++--
>>   sound/soc/intel/Kconfig                |  86 ++++++++++++--
>>   sound/soc/intel/boards/Kconfig         |  16 ++-
>>   sound/soc/intel/skylake/skl-messages.c |   8 ++
>>   sound/soc/intel/skylake/skl.c          | 154 +++++++++++++++++++------
>>   8 files changed, 311 insertions(+), 52 deletions(-)
>>
>> -- 
>> 2.17.1
>>
