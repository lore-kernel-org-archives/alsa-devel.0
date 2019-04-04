From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v5 05/14] ASoC: SOF:
 Add PCM operations support
Date: Thu, 4 Apr 2019 08:53:34 -0500
Message-ID: <a91b54fd-3cdb-b229-4a45-e4917649fc60@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hd0m2caz6.wl-tiwai@suse.de>
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


>> +	/* container size */
>> +	switch (params_width(params)) {
>> +	case 16:
>> +		pcm.params.sample_container_bytes = 2;
>> +		break;
>> +	case 24:
>> +		pcm.params.sample_container_bytes = 4;
>> +		break;
>> +	case 32:
>> +		pcm.params.sample_container_bytes = 4;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> This can be simply snd_pcm_format_physical_width() / 8.

ok

> 
>> +static int sof_pcm_open(struct snd_pcm_substream *substream)
>> +{
> ....
>> +	/* set any runtime constraints based on topology */
>> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +				   SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
>> +				   le32_to_cpu(caps->period_size_min));
>> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +				   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
>> +				   le32_to_cpu(caps->period_size_min));
> 
> Is period_size_min in frames or in bytes?  The code below refers as
> byte size while this refers as frames, so they look inconsistent.

need to check, the topology files always mention frames not bytes.

> 
>> +
>> +	/* set runtime config */
>> +	runtime->hw.info = SNDRV_PCM_INFO_MMAP |
>> +			  SNDRV_PCM_INFO_MMAP_VALID |
>> +			  SNDRV_PCM_INFO_INTERLEAVED |
>> +			  SNDRV_PCM_INFO_PAUSE |
>> +			  SNDRV_PCM_INFO_RESUME |
>> +			  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP;
> 
> Does SOF support the full resume?  That is, the stream gets resumed at
> the exact position that was suspended.  Most devices can't, hence they
> don't set *_INFO_RESUME flag and let user-space restarting.

Ah this is interesting. All previous Intel drivers set this flag, 
baytrail/haswell/broadwell, atom-sst and skylake. Only Skylake+ devices 
can restart at exactly the right position, but it's my understanding 
that no one ever enabled this mode.

Now I see an awful amount of devices that set this INFO_RESUME flag, and 
I'd be surprised if they all supported a full resume, could it be that 
there's a requirement that fell between the cracks on this one?

> 
>> +	runtime->hw.period_bytes_min = le32_to_cpu(caps->period_size_min);
>> +	runtime->hw.period_bytes_max = le32_to_cpu(caps->period_size_max);
>> +	runtime->hw.periods_min = le32_to_cpu(caps->periods_min);
>> +	runtime->hw.periods_max = le32_to_cpu(caps->periods_max);
>> +	runtime->hw.buffer_bytes_max = le32_to_cpu(caps->buffer_size_max);
> 
> These refer as bytes...

will check as well.
