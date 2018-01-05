From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI / utils: Introduce acpi_dev_get_dev_name()
Date: Fri, 5 Jan 2018 09:55:31 -0600
Message-ID: <4a1db265-a1cd-727e-1bf5-474d5f662955@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
 <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ih7RCPCdmVyn-RV39pUmZvodZs9S9-Av_ucY4mZ7vTrA@mail.gmail.com>
 <1515154920.7000.732.camel@linux.intel.com>
 <CAJZ5v0hYYPXT=Z8qnAV3mniF1hJ8Vu9t+MzUPX7o6Wg4zaUHwQ@mail.gmail.com>
 <1515155974.7000.735.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1515155974.7000.735.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/5/18 6:39 AM, Andy Shevchenko wrote:
> On Fri, 2018-01-05 at 13:34 +0100, Rafael J. Wysocki wrote:
>> On Fri, Jan 5, 2018 at 1:22 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Fri, 2018-01-05 at 13:06 +0100, Rafael J. Wysocki wrote:
>>>> On Thu, Jan 4, 2018 at 5:47 PM, Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
> 
>>> "Subset of Intel ASoC drivers is an existing user of this API when
>>> they
>>> need to find an actual instance of the codec device based on its
>>> ACPI
>>> HID."
>>
>> And why do they need the name (and not something else)?
> 
> I don't know the guts of Intel ASoC implementation, so, can't answer
> this without investigation.
> 
> Pierre, can you elaborate this piece?

Because the ASoC DAI structures use strings to represent the codec name. 
See e.g.

http://elixir.free-electrons.com/linux/latest/source/sound/soc/intel/boards/cht_bsw_rt5645.c#L480
http://elixir.free-electrons.com/linux/latest/source/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c#L37

In most cases a hard-coded name is fine, except when the BIOS uses a 
different HID or the ACPI subsystem changes the :00 ending to :01

So what the code does is that you look for a set of known HIDs, create 
the machine driver and pass the HID as pdata, then in the machine driver 
once you query the string that lets ASoC do the rest of the card creation.

You can argue that ASoC should not use strings, but that's not really a 
debate at this point: all I am trying to do is to make devices work when 
their BIOS is slightly different from the norm.

> 
>>> So, acpi_dev_get_name() then?
>>
>> It would be somewhat clearer to call it
>> acpi_dev_get_first_match_name() IMO.
>>
>> Otherwise it may not be clear what name this is going to return.
> 
> Works for me.
> 
> 

