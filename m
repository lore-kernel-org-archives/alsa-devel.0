From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2] ACPI / device_sysfs: change _ADR
 representation to 64 bits
Date: Tue, 14 May 2019 16:37:13 -0500
Message-ID: <05820f12-de32-c5bb-0780-75c43557e677@linux.intel.com>
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com>
 <20190502045817.GZ3845@vkoul-mobl.Dlink>
 <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
 <1683867.ro8ObbCUgW@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1683867.ro8ObbCUgW@kreacher>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vinod Koul <vkoul@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, jank@cadence.com, Joe Perches <joe@perches.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
List-Id: alsa-devel@alsa-project.org


>>>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>>>> index 8940054d6250..7dda0ee05cd1 100644
>>>> --- a/drivers/acpi/device_sysfs.c
>>>> +++ b/drivers/acpi/device_sysfs.c
>>>> @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
>>>>   {
>>>>        struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>>
>>>> -     return sprintf(buf, "0x%08x\n",
>>>> -                    (unsigned int)(acpi_dev->pnp.bus_address));
>>>> +     if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
>>>
>>> Would prefer to use U32_MAX instead of 0xFFFFFFFF
>>
>> I would.
>>
> 
> I have made that change manually and applied the patch.
> 
> Thanks!

Thanks, much appreciated.
