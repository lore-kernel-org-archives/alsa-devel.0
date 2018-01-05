From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ACPI / utils: Introduce
	acpi_dev_get_dev_name()
Date: Fri, 5 Jan 2018 09:46:45 -0600
Message-ID: <52c40d6e-08d1-efe1-9341-55747428d93c@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
 <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
 <5e21c7c3-83cf-e038-e57e-0dfa4640862e@linux.intel.com>
 <1515156235.7000.740.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C40BD266A74
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 16:46:48 +0100 (CET)
In-Reply-To: <1515156235.7000.740.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/5/18 6:43 AM, Andy Shevchenko wrote:
> On Thu, 2018-01-04 at 18:47 -0600, Pierre-Louis Bossart wrote:
>>
>> On 01/04/2018 10:47 AM, Andy Shevchenko wrote:
>>> Sometimes the user want to have device name of the match rather than
>>> just checking if device present or not. To make life easier for such
>>> users introduce acpi_dev_get_dev_name() helper based on code for
>>> acpi_dev_present().
>>>
>>> To be more consistent with the purpose rename
>>>
>>>     struct acpi_dev_present_info  -> struct acpi_dev_match_info
>>>     acpi_dev_present_cb()         -> acpi_dev_match_cb()
>>>
>>> in the utils.c file.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> This works fine on a Dell 5585 where the default codec dai name needs
>> to
>> be updated based on the actual HID information, so
>> Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Thanks!
> 
> Is this only for patch 1, or for both 1 and 2 ?
> 
>> the next patch does not apply directly however, and needs additional
>> changes for the ES8316 machine driver. see the changes here:
>> https://github.com/plbossart/sound/tree/topic/bytcht-acpi-fixes
> 
> You mean because of this
> https://github.com/plbossart/sound/commit/2416827fa6d221b27edd6397f17daa
> a1f3cd5fb0
> ?

No, not only, there is also a conflict in soc-acpi.c
> 
> I.e. I need to rebase on top of your series.

The code I use contains all the Kconfig cleanups (v3 sent yesterday), so 
there is another dependency here.

> 
>> It's probably best to let this patch go through the acpi tree, and
>> the
>> next one through Mark's tree once the first is merged and all the
>> other
>> Kconfig/acpi stuff is also in -next?
> 
> It wouldn't prevent to push patch 3 as well via linux-pm at the same
> time as patch 1.
> 
> Linus, do you have any objection on that?
> 
