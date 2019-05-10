From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
Date: Fri, 10 May 2019 12:56:51 -0500
Message-ID: <75c3efb7-8057-0d4c-a53d-45f4527d90a1@linux.intel.com>
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <s5h7eayn5or.wl-tiwai@suse.de>
 <73c6dd27-895a-adba-a4ef-2992266fcc48@linux.intel.com>
 <s5hlfzempf0.wl-tiwai@suse.de>
 <1e7e1908-a813-6c9b-5b88-122864d3a372@linux.intel.com>
 <s5hbm0amnpl.wl-tiwai@suse.de> <s5h8svemn0u.wl-tiwai@suse.de>
 <00aa3055-0b97-3ac4-f588-3665bfcb5811@linux.intel.com>
 <s5h1s16memr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1s16memr.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, rdunlap@infradead.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>>> Yes, that would work.  OTOH, I see no merit to build an extra module
>>>> for nocodec.  nocodec.c can be built together with sof-core stuff.
>>
>> the module has its benefits. Today nocodec includes all possible DAIs,
>> I wanted to add module parameters to restrict things a bit for
>> tests/debug. It'll be e.g. very helpful for SoundWire to avoid
>> exposing the SSP DAIs.
>>
>> Also nocodec is incompatible with hdaudio/hdmi support at the moment,
>> we had all sorts of issues with suspend/resume.
> 
> Well, in the case of SOF, the core code calls directly
> soc_nocodec_setup(), hence it's rather a direct link.  So it makes
> little sense to make the nocodec code split from sof-core, unless the
> nocodec code is used / linked by components other than SOF.  I doubt
> the possibility because the current DAI is clearly only for SOF...
> 
> The module option can be still be there; it'll be applied just to
> sof-core instead of sof-nocodec.

I see your point and this SOF core/nocodec dependency is a conceptual 
miss on our side. Thanks for bringing our attention on this.

The core is really supposed to be about the DSP side of things. It 
shouldn't be burdened with machine driver stuff, but it unfortunately is 
at two levels.

Initially the nocodec code was handled at the soc-acpi-dev or 
soc-pci-dev level, and it's still there that the FORCE_CODEC mode is 
handled, along with the calls to check the codec ACPI IDs. Now when we 
enabled the HDaudio case, we somehow ended-up moving parts of the 
nocodec support in the SOF core to simplify our life but created a 
dependency that wasn't intentional at all. we collectively missed it 
while we were struggling with nocodec/hdaudio compatibility.

The second issue is that we create a platform_device for the machine 
driver in the SOF core. This is a shortcut that we took and that works 
for Intel, but for DeviceTree-based platforms this will have to change.

So long story short, I'd rather have a simple Kconfig fix to avoid 
compilation issues for now and revisit all the machine driver support, 
e.g. when the i.MX patches show up, than strengthen a dependency that we 
introduced by accident rather than by design.
