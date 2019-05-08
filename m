From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
Date: Wed, 8 May 2019 12:00:15 -0500
Message-ID: <0d2c6330-7882-a7e5-8dcb-51eec0e845ba@linux.intel.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-2-evgreen@chromium.org>
 <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
 <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 5/8/19 11:42 AM, Evan Green wrote:
> On Tue, May 7, 2019 at 3:14 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> Minor nit-picks below. The Kconfig would work but select CANNONLAKE even
>> if you don't want it.
>>
>>>
>>> +config SND_SOC_SOF_COMETLAKE_LP
>>> +     tristate
>>> +     select SND_SOC_SOF_CANNONLAKE
>>
>> This should be
>> select SND_SOF_SOF_HDA_COMMON
> 
> You mean SND_SOC_SOF_HDA_COMMON I assume.
> Except that I also need &cnl_desc, so I need CANNONLAKE to be on as
> well. Should I select them both?

Ah I see. I'd rather use a different descriptor then, and make the two 
platforms independent, as I did for CoffeeLake. You can use the same 
descriptor for the two -H and -LP skews though.
