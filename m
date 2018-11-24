From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S
 support
Date: Fri, 23 Nov 2018 21:16:31 -0600
Message-ID: <7598e3f5-d936-709b-85e4-eecfa5d149fd@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
 <20181121173841.GS10650@smile.fi.intel.com> <s5hh8gaaxdm.wl-tiwai@suse.de>
 <20181122095611.GV10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122095611.GV10650@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


On 11/22/18 3:56 AM, Andy Shevchenko wrote:
> On Wed, Nov 21, 2018 at 11:17:41PM +0100, Takashi Iwai wrote:
>> On Wed, 21 Nov 2018 18:38:41 +0100, Andy Shevchenko wrote:
>>> Compare:
>>>
>>> 	/* CFL */
>>> 	{ PCI_DEVICE(0x8086, 0xa348),
>>> 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>>>
>>> to something like:
>>>
>>> #define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
>>> ...
>>>
>>> 	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},
>> The former gives a better grep-ability, though.
>>
>> I have no big preference over two, just want to mention that both have
>> merits and demerits.
> True.
> So, up to you, guys, what to choose.

I am leaning to leave the PCI stuff alone for now. If we change the PCI 
definitions I'd like to do it on the SKL and legacy sides at the same 
time, to avoid multiple definitions or redundancies.

However I like your suggestion for the macros on the other patch so will 
change the code.

Thanks for the reviews!

>
