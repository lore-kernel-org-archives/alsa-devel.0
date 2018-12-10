From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: HD-Audio: SKL+: abort probe if
 DSP is present and Skylake driver selected
Date: Mon, 10 Dec 2018 10:12:04 -0600
Message-ID: <b3beabcc-66ca-3454-c075-afd9451cc8a1@linux.intel.com>
References: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
 <20181208000039.23384-2-pierre-louis.bossart@linux.intel.com>
 <s5hin04fo4k.wl-tiwai@suse.de>
 <8fdcc781-ff56-f28e-aa1a-7df6e3694836@linux.intel.com>
 <s5ho99tmnax.wl-tiwai@suse.de>
 <1fc06f8b-c03b-3912-dc97-16fdf51ddb7d@linux.intel.com>
 <s5hftv5mkpf.wl-tiwai@suse.de> <s5hefapmkml.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB4026770D
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 17:12:06 +0100 (CET)
In-Reply-To: <s5hefapmkml.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, Chris Chiu <chiu@endlessm.com>, alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/10/18 10:06 AM, Takashi Iwai wrote:
> On Mon, 10 Dec 2018 17:05:00 +0100,
> Takashi Iwai wrote:
>> On Mon, 10 Dec 2018 16:57:49 +0100,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 12/10/18 9:08 AM, Takashi Iwai wrote:
>>>> On Mon, 10 Dec 2018 15:31:08 +0100,
>>>> Pierre-Louis Bossart wrote:
>>>>> On 12/8/18 1:56 AM, Takashi Iwai wrote:
>>>>>> On Sat, 08 Dec 2018 01:00:38 +0100,
>>>>>> Pierre-Louis Bossart wrote:
>>>>>>> Now that the SST/Skylake driver supports per platform selectors, we
>>>>>>> can add logic to automatically select the right driver.
>>>>>>>
>>>>>>> If the Skylake driver is selected, and the DSP is enable, the legacy
>>>>>>> HDaudio driver aborts the probe. This will result in a single driver
>>>>>>> probing and remove the need for modprobe blacklists.
>>>>>>>
>>>>>>> Follow-up patches will add a module parameter to bypass the logic if
>>>>>>> this automatic detection fails, or if the Skylake driver is unable to
>>>>>>> actually support the platform (firmware authentication, missing
>>>>>>> topology file, hardware issue, etc).
>>>>>>>
>>>>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>>>>> ---
>>>>>>>     sound/pci/hda/Kconfig          | 46 ++++++++++++++++++++++++++++++++++
>>>>>>>     sound/pci/hda/hda_controller.h |  2 +-
>>>>>>>     sound/pci/hda/hda_intel.c      | 34 +++++++++++++++++++------
>>>>>>>     sound/soc/intel/Kconfig        |  6 +++++
>>>>>>>     4 files changed, 80 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
>>>>>>> index 4235907b7858..634b7fe6a936 100644
>>>>>>> --- a/sound/pci/hda/Kconfig
>>>>>>> +++ b/sound/pci/hda/Kconfig
>>>>>>> @@ -226,6 +226,52 @@ config SND_HDA_POWER_SAVE_DEFAULT
>>>>>>>     	  The default time-out value in seconds for HD-audio automatic
>>>>>>>     	  power-save mode.  0 means to disable the power-save mode.
>>>>>>>     +if SND_HDA_INTEL
>>>>>>> +
>>>>>>> +config SND_HDA_INTEL_DISABLE_SKL
>>>>>>> +	bool
>>>>>>> +	help
>>>>>>> +	  This option disables HD-audio legacy for
>>>>>>> +	  Skylake machines
>>>>>> I'm not sure whether we need the selection of this disablement for
>>>>>> each model.  Distros would choose these unlikely, and individual users
>>>>>> don't have to select multiple of them but only for their machine's
>>>>>> model.  So, in the end, the choice would be either yes or no.
>>>>> Ah yes, maybe I wasn't clear. This wasn't intended to be selected by
>>>>> the user, but selected when when the SND_SOC_INTEL_KBL or
>>>>> SND_SOC_SOF_CNL options are set. See the conditions below.
>>>>>
>>>>> The main idea what to only deal with the conflict resolution when we
>>>>> indeed have a conflict. I also introduced this option on the
>>>>> sound/pci/hda side so that SOF can use the same mechanisms, i.e. it's
>>>>> the legacy driver doesn't need to know if the conflict happens with
>>>>> the SST/Skylake or SOF driver.
>>>> OK, that makes sense.
>>>>
>>>> But then better to rephrase the help texts there for avoiding
>>>> confusion.  Currently it sounds as if the kconfig always disables the
>>>> support of the given chipset.  But the actual behavior is to disable
>>>> the binding with the legacy driver *only if* the PCI device class is
>>>> declared for Intel DSP.
>>> ok, will respin the help text.
>>>
>>> I was wondering if my email client ate your answers, was is the only
>>> change you wanted? In reply to the cover letter you mentioned "some
>>> comments" but I only see this one that needs an update, and no
>>> comments for the initial series of Skylake-specific patches.
>> Maybe you missed my comments for the second and later hunks of
>> patch#2?  It was about some dev_warn() and dev_err() usages, which I
>> suggested to degrade to dev_info().
Ah yes, sorry. I knew I was missing something.
> Oh, BTW, did the fallback mechanism work properly with your patches on
> the actual machines?
>
> At the last time I tried on SKL, the fallback failed by some reason,
> the driver core didn't try to load and bind two drivers.

I tested on two platforms, one WHL with DSP and one without (Skylake HP 
device), and the 3 values and didn't see any errors. lspci -vvv reports 
the two drivers registered but only the one I wanted as 'in use'.

I'll run more experiments on KBL and APL NUCs.

>
>
> Takashi
