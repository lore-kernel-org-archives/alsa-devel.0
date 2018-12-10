From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: HD-Audio: SKL+: force HDaudio
 legacy or SKL+ driver selection
Date: Mon, 10 Dec 2018 08:55:15 -0600
Message-ID: <0a316294-4b0b-05af-ef5f-c280f633e99d@linux.intel.com>
References: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
 <20181208000039.23384-3-pierre-louis.bossart@linux.intel.com>
 <s5hk1kkfoex.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB7B267AFE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 15:55:36 +0100 (CET)
In-Reply-To: <s5hk1kkfoex.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, Chris Chiu <chiu@endlessm.com>, alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/8/18 1:49 AM, Takashi Iwai wrote:
> On Sat, 08 Dec 2018 01:00:39 +0100,
> Pierre-Louis Bossart wrote:
>> For HDaudio and Skylake drivers, add module parameter "pci_binding"
>>
>> When pci_binding == 0 (AUTO), the PCI class/subclass info is used to
>> select drivers based on the presence of the DSP.
>>
>> pci_binding == 1 (LEGACY) forces the use of the HDAudio legacy driver,
>> even if the DSP is present.
>>
>> pci_binding == 2 (ASOC) forces the use of the ASOC driver. The
>> information on the DSP presence is bypassed.
>>
>> The value for the module parameter needs to be identical for both
>> drivers. This parameter is intended as a back-up solution if the
>> automatic detection fails or when the DSP usage fails. Such cases
>> should be reported on the alsa-devel mailing list for analysis.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> In theory, we can put this module option into snd-hda-core that is
> used by both legacy and ASoC drivers, too, if we want to have a single
> common option.  But it's not always intuitive, so I'm fine to keep the
> option to both drivers.
Yes, the main reason for adding the parameters is that most distros have 
a blacklist and people are familiar with dealing with snd_hda_intel and 
snd_soc_skl. Adding a parameter here is just a change from a plain 
blacklist to an option.
>
>> index 0c76713ac5c0..4e1aee5167a1 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -172,6 +172,9 @@ module_param_array(beep_mode, bool, NULL, 0444);
>>   MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
>>   			    "(0=off, 1=on) (default=1).");
>>   #endif
>> +static int skl_pci_binding;
>> +module_param_named(pci_binding, skl_pci_binding, int, 0444);
>> +MODULE_PARM_DESC(legacy, "PCI binding (0=auto, 1=only legacy, 2=only asoc");
> The parameter is "pci_binding", not "legacy", right?
> The same error is seen in asoc skl.
>
>
>>   #ifdef CONFIG_PM
>>   static int param_set_xint(const char *val, const struct kernel_param *kp);
>> @@ -2093,9 +2096,25 @@ static int azx_probe(struct pci_dev *pci,
>>   	int err;
>>   
>>   	/* check if this driver can be used on SKL+ Intel platforms */
>> -	if ((pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) &&
>> -	    pci->class != 0x040300)
>> -		return -ENODEV;
>> +	if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
>> +		switch (skl_pci_binding) {
>> +		case SND_SKL_PCI_BIND_AUTO:
>> +			if (pci->class != 0x040300) {
>> +				dev_warn(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
> I'd use dev_info() for these messages.
> Loading this module is done by udev, not user, so it's no user's fault.
>
> The reason I care about the printk level is that this message would
> appear on the boot screen even if you set "quiet" kernel option
> (although the quiet level became adjustable recently).
>
>> +				return -ENODEV;
>> +			}
>> +			break;
>> +		case SND_SKL_PCI_BIND_LEGACY:
>> +			dev_warn(&pci->dev, "Module parameter forced binding with HDaudio legacy, bypassed detection logic\n");
> Ditto.  This is information-only.
>
>> +			break;
>> +		case SND_SKL_PCI_BIND_ASOC:
>> +			dev_err(&pci->dev, "Module parameter forced binding with SKL+ ASoC driver, aborting probe\n");
>> +			return -ENODEV;
> Ditto.
>
>> +		default:
>> +			dev_err(&pci->dev, "invalid value for skl_pci_binding module parameter, ignored\n");
>> +			break;
> This should be kept as error.
>
> The similar logic applied to asoc driver.
>
> In general, the dev_err() and dev_warn() should be used for the things
> the user really has to care explicitly.
>
>
> thanks,
>
> Takashi
