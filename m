From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Thu, 4 Jan 2018 11:06:01 -0600
Message-ID: <8608f1eb-d22a-75c3-f6a2-68929404e393@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-4-pierre-louis.bossart@linux.intel.com>
 <1515077848.7000.676.camel@linux.intel.com>
 <1294a824-602c-66e0-35bb-a7b47f3e856a@linux.intel.com>
 <1515081629.7000.679.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 9908B267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:06:04 +0100 (CET)
In-Reply-To: <1515081629.7000.679.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 1/4/18 10:00 AM, Andy Shevchenko wrote:
> On Thu, 2018-01-04 at 09:24 -0600, Pierre-Louis Bossart wrote:
>> On 1/4/18 8:57 AM, Andy Shevchenko wrote:
>>> On Wed, 2018-01-03 at 11:02 -0600, Pierre-Louis Bossart wrote:
>>>>
>>>> Fix by overriding the hard-coded value with the codec name derived
>>>> from the HID information
>>>
>>> The patch makes me think about introducing acpi_dev_get_dev_name()
>>> and
>>> utilize it here since I need something similar to have in one of
>>> GPIO
>>> drivers.
>>
>> we use this: snd_soc_acpi_find_name_from_hid(mach->id)
>>
>> When I started all this the recommendation was to do all this on the
>> audio side of things, I have no objections to a move of the
>> functionality in acpi.
> 
> I almost done a patch. I will Cc you for the series.

ok. The only concern I have is that this needs to be a somewhat 
contained change that doesn't depend on all sorts of other ACPI/GPIO 
changes. We will have to maintain a v4.14-based branch for a very very 
long time and the simpler we make it for people who back-port or 
cherry-pick the better.

> 
>>>> +static char codec_name[16]; /* i2c-<HID>:00 with HID being 8
>>>> chars */
>>>> +
>>>
>>> I would rather do use 4 + ACPI_ID_LEN + 3 /* or 1 + 2 */ + 1 and
>>> explain
>>> each part in the comment above.
>>
>> yes we could do this. this is the same code as in other machine
>> drivers,
>> so we should do the replacement across all of them in one shot in a
>> separate patch.
> 
> Whatever you prefer, it's minor.
>    
>>>> +	mach = (&pdev->dev)->platform_data;
>>>> +	/* fix index of codec dai */
>>>> +	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
>>>> +		if (!strcmp(byt_cht_es8316_dais[i].codec_name,
>>>> +			    "i2c-ESSX8316:00")) {
>>>> +			dai_index = i;
>>>> +			break;
>>>> +		}
>>>
>>> Perhaps at some point you can do such in more generic (across Intel
>>> ASoCs) ?
>>
>> Not sure what you are hinting at here? Did you mean changing the name
>> of
>> the array? Or adding a helper function to do this?
> 
> Suggestion is to create a helper out of similar for-loops-fix-name in
> all current users.

ok, I'll work on this. Thanks for the suggestion.
