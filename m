From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 07/14] ASoC: SOF:
 Add DSP firmware logger support
Date: Thu, 14 Feb 2019 09:13:04 -0600
Message-ID: <ea5e19cc-8b60-c14e-6a88-b4f2fbce81ba@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
 <s5h7ee2zewj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h7ee2zewj.wl-tiwai@suse.de>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/14/19 7:19 AM, Takashi Iwai wrote:
> On Wed, 13 Feb 2019 23:07:27 +0100,
> Pierre-Louis Bossart wrote:
>>
>> +static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
>> +				   loff_t pos, size_t buffer_size)
>> +{
>> +	wait_queue_entry_t wait;
>> +
>> +	/*
>> +	 * If host offset is less than local pos, it means write pointer of
>> +	 * host DMA buffer has been wrapped. We should output the trace data
>> +	 * at the end of host DMA buffer at first.
>> +	 */
>> +	if (sdev->host_offset < pos)
>> +		return buffer_size - pos;
>> +
>> +	/* If there is available trace data now, it is unnecessary to wait. */
>> +	if (sdev->host_offset > pos)
>> +		return sdev->host_offset - pos;
>> +
>> +	/* wait for available trace data from FW */
>> +	init_waitqueue_entry(&wait, current);
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +	add_wait_queue(&sdev->trace_sleep, &wait);
>> +
>> +	if (signal_pending(current)) {
>> +		remove_wait_queue(&sdev->trace_sleep, &wait);
>> +	} else {
>> +		/* set timeout to max value, no error code */
>> +		schedule_timeout(MAX_SCHEDULE_TIMEOUT);
>> +		remove_wait_queue(&sdev->trace_sleep, &wait);
>> +	}
> 
> Can be slightly optimized here, e.g. no need of two
> remove_wait_queue() calls.


Yes. This was cleaned-up to remove a goto but we missed the common code. 
will fix

> 
>> +
>> +	/* return bytes available for copy */
>> +	if (sdev->host_offset < pos)
>> +		return buffer_size - pos;
>> +
>> +	return sdev->host_offset - pos;
> 
> Are these sdev->host_offset accesses race-free?
> 
> If I understand correctly, snd_sof_trace_update_pos() can be called at
> any time, and the offset might become inconsistent during these
> multiple references.


It's my understanding that there is a single trace stream and a single 
consumer (via a debugfs file), but will double check.
