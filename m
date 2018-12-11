From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Tue, 11 Dec 2018 17:38:23 -0600
Message-ID: <800b69da-8076-cacd-68a5-112cfa18dd7f@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <20181211225733.GK10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211225733.GK10650@smile.fi.intel.com>
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


On 12/11/18 4:57 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:08PM -0600, Pierre-Louis Bossart wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> Define an IPC ABI for all host <--> DSP communication. This ABI should
>> be transport agnostic. i.e. it should work on MMIO and SPI/I2C style
>> interfaces.
>> + /* ssc1: TINTE */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_TINTE		(1 << 0)
>> + /* ssc1: PINTE */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_PINTE		(1 << 1)
>> + /* ssc2: SMTATF */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_SMTATF		(1 << 2)
>> + /* ssc2: MMRATF */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_MMRATF		(1 << 3)
>> + /* ssc2: PSPSTWFDFD */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_PSPSTWFDFD	(1 << 4)
>> + /* ssc2: PSPSRWFDFD */
>> +#define SOF_DAI_INTEL_SSP_QUIRK_PSPSRWFDFD	(1 << 5)
> Style mismatch. Looks like a candidate for BIT()
Yes but no. This comes from firmware definitions, so it's easier to 
leave them alone. Changing the kernel side of the IPC for style reasons 
just adds more work and chances of divergence.
>
>> +#define SOF_DAI_FMT_FORMAT_MASK		0x000f
>> +#define SOF_DAI_FMT_CLOCK_MASK		0x00f0
>> +#define SOF_DAI_FMT_INV_MASK		0x0f00
>> +#define SOF_DAI_FMT_MASTER_MASK		0xf000
> GENMASK() ?
>
>> +/* flags indicating which time stamps are in sync with each other */
>> +#define	SOF_TIME_HOST_SYNC	(1 << 0)
>> +#define	SOF_TIME_DAI_SYNC	(1 << 1)
>> +#define	SOF_TIME_WALL_SYNC	(1 << 2)
>> +#define	SOF_TIME_STAMP_SYNC	(1 << 3)
>> +
>> +/* flags indicating which time stamps are valid */
>> +#define	SOF_TIME_HOST_VALID	(1 << 8)
>> +#define	SOF_TIME_DAI_VALID	(1 << 9)
>> +#define	SOF_TIME_WALL_VALID	(1 << 10)
>> +#define	SOF_TIME_STAMP_VALID	(1 << 11)
>> +
>> +/* flags indicating time stamps are 64bit else 3use low 32bit */
>> +#define	SOF_TIME_HOST_64	(1 << 16)
>> +#define	SOF_TIME_DAI_64		(1 << 17)
>> +#define	SOF_TIME_WALL_64	(1 << 18)
>> +#define	SOF_TIME_STAMP_64	(1 << 19)
> BIT() ?
>
>
>> +#define SOF_IPC_PANIC_MAGIC_MASK		0x0ffff000
>> +#define SOF_IPC_PANIC_CODE_MASK			0x00000fff
> GENMASK() ?
same for all, when the definitions are shared with firmware it's better 
to keep the values as is.
>
>> +#define IPC_TIMEOUT_MSECS	300
> Simple _MS ?
yes.
>
>> +/* find original TX message from DSP reply */
>> +static struct snd_sof_ipc_msg *sof_ipc_reply_find_msg(struct snd_sof_ipc *ipc,
>> +						      u32 header)
>> +{
>> +	struct snd_sof_dev *sdev = ipc->sdev;
>> +	struct snd_sof_ipc_msg *msg;
>> +
>> +	header = SOF_IPC_MESSAGE_ID(header);
>> +
>> +	if (list_empty(&ipc->reply_list))
>> +		goto err;
> Redundant. list_for_each_*() have this check already.
ok, nice catch.
>
>> +
>> +	list_for_each_entry(msg, &ipc->reply_list, list) {
>> +		if (SOF_IPC_MESSAGE_ID(msg->header) == header)
>> +			return msg;
>> +	}
>> +
>> +err:
>> +	dev_err(sdev->dev, "error: rx list empty but received 0x%x\n",
>> +		header);
>> +	return NULL;
>> +}
>> +int snd_sof_ipc_valid(struct snd_sof_dev *sdev)
>> +{
>> +	struct sof_ipc_fw_ready *ready = &sdev->fw_ready;
>> +	struct sof_ipc_fw_version *v = &ready->version;
>> +
>> +	dev_info(sdev->dev,
>> +		 " Firmware info: version %d:%d:%d-%s\n",  v->major, v->minor,
> Indentation issues.
I believe they are intentional, but that's Liam's part.
>
>> +		 v->micro, v->tag);
>> +	dev_info(sdev->dev,
>> +		 " Firmware: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
>> +		 SOF_ABI_VERSION_MAJOR(v->abi_version),
>> +		 SOF_ABI_VERSION_MINOR(v->abi_version),
>> +		 SOF_ABI_VERSION_PATCH(v->abi_version),
>> +		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>> +
>> +	if (SOF_ABI_VERSION_INCOMPATIBLE(SOF_ABI_VERSION, v->abi_version)) {
>> +		dev_err(sdev->dev, "error: incompatible FW ABI version\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ready->debug.bits.build) {
>> +		dev_info(sdev->dev,
>> +			 " Firmware debug build %d on %s-%s - options:\n"
>> +			 "  GDB: %s\n"
>> +			 "  lock debug: %s\n"
>> +			 "  lock vdebug: %s\n",
>> +			 v->build, v->date, v->time,
>> +			 ready->debug.bits.gdb ? "enabled" : "disabled",
>> +			 ready->debug.bits.locks ? "enabled" : "disabled",
>> +			 ready->debug.bits.locks_verbose ?
>> +			 "enabled" : "disabled");
> I would leave it on one line (only 3 characters more, but better readability).
>
> 			 ready->debug.bits.locks_verbose ? "enabled" : "disabled");
That must be a result of me asking folks to run checkpatch.pl --strict...
>
>> +	}
>> +
>> +	/* copy the fw_version into debugfs at first boot */
>> +	memcpy(&sdev->fw_version, v, sizeof(*v));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(snd_sof_ipc_valid);
>> +	dev_dbg(sdev->dev, "pre-allocate %d IPC messages\n",
>> +		IPC_EMPTY_LIST_SIZE);
> Noise.
ok
>
>> +
>> +	/* pre-allocate message data */
>> +	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
>> +		msg->msg_data = devm_kzalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);
>> +		if (!msg->msg_data)
>> +			return NULL;
>> +
>> +		msg->reply_data = devm_kzalloc(sdev->dev, PAGE_SIZE,
>> +					       GFP_KERNEL);
>> +		if (!msg->reply_data)
>> +			return NULL;
> Can't you just get enough (non-continuous?) pages at once via get_free_pages interface?
> I didn't know that one, so, consider rather a way to look into.
Dunno either, maybe something for Liam to look at?
>
>> +
>> +		init_waitqueue_head(&msg->waitq);
>> +		list_add(&msg->list, &ipc->empty_list);
>> +		msg++;
>> +	}
>> +
>> +	return ipc;
>> +}
>> +EXPORT_SYMBOL(snd_sof_ipc_init);
