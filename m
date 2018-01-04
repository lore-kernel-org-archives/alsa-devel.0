From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Thu, 4 Jan 2018 09:24:56 -0600
Message-ID: <1294a824-602c-66e0-35bb-a7b47f3e856a@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-4-pierre-louis.bossart@linux.intel.com>
 <1515077848.7000.676.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB852678B8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 16:24:56 +0100 (CET)
In-Reply-To: <1515077848.7000.676.camel@linux.intel.com>
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

On 1/4/18 8:57 AM, Andy Shevchenko wrote:
> On Wed, 2018-01-03 at 11:02 -0600, Pierre-Louis Bossart wrote:
>> Same problem as with previous machine drivers, the codec dai
>> uses a hard-coded name of "i2c-ESSX8316:00" but ACPI provides
>> "i2c-ESSX8316:01" in some systems.
> 
> Yeah, that's why using device instances is fragile...
> 
>>
>> Fix by overriding the hard-coded value with the codec name derived
>> from the HID information
> 
> The patch makes me think about introducing acpi_dev_get_dev_name() and
> utilize it here since I need something similar to have in one of GPIO
> drivers.

we use this: snd_soc_acpi_find_name_from_hid(mach->id)

When I started all this the recommendation was to do all this on the 
audio side of things, I have no objections to a move of the 
functionality in acpi.

[snip]

>> diff --git a/sound/soc/intel/boards/bytcht_es8316.c
>> b/sound/soc/intel/boards/bytcht_es8316.c
>> index 8088396717e3..ae24f6205f05 100644
>> --- a/sound/soc/intel/boards/bytcht_es8316.c
>> +++ b/sound/soc/intel/boards/bytcht_es8316.c
>> @@ -232,15 +232,39 @@ static struct snd_soc_card byt_cht_es8316_card =
>> {
>>   	.fully_routed = true,
>>   };
>>   
>> +static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
>> +
> 
> I would rather do use 4 + ACPI_ID_LEN + 3 /* or 1 + 2 */ + 1 and explain
> each part in the comment above.

yes we could do this. this is the same code as in other machine drivers, 
so we should do the replacement across all of them in one shot in a 
separate patch.

> 
>>   static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>>   {
>> -	int ret = 0;
>>   	struct byt_cht_es8316_private *priv;
>> +	struct snd_soc_acpi_mach *mach;
>> +	const char *i2c_name = NULL;
>> +	int dai_index = 0;
>> +	int i;
>> +	int ret = 0;
>>   
>>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
>>   	if (!priv)
>>   		return -ENOMEM;
>>   
>> +	mach = (&pdev->dev)->platform_data;
>> +	/* fix index of codec dai */
>> +	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
>> +		if (!strcmp(byt_cht_es8316_dais[i].codec_name,
>> +			    "i2c-ESSX8316:00")) {
>> +			dai_index = i;
>> +			break;
>> +		}
> 
> Perhaps at some point you can do such in more generic (across Intel
> ASoCs) ?

Not sure what you are hinting at here? Did you mean changing the name of 
the array? Or adding a helper function to do this?
