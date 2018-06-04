From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 00/13] Enable HDA Codec support on Intel
 Platforms
Date: Mon, 4 Jun 2018 08:27:18 -0500
Message-ID: <1c445079-c5c6-8c70-ebcf-f1eabb7616e8@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
 <s5h603136ni.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B7A1267866
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 15:27:21 +0200 (CEST)
In-Reply-To: <s5h603136ni.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/2/18 4:00 AM, Takashi Iwai wrote:
> On Sat, 02 Jun 2018 05:53:48 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Many Intel platforms (SKL, KBL) etc. in the market supports enhanced
>> audio capabilities which also includes DSP processing. The default
>> HDaudio legacy driver does not allow for the use of the DSP, this
>> patch set makes it possible while reusing existing code for HDAudio
>> codecs and without significant changes to the legacy driver.
>>
>> This v3 is not split into two batches as done for v1 and v2, but keeps
>> the same logical progression. The first three patches are mostly data
>> structure changes, the DSP support capability is added then with an
>> ASoC HDA driver and the last patches are fixes required for
>> Skylake+. The changes to the HDAudio legacy driver are minimal.
>>
>> Tests were run successfully on multiple platforms (Dell XPS13, KBL
>> NUC, APL NUC and LeafHill reference board).
>>
>> Credits: all the initial code was written by Rakesh Ughreja, the
>> rebase to broonie/for-next, cleanups and additional tests were done by
>> Pierre Bossart.
>>
>> Changes v3:
>> - port to component model
>> - additional tests on ApolloLake and KabyLake NUC devices
>> - cleanups (alignment, typos, etc)
>>
>> Changes v2:
>> - Resolved review comments and rebased to latest kernel.
>> - added module load support for codec drivers.
>>
>> Rakesh Ughreja (13):
>>    ALSA: hdac: Remove usage of struct hdac_ext_device and use hdac_device
>>      instead
>>    ALSA: hdac: Remove usage of struct hdac_ext_bus and use hdac_bus
>>      instead
>>    ALSA: hdac: Remove usage of struct hdac_ext_driver, use hdac_driver
>>      instead
>>    ASoC: Intel: Boards: Machine driver for SKL+ w/ HDAudio codecs
>>    ASoC: Intel: Skylake: Add entry in sst_acpi_mach for HDA codecs
>>    ASoC: Intel: Skylake: add HDA BE DAIs
>>    ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
>>    ALSA: hda: split snd_hda_codec_new function
>>    ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
>>    ALSA: hdac: add extended ops in the hdac_bus
>>    ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
>>    ALSA: hdac: ext: add wait for codec to respond after link reset
>>    ASoC: Intel: Skylake: fix widget handling
> 
> Thanks for the patches.  But, from obvious reasons, we can't take
> these for the next merge window.  So it's really no good timing for
> such a big series...

I wasn't asking for a forced merge or trying to make your life 
complicated, it was more that I had a bit of time this week to provide 
an update and wanted to check how we deal with the multiple changes in 
different parts (Skylake, hda, hdac). It's fine if those patches land in 
4.19 with additional time for reviews/testing.

> 
> In anyways, the patch series look like a mixture of lots of different
> things.  Maybe it's better to split to multiple series, namely:
> 
> - Individual fixes
> 
> Patches 12 and 13 are irrelevant with the whole story, and they are
> merely fixes, can be applied individually.
> (the patch13 might be depending on others, though; didn't take a
>   deeper look at it yet.)
> 
> - The removal of hdac_ext_* structs
> 
> These are basically no functional changes and local in hdac_ext.
> The preliminary work.  The regression test is mandatory.
> 
> - Some code split / exports in snd_hda_codec_*(), adaption of hdac_bus
>    extended ops
> 
> Another preliminary work and a setup for the new binding.
> They should be also no functional changes, and the existing setup
> should work as is.  The regression test is mandatory.
> 
> - The new hdac_hdmi codec support and the new board codes
> 
> These are the new stuff, and applied after the preparations above.

I can split the code, but as you highlighted the series is pretty much 
organized as
- cleanups
- code split
- addition of new functionaliy
- fixes
...
> 
> 
> ... and these patches are touching both ASoC and HD-audio legacy, we'd
> need the coordinated patch application.  That is, we'd need a topic
> branch that will be merged to both Mark and my trees.  We can branch it
> off after 4.18-rc1 release, for example, as a clean start point.

... And I am not sure I understand the topic branch merged in both 
directions. If we want to perform a non-regression with the first parts 
(without ASoC additions) then we may need to create a partial topic 
branch, then add the rest later?

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
