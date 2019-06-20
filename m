From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops to
 NULL on remove
Date: Thu, 20 Jun 2019 08:17:33 +0200
Message-ID: <26946ff4-1c91-a7e0-4354-132cbd06235a@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
 <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
 <20190618130015.0fc388b4@xxx>
 <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
 <20190619103859.15bf51c5@xxx>
 <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>>>>> Could you please give a bit more context on what error you see
>>>>> when this happens?
>>>>
>>>> Hi,
>>>>
>>>> I get Oops. This is what happens with all other patches in this
>>>> series and only this one reverted:
>>>>
>>>> root@APL:~# rmmod snd_soc_sst_bxt_rt298
>>>> root@APL:~# rmmod snd_soc_hdac_hdmi
>>>> root@APL:~# rmmod snd_soc_skl
>>>
>>> Thanks, Amadeusz. I think the order in which the drivers are
>>> removed
>>> is what's causing the oops in your case. With SOF, the order we
>>> remove is
>>>
>>> 1. rmmod sof_pci_dev
>>> 2. rmmod snd_soc_sst_bxt_rt298
>>> 3. rmmod snd_soc_hdac_hdmi
>>>
>>
>> Well, there is nothing enforcing the order in which modules can be
>> unloaded (and I see no reason to force it), as you can see from
>> following excerpt, you can either start unloading from
>> snd_soc_sst_bxt_rt298 or snd_soc_skl, and yes if you start from
>> snd_soc_skl, there is no problem.

there is a fundamental dependency that you are ignoring: the module 
snd_soc_sst_bxt_rt298 is a machine driver which will be probed when 
snd_soc_skl creates a platform_device.
Sure you can remove modules in a different order, but that's a bit of an 
artificial/academic exercise isn't it?

>>
> I am good with this patch. I just wanted to understand why we werent
> seeing this error with SOF. Sure, there's nothing enforcing the order
> in which modules are unloaded  but there must be a logical order for
> testing purposes.
> 
> Pierre, can you please comment on it. I vaguely remember discussing
> this with you last year.

Our tests remove the modules by taking care of dependencies and it's 
already unveiled dozens of issues.
We could add a sequence similar to Amadeusz and unbind the modules which 
are loaded with the creation of a platform_device (machine driver, 
dmic), I am just not sure how of useful this would be.
