From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v3 09/14] ASoC: SOF:
 Add firmware loader support
Date: Wed, 12 Dec 2018 10:06:10 -0600
Message-ID: <3346a045-20cb-a664-2339-e1a9ffb6100d@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
 <s5htvjjj8ei.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5htvjjj8ei.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/12/18 5:23 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:13 +0100,
> Pierre-Louis Bossart wrote:
>> +/* generic module parser for mmaped DSPs */
>> +int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
>> +				struct snd_sof_mod_hdr *module)
>> +{
>> +	struct snd_sof_blk_hdr *block;
>> +	int count;
>> +	u32 offset;
>> +
>> +	dev_dbg(sdev->dev, "new module size 0x%x blocks 0x%x type 0x%x\n",
>> +		module->size, module->num_blocks, module->type);
>> +
>> +	block = (void *)module + sizeof(*module);
>> +
>> +	for (count = 0; count < module->num_blocks; count++) {
> Need a sanity check that it won't go beyond the actual firmware size.
> User may pass a malicious module data, e.g. with extra large
> num_blocks.
Good point, will check.
>
>> +		if (block->size == 0) {
>> +			dev_warn(sdev->dev,
>> +				 "warning: block %d size zero\n", count);
>> +			dev_warn(sdev->dev, " type 0x%x offset 0x%x\n",
>> +				 block->type, block->offset);
>> +			continue;
>> +		}
>> +
>> +		switch (block->type) {
>> +		case SOF_BLK_IMAGE:
>> +		case SOF_BLK_CACHE:
>> +		case SOF_BLK_REGS:
>> +		case SOF_BLK_SIG:
>> +		case SOF_BLK_ROM:
>> +			continue;	/* not handled atm */
>> +		case SOF_BLK_TEXT:
>> +		case SOF_BLK_DATA:
>> +			offset = block->offset;
>> +			break;
>> +		default:
>> +			dev_err(sdev->dev, "error: bad type 0x%x for block 0x%x\n",
>> +				block->type, count);
>> +			return -EINVAL;
>> +		}
>> +
>> +		dev_dbg(sdev->dev,
>> +			"block %d type 0x%x size 0x%x ==>  offset 0x%x\n",
>> +			count, block->type, block->size, offset);
>> +
>> +		snd_sof_dsp_block_write(sdev, offset,
>> +					(void *)block + sizeof(*block),
>> +					block->size);
>> +
>> +		/* next block */
>> +		block = (void *)block + sizeof(*block) + block->size;
> This may lead to an unaligned access.
> Also how is the endianess guaranteed?
Will check, valid points.
