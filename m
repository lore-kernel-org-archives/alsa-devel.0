From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 14/14] ASoC: SOF: Add utils
Date: Tue, 11 Dec 2018 18:06:43 -0600
Message-ID: <b889175e-91ad-3662-ec13-cfe76918d203@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-15-pierre-louis.bossart@linux.intel.com>
 <20181211230609.GL10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211230609.GL10650@smile.fi.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/11/18 5:06 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:18PM -0600, Pierre-Louis Bossart wrote:
>> Helpers to set-up back-ends, create platform devices and common
>> IO/block read/write operations
>> +int sof_bes_setup(struct device *dev, struct snd_sof_dsp_ops *ops,
>> +		  struct snd_soc_dai_link *links, int link_num,
>> +		  struct snd_soc_card *card)
>> +{
>> +	char name[32];
>> +	int i;
>> +
>> +	if (!ops || !links || !card)
>> +		return -EINVAL;
>> +
>> +	/* set up BE dai_links */
>> +	for (i = 0; i < link_num; i++) {
>> +		snprintf(name, 32, "NoCodec-%d", i);
> sizeof(name) ?
yes
>
>> +		links[i].name = devm_kstrdup(dev, name, GFP_KERNEL);
>> +		if (!links[i].name)
>> +			return -ENOMEM;
> ...or better devm_kasprintf().
and yes
>
>> +
>> +		links[i].id = i;
>> +		links[i].no_pcm = 1;
>> +		links[i].cpu_dai_name = ops->drv[i].name;
>> +		links[i].platform_name = "sof-audio";
>> +		links[i].codec_dai_name = "snd-soc-dummy-dai";
>> +		links[i].codec_name = "snd-soc-dummy";
>> +		links[i].dpcm_playback = 1;
>> +		links[i].dpcm_capture = 1;
>> +	}
>> +
>> +	card->dai_link = links;
>> +	card->num_links = link_num;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(sof_bes_setup);
>> +
>> +/* register sof platform device */
>> +int sof_create_platform_device(struct sof_platform_priv *priv)
>> +{
>> +	struct snd_sof_pdata *sof_pdata = priv->sof_pdata;
>> +	struct device *dev = sof_pdata->dev;
>> +
>> +	priv->pdev_pcm =
>> +		platform_device_register_data(dev, "sof-audio", -1,
>> +					      sof_pdata, sizeof(*sof_pdata));
>> +	if (IS_ERR(priv->pdev_pcm)) {
>> +		dev_err(dev, "error: cannot register device sof-audio. Error %d\n",
>> +			(int)PTR_ERR(priv->pdev_pcm));
> Instead of casting perhaps use %ld?
yes
>
>> +		return PTR_ERR(priv->pdev_pcm);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(sof_create_platform_device);
>> +void sof_io_write64(struct snd_sof_dev *sdev, void __iomem *addr, u64 value)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	writeq(value, addr);
>> +#else
>> +	memcpy_toio(addr, &value, sizeof(value));
>> +#endif
> This ifdef sounds strange.
> Just include io64-nonatomic-lo-hi.h and use readq() w/o limitations.

ah yes. We added readq/writeq following your initial feedback, which 
broke ARCH=i386 and that was added as a workaround.


>
>> +}
>> +EXPORT_SYMBOL(sof_io_write64);
>> +
>> +u64 sof_io_read64(struct snd_sof_dev *sdev, void __iomem *addr)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return readq(addr);
>> +#else
>> +	u64 val;
>> +
>> +	memcpy_fromio(&val, addr, sizeof(val));
>> +	return val;
>> +#endif
> Ditto.
>
>> +}
>> +EXPORT_SYMBOL(sof_io_read64);
>> +		affected_mask = (1 << (8 * n)) - 1;
>> +
>> +		/* first read the 32bit data of dest, then change affected
>> +		 * bytes, and write back to dest. For unaffected bytes, it
>> +		 * should not be changed
>> +		 */
>> +		__ioread32_copy(&tmp, dest + m * 4, 1);
>> +		tmp &= ~affected_mask;
>> +
>> +		tmp |= *(u32 *)(src_byte + m * 4) & affected_mask;
>> +		__iowrite32_copy(dest + m * 4, &tmp, 1);
> Ain't these equivalents to simple ioread32() / iowrite32() ?
They are. We removed a loop but the this can be further simplified 
indeed. Thanks for finding this.
>
