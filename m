From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] ALSA: hda/intel: stop probe if DMICS
 are detected on Skylake+ platforms
Date: Fri, 19 Jul 2019 13:29:10 -0500
Message-ID: <6bc24e2a-596b-83f4-d022-5f630657c3a1@linux.intel.com>
References: <20190719170610.17610-1-pierre-louis.bossart@linux.intel.com>
 <20190719170610.17610-7-pierre-louis.bossart@linux.intel.com>
 <s5hlfwtzyca.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84AF7F800C4
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 20:29:13 +0200 (CEST)
In-Reply-To: <s5hlfwtzyca.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org



On 7/19/19 1:13 PM, Takashi Iwai wrote:
> On Fri, 19 Jul 2019 19:06:10 +0200,
> Pierre-Louis Bossart wrote:
>>
>> +static int azx_check_dmic(struct pci_dev *pci, struct azx *chip)
>> +{
>> +	struct nhlt_acpi_table *nhlt;
>> +	int ret = 0;
>> +
>> +	if (chip->driver_type == AZX_DRIVER_SKL &&
>> +	    pci->class != 0x040300) {
>> +		nhlt = intel_nhlt_init(&pci->dev);
>> +		if (nhlt) {
>> +			if (intel_nhlt_get_dmic_geo(&pci->dev, nhlt)) {
>> +				ret = -ENODEV;
>> +				dev_dbg(&pci->dev, "Digital mics found on Skylake+ platform, aborting probe\n");
> 
> IMO, this can be verbose, dev_info() would be suitable.
> Otherwise user has no idea why the module load is skipped.

sure, will do.

> 
> 
>> @@ -2055,6 +2078,17 @@ static int azx_probe(struct pci_dev *pci,
>>   	card->private_data = chip;
>>   	hda = container_of(chip, struct hda_intel, chip);
>>   
>> +	/*
>> +	 * stop probe if digital microphones detected on Skylake+ platform
>> +	 * with the DSP enabled. This is an opt-in behavior defined at build
>> +	 * time or at run-time with a module parameter
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SND_HDA_INTEL_DETECT_DMIC) || dmic_detect >= 0) {
> 
> Isn't it "dmic_detect != 0" ?  Otherwise passing dmic_detect=0 would
> be treated as positive here.

Ah, good catch. I literally copied the enable_msi example here, which 
relies on >= 0.

	if (enable_msi >= 0) {
		chip->msi = !!enable_msi;
		return;
	}

Not sure what the intention was here.

Using dmic_detect != 0 wouldn't work for the default -1 value,
maybe dmic_detect > 0 is probably a better solution?
