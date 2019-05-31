From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: hda: Fix COMPILE_TEST
 build error
Date: Fri, 31 May 2019 13:44:40 -0500
Message-ID: <e20ff9a0-0928-2864-c451-a24d86ccfc5c@linux.intel.com>
References: <20190531142526.12712-1-yuehaibing@huawei.com>
 <s5hlfymsnfa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlfymsnfa.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, yingjiang.zhu@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 5/31/19 9:34 AM, Takashi Iwai wrote:
> On Fri, 31 May 2019 16:25:26 +0200,
> YueHaibing wrote:
>>
>> while building without PCI:
>>
>> sound/soc/sof/intel/hda.o: In function `hda_dsp_probe':
>> hda.c:(.text+0x79c): undefined reference to `pci_ioremap_bar'
>> hda.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
>> hda.c:(.text+0x7c4): undefined reference to `pci_ioremap_bar'
>> hda.c:(.text+0x7c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   sound/soc/sof/intel/hda.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>> index 68db2ac..c1703c4 100644
>> --- a/sound/soc/sof/intel/hda.c
>> +++ b/sound/soc/sof/intel/hda.c
>> @@ -231,7 +231,9 @@ static int hda_init(struct snd_sof_dev *sdev)
>>   
>>   	/* initialise hdac bus */
>>   	bus->addr = pci_resource_start(pci, 0);
>> +#if IS_ENABLED(CONFIG_PCI)
>>   	bus->remap_addr = pci_ioremap_bar(pci, 0);
>> +#endif
>>   	if (!bus->remap_addr) {
>>   		dev_err(bus->dev, "error: ioremap error\n");
>>   		return -ENXIO;
>> @@ -458,7 +460,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>>   		goto hdac_bus_unmap;
>>   
>>   	/* DSP base */
>> +#if IS_ENABLED(CONFIG_PCI)
>>   	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
>> +#endif
>>   	if (!sdev->bar[HDA_DSP_BAR]) {
>>   		dev_err(sdev->dev, "error: ioremap error\n");
>>   		ret = -ENXIO;
> 
> IMO, this should be better addressed by fixing in linux/pci.h
> instead, something like below (totally untested).

Indeed. I wanted to first enable COMPILE_TEST for SOF and do a PCI 
cleanup in a second stage. It might take a while to synchronize those 
changes and check if there are additional functions needed by others.

> 
> 
> thanks,
> 
> Takashi
> 
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2005,8 +2005,19 @@ static inline void pci_mmcfg_late_init(void) { }
>   
>   int pci_ext_cfg_avail(void);
>   
> +#ifdef CONFIG_PCI
>   void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
>   void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
> +#else
> +static inline void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
> +{
> +	return NULL;
> +}
> +static inline void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
> +{
> +	return NULL;
> +}
> +#endif
>   
>   #ifdef CONFIG_PCI_IOV
>   int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
