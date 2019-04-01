From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 01/14] ASoC: SOF: Add Sound Open
 Firmware driver core
Date: Mon, 1 Apr 2019 13:12:37 -0400
Message-ID: <5765a2ba-eec3-03e9-7963-7196385ae390@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-2-pierre-louis.bossart@linux.intel.com>
 <s5hva01k6pc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hva01k6pc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi for your review!

>> The Sound Open Firmware driver core is a generic architecture
>> independent layer that allows SOF to be used on many different different
> 
> One different is enough.

Indeed

>> +struct snd_sof_pcm *snd_sof_find_spcm_name(struct snd_sof_dev *sdev,
>> +					   char *name)
> 
> Make it const char *.

yep, will fix all occurrences

>> +{
>> +	struct snd_sof_pcm *spcm = NULL;
> 
> Superfluous initialization.

indeed, that was missed. will fix all occurrences, thanks!

>> +int snd_sof_get_status(struct snd_sof_dev *sdev, u32 panic_code,
>> +		       u32 tracep_code, void *oops,
>> +		       struct sof_ipc_panic_info *panic_info,
>> +		       void *stack, size_t stack_words)
>> +{
>> +	u32 code;
>> +	int i;
>> +
>> +	/* is firmware dead ? */
>> +	if ((panic_code & SOF_IPC_PANIC_MAGIC_MASK) != SOF_IPC_PANIC_MAGIC) {
>> +		dev_err(sdev->dev, "error: unexpected fault 0x%8.8x trace 0x%8.8x\n",
>> +			panic_code, tracep_code);
>> +		return 0; /* no fault ? */
>> +	}
> ....
>> +out:
>> +	dev_err(sdev->dev, "error: panic happen at %s:%d\n",
>> +		panic_info->filename, panic_info->linenum);
>> +	sof_oops(sdev, oops);
>> +	sof_stack(sdev, oops, stack, stack_words);
>> +	return -EFAULT;
>> +}
> 
> So this function returns -EFAULT for the normal operation while 0 for
> unexpected case?  I see that no callers actually check the return
> value, but it's some what unintuitive.  Worth for adding a comment
> about the return code.

Good point. Will need to re-look at the flow. At some point, this is the 
sort of error that should lead to firmware recovery, where the driver 
takes the initiative of resetting hardware and reinitializing. We know 
this is on the list of features to be implemented but it's not ready yet.
