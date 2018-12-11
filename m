From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware loader
 support
Date: Tue, 11 Dec 2018 17:54:02 -0600
Message-ID: <c3389d5c-f960-d067-b560-47af97353017@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
 <20181211223829.GJ10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211223829.GJ10650@smile.fi.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/11/18 4:38 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:13PM -0600, Pierre-Louis Bossart wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> The firmware loader exports APIs that can be called by core to load and
>> process multiple different file formats.
>> +static int get_ext_windows(struct snd_sof_dev *sdev,
>> +			   struct sof_ipc_ext_data_hdr *ext_hdr)
>> +{
>> +	struct sof_ipc_window *w = (struct sof_ipc_window *)ext_hdr;
>> +
>> +	int ret = 0;
> I don't see how it's used. Perhaps you need to check code with `make W=1`.

Darn, we missed this one. I thought we were using W=1 on github but we 
aren't, this will be fixed.

Though W=1 doesn't report this one, so need to re-inspect this. Thanks 
for the sighting.

>
>> +	size_t size;
>> +
>> +	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
>> +		return -EINVAL;
>> +
>> +	size = sizeof(*w) + sizeof(struct sof_ipc_window_elem) * w->num_windows;
>> +
>> +	/* keep a local copy of the data */
>> +	sdev->info_window = kmemdup(w, size, GFP_KERNEL);
>> +	if (!sdev->info_window)
>> +		return -ENOMEM;
>> +
>> +	return ret;
>> +}
>> +			dev_warn(sdev->dev,
>> +				 "warning: block %d size zero\n", count);
>> +			dev_warn(sdev->dev, " type 0x%x offset 0x%x\n",
>> +				 block->type, block->offset);
> Hmm... Why do we need a kernel level duplication in words?
Not sure I get this one, it's just a warning message where you don't 
copy a block of size zero into the target memory.
>
>> +int snd_sof_load_firmware(struct snd_sof_dev *sdev)
>> +{
>> +	dev_dbg(sdev->dev, "loading firmware\n");
> Noise.
> Better to introduce a trace points and drop all these kind of messages.

it's not that bad, most people understand what dmesg is, it happens once 
and only if you have dynamic debug.

At some point we also thought about something like drm_debug where you 
can specify which parts you are interested in, in addition to the 
verbosity level.

>
>> +
>> +	if (sdev->ops->load_firmware)
>> +		return sdev->ops->load_firmware(sdev);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(snd_sof_load_firmware);
