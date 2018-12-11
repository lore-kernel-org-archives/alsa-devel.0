From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 01/14] ASoC: SOF: Add Sound Open
	Firmware driver core
Date: Tue, 11 Dec 2018 17:20:32 -0600
Message-ID: <956668c0-1bfa-2e81-6217-94f6ea21288a@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-2-pierre-louis.bossart@linux.intel.com>
 <20181211222030.GG10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211222030.GG10650@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the late night review Andy :-)

On 12/11/18 4:20 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:05PM -0600, Pierre-Louis Bossart wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> The Sound Open Firmware driver core is a generic architecture
>> independent layer that allows SOF to be used on many different different
>> architectures and platforms. It abstracts DSP operations and IO methods
>> so that the target DSP can be an internal memory mapped or external SPI
>> or I2C based device. This abstraction also allows SOF to be run on
>> many different VMs on the same physical HW.
>>
>> SOF also requires some data in ASoC PCM runtime data for looking up
>> SOF data during ASoC PCM operations.
>> +/* SOF defaults if not provided by the platform in ms */
>> +#define TIMEOUT_DEFAULT_IPC	5
>> +#define TIMEOUT_DEFAULT_BOOT	100
> Perhaps _MS at the end?
ok
>
>> +struct snd_sof_dai *snd_sof_find_dai(struct snd_sof_dev *sdev,
>> +				     char *name)
>> +{
>> +	struct snd_sof_dai *dai = NULL;
>> +
>> +	list_for_each_entry(dai, &sdev->dai_list, list) {
>> +		if (!dai->name)
>> +			continue;
>> +
>> +		if (strcmp(name, dai->name) == 0)
>> +			return dai;
> Perhaps
>
> 	if (dai->name && strcmp(...))
ok
>
>> +	}
>> +
>> +	return NULL;
>> +}
>> +int snd_sof_create_page_table(struct snd_sof_dev *sdev,
>> +			      struct snd_dma_buffer *dmab,
>> +			      unsigned char *page_table, size_t size)
>> +{
>> +	int i, pages;
>> +
>> +	pages = snd_sgbuf_aligned_pages(size);
>> +
>> +	dev_dbg(sdev->dev, "generating page table for %p size 0x%zx pages %d\n",
>> +		dmab->area, size, pages);
>> +
>> +	for (i = 0; i < pages; i++) {
>> +		u32 idx = (((i << 2) + i)) >> 1;
> Looks like
>
> 	u32 idx = (5 * i) >> 1;
Yes, but we'd also want an explanation of what we try to multiply by 
2.5... Liam or Keyon, can you chime in?

>
>> +		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
>> +		u32 *pg_table;
>> +
>> +		dev_vdbg(sdev->dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
>> +
>> +		pg_table = (u32 *)(page_table + idx);
>> +
>> +		if (i & 1)
>> +			*pg_table |= (pfn << 4);
>> +		else
>> +			*pg_table |= pfn;
>> +	}
>> +
>> +	return pages;
>> +}
>> +	if (plat_data->type == SOF_DEVICE_PCI)
>> +		sdev->pci = container_of(plat_data->dev, struct pci_dev, dev);
> Why not to use generic functions?
> 	dev_is_pci()
> 	to_pci_dev()
ok
>
>> +	/* register machine driver, pass machine info as pdata */
>> +	plat_data->pdev_mach =
>> +		platform_device_register_data(sdev->dev, drv_name,
>> +					      -1, mach, size);
> PLATFORM_DEVID_AUTO (IIRC the name)?
did you mean replace -1 by PLATFORM_DEVID_NONE?
>
>> +static int sof_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_sof_dev *sdev = dev_get_drvdata(&pdev->dev);
>> +	struct snd_sof_pdata *pdata = sdev->pdata;
>> +
>> +	if (pdata && !IS_ERR(pdata->pdev_mach))
>> +		platform_device_unregister(pdata->pdev_mach);
> I'm wondering if pdata could be ever NULL here.
I didn't find an error flow that yields NULL but Liam reported some 
issues that made no sense so might be safer with NULL
> Also, as I mentioned internally the patch to accept error pointers would be in
> v4.21.
Indeed, but I can't rely on this just yet.
>
>> +
>> +	snd_soc_unregister_component(&pdev->dev);
>> +	snd_sof_fw_unload(sdev);
>> +	snd_sof_ipc_free(sdev);
>> +	snd_sof_free_debug(sdev);
>> +	snd_sof_free_trace(sdev);
>> +	snd_sof_remove(sdev);
>> +	return 0;
>> +}
>> +
>> +void snd_sof_shutdown(struct device *dev)
>> +{
>> +}
>> +EXPORT_SYMBOL(snd_sof_shutdown);
> No need to provide an empty stub. Why not to add when it would have something useful?
ok
>
>> +/* max BARs mmaped devices can use */
>> +#define SND_SOF_BARS	8
>> +
>> +/* time in ms for runtime suspend delay */
>> +#define SND_SOF_SUSPEND_DELAY	2000
> _MS ?
ok
>
>> +	struct mutex mutex;	/* access mutex */
>> +	struct list_head list;	/* list in sdev pcm list */
>> +	struct snd_pcm_hw_params params[2];
>> +	int restore_stream[2]; /* restore hw_params for paused stream */
>> +	u32 readback_offset; /* offset to mmaped data if used */
>> +	struct sof_ipc_ctrl_data *control_data;
>> +	u32 size;	/* cdata size */
>> +	enum sof_ipc_ctrl_cmd cmd;
>> +	u32 *volume_table; /* volume table computed from tlv data*/
>> +
>> +	struct mutex mutex;	/* access mutex */
>> +	struct list_head list;	/* list in sdev control list */
