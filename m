From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v5 09/14] ASoC: SOF:
 Add firmware loader support
Date: Thu, 4 Apr 2019 08:59:46 -0500
Message-ID: <c9f87678-7387-8927-9bc1-803b879a7815@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-10-pierre-louis.bossart@linux.intel.com>
 <s5hy34pc36h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hy34pc36h.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static int get_ext_windows(struct snd_sof_dev *sdev,
>> +			   struct sof_ipc_ext_data_hdr *ext_hdr)
>> +{
>> +	struct sof_ipc_window *w = (struct sof_ipc_window *)ext_hdr;
> 
> In general it's safer to use container_of() than the forced cast, and...

yes

> 
>> +/* parse the extended FW boot data structures from FW boot message */
>> +int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
>> +{
>> +	struct sof_ipc_ext_data_hdr *ext_hdr;
>> +	void *ext_data;
>> +	int ret = 0;
>> +
>> +	ext_data = kzalloc(PAGE_SIZE, GFP_KERNEL);
>> +	if (!ext_data)
>> +		return -ENOMEM;
>> +
>> +	/* get first header */
>> +	snd_sof_dsp_block_read(sdev, bar, offset, ext_data,
>> +			       sizeof(*ext_hdr));
>> +	ext_hdr = (struct sof_ipc_ext_data_hdr *)ext_data;
> 
> The cast isn't needed from a void pointer.  The whole SOF codes have
> way too many unneeded cast.  Let's reduce.

ok. we've removed quite a few casts but that's obviously not finished.

> 
>> +/* generic module parser for mmaped DSPs */
>> +int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
>> +				struct snd_sof_mod_hdr *module)
>> +{
>> +	struct snd_sof_blk_hdr *block;
>> +	int count;
>> +	u32 offset;
>> +	size_t remaining;
>> +
>> +	dev_dbg(sdev->dev, "new module size 0x%x blocks 0x%x type 0x%x\n",
>> +		module->size, module->num_blocks, module->type);
>> +
>> +	block = (struct snd_sof_blk_hdr *)((u8 *)module + sizeof(*module));
>> +
>> +	/* module->size doesn't include header size */
>> +	remaining = module->size;
>> +	for (count = 0; count < module->num_blocks; count++) {
>> +		/* minus header size of block */
>> +		remaining -= sizeof(*block);
>> +		if (remaining < block->size) {
>> +			dev_err(sdev->dev, "error: not enough data remaining\n");
>> +			return -EINVAL;
>> +		}
> 
> remaining is unsigned, so a negative check doesn't work here.
> Hence you need the explicit underflow check.

yes, probably need ssize_t here.

> 
>> +static int load_modules(struct snd_sof_dev *sdev, const struct firmware *fw)
>> +{
>> +	struct snd_sof_fw_header *header;
>> +	struct snd_sof_mod_hdr *module;
>> +	int (*load_module)(struct snd_sof_dev *sof_dev,
>> +			   struct snd_sof_mod_hdr *hdr);
>> +	int ret, count;
>> +	size_t remaining;
>> +
>> +	header = (struct snd_sof_fw_header *)fw->data;
>> +	load_module = sof_ops(sdev)->load_module;
>> +	if (!load_module)
>> +		return -EINVAL;
>> +
>> +	/* parse each module */
>> +	module = (struct snd_sof_mod_hdr *)((u8 *)(fw->data) + sizeof(*header));
>> +	remaining = fw->size - sizeof(*header);
> 
> The size check should be more strict (e.g. here remaining might become
> negative).

yes.

> 
>> +int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
>> +{
>> +	struct snd_sof_pdata *plat_data = sdev->pdata;
>> +	const char *fw_filename;
>> +	int ret;
>> +
>> +	/* set code loading condition to true */
>> +	sdev->code_loading = 1;
>> +
>> +	/* Don't request firmware again if firmware is already requested */
>> +	if (plat_data->fw)
>> +		return 0;
>> +
>> +	fw_filename = devm_kasprintf(sdev->dev, GFP_KERNEL,
>> +				     "%s/%s",
>> +				     plat_data->fw_filename_prefix,
>> +				     plat_data->fw_filename);
>> +	if (!fw_filename)
>> +		return -ENOMEM;
>> +
>> +	ret = request_firmware(&plat_data->fw, fw_filename, sdev->dev);
>> +
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: request firmware %s failed err: %d\n",
>> +			fw_filename, ret);
>> +	}
>> +	return ret;
> 
> Hrm, any need of devm_kasprintf() here?  That is, do we need to keep
> this string after the call of request_firmware()?  It doesn't make
> sense if we need it only temporarily.

Good point, this can be simplified.
