From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] ASoC: Intel: Kconfig:
 Simplify-clarify ACPI/PCI dependencies
Date: Mon, 20 Nov 2017 10:23:33 -0600
Message-ID: <5b2dde66-d30e-5cd6-15df-12f002850274@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
 <1511024018.25007.310.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511024018.25007.310.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org



On 11/18/2017 10:53 AM, Andy Shevchenko wrote:
> On Fri, 2017-11-17 at 18:01 -0600, Pierre-Louis Bossart wrote:
>> PCI/ACPI selections should not happen in Kconfig for machine drivers,
>> move to SOC selections.
>>
>> Add distinction between PCI and ACPI HiFi2 platforms.
>
>>   The PCI-based
>> platforms may be removed at some point since Medfield is not really
>> supported by anyone
> This is rather true,
>
>>   and there is no publicly available firmware for
>> Merrifield.
> while this is not true. Intel Edison board is based on Merrifield SoC
> and I'm sure people are able to make a sound out of it.

I am aware that Edison could run with a modified 4.4 kernel, I just 
don't know where the firmware is. I don't see anything for Merrifield in 
/lib/firmware/intel?
If there is a simple way of testing this I don't mind looking into this, 
I just don't have the pointers.

>
