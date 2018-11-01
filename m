From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 7/7] ASoC: Intel: common: add quirk for APL
 RVP boards
Date: Thu, 1 Nov 2018 10:08:55 -0500
Message-ID: <27df08a1-3682-8e35-f72f-e2048361a095@linux.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
 <20181101010718.2878-8-pierre-louis.bossart@linux.intel.com>
 <20181101141149.GV10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 024702677D0
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 16:08:58 +0100 (CET)
In-Reply-To: <20181101141149.GV10650@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 11/1/18 9:11 AM, Andy Shevchenko wrote:
> On Wed, Oct 31, 2018 at 08:07:18PM -0500, Pierre-Louis Bossart wrote:
>> For some reason the RVP/LeafHill SSDT exposes an INT34C3 ID which is
>> used on other boards to point to the TDF8532 amplifier. Yay BIOS.
>>
>> Add a DMI-quirk to ignore this ID and check for other valid machine
>> driver descriptors.
>> +static unsigned long apl_machine_id;
>> +
>> +#define APL_RVP  1
>> +
>> +static int apl_rvp_quirk_cb(const struct dmi_system_id *id)
>> +{
>> +	apl_machine_id = APL_RVP;
>> +	return 1;
>> +}
>> +
>> +static const struct dmi_system_id apl_table[] = {
>> +	{
>> +		.callback = apl_rvp_quirk_cb,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Apollolake RVP1A"),
>> +		},
>> +	},
>> +	{},
> Terminator entry doesn't need a comma. It would prevent from (unlikely)
> mistakes when extending the list.
Indeed. I don't know how many tables use this though... will update.
>
>> +};
>> +
>> +static struct snd_soc_acpi_mach *apl_quirk(void *arg)
>> +{
>> +	struct snd_soc_acpi_mach *mach = arg;
>> +
>> +	dmi_check_system(apl_table);
> Can't we just use driver_data of the table above and get rid of at least global variable?

Yes. The code is pretty much copy-pasted from other BYT quirks but can 
be written in a better way

Will send a v2 later today, thanks Andy for the suggestion.


>
>> +
>> +	if (apl_machine_id == APL_RVP)
>> +		return NULL;
>> +	else
>> +		return mach;
>> +}
