From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Mon, 5 Nov 2018 11:18:07 -0600
Message-ID: <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
 <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1s7z35t8.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Naveen Manohar <naveen.m@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>>> We have this ("strange") lines over the drivers:
>>>
>>> config BAR
>>> depends on FOO || FOO=n
>>>
>>> which guarantees that FOO will be not module when BAR is built-in.
>> That's what I normally use, but I could not figure this one out.
>> One problem is that SND_SOC_ALL_CODECS selects
>> SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
>> may be =m, causing the failure for
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.
>>
>> It might work with a separate dummy symbol:
>>
>> config SND_SOC_HDAC_HDA_FORCE
>>           tristate
>>           depends on SND_SOC_ALL_CODECS != n
>>           default SND_SOC_INTEL_SKYLAKE
>>           select SND_SOC_HDAC_HDA
>>
>> This would make SND_SOC_HDAC_HDA built-in even
>> with SND_SOC_ALL_CODECS=m and
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=n
>>
>> It seems a bit ugly, and would need some testing.
> The mixture of depends and select is often more confusing, so IMO, we
> should align with only select as Pierre's suggestion, in this
> particular case.

I tried to avoid re-adding a "depends on" which we tried to remove last 
year, but there is still a conditional statement which assumes a very 
specific evaluation order.

1. SKYLAKE is enabled as m or y

2. that enables some machine drivers (through an if statement), some of 
which might select HDA audio

3. the selections done within the SKYLAKE config are conditional on the 
outcome of #2.

it seems to work but I don't know if it's by design or an accident :-). 
One could argue it's a hidden "depends on".
