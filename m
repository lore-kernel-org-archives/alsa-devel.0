From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v3 05/14] ASoC: SOF:
 Add PCM operations support
Date: Wed, 12 Dec 2018 09:29:23 -0600
Message-ID: <0e727a47-26b1-7772-1a8c-ca49a0e805af@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0q7uq5l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hd0q7uq5l.wl-tiwai@suse.de>
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


On 12/12/18 2:04 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:09 +0100,
> Pierre-Louis Bossart wrote:
>> +	/* number of pages should be rounded up */
>> +	if (runtime->dma_bytes % PAGE_SIZE)
>> +		pcm.params.buffer.pages = (runtime->dma_bytes / PAGE_SIZE) + 1;
>> +	else
>> +		pcm.params.buffer.pages = runtime->dma_bytes / PAGE_SIZE;
> There is likely some nice macro for this :)
Yes, will fix.
>
>> +	/* firmware already configured host stream */
>> +	ret = snd_sof_pcm_platform_hw_params(sdev,
>> +					     substream,
>> +					     params,
>> +					     &pcm.params);
>> +	dev_dbg(sdev->dev, "stream_tag %d", pcm.params.stream_tag);
> This error can be ignored?
will double-check.
>
>> +	/* send IPC to the DSP */
>> +	ret = sof_ipc_tx_message(sdev->ipc, pcm.hdr.cmd, &pcm, sizeof(pcm),
>> +				 &ipc_params_reply, sizeof(ipc_params_reply));
> This error value isn't evaluated immediately but passed until the
> last.  Is it intentional?
Not sure, will double-check. Now that I read the code again this looks 
odds, and if it was intentional then we need an explicit comment. Thanks 
for the sighting.
>
>> +	/* validate offset */
>> +	posn_offset = ipc_params_reply.posn_offset;
>> +
>> +	/* check if offset is overflow or it is not aligned */
>> +	if (posn_offset > sdev->stream_box.size ||
>> +	    posn_offset % sizeof(struct sof_ipc_stream_posn) != 0) {
>> +		dev_err(sdev->dev, "error: got wrong posn offset 0x%x for PCM %d\n",
>> +			posn_offset, ret);
>> +		return ret;
> Here you return an error after checking more things.
>
>> +	}
>> +	spcm->posn_offset[substream->stream] =
>> +		sdev->stream_box.offset + posn_offset;
>> +
>> +	/* save pcm hw_params */
>> +	memcpy(&spcm->params[substream->stream], params, sizeof(*params));
>> +
>> +	return ret;
> Even here returns an error after saving as if done properly.
will double-check this entire sequence.
>
>
>> +static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>> +{
> ....
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +
>> +		/* check if the stream hw_params needs to be restored */
>> +		if (spcm->restore_stream[substream->stream]) {
>> +
>> +			/* restore hw_params */
>> +			ret = sof_restore_hw_params(substream, spcm, sdev);
> This calls the hw_params that is supposed to be non-atomic.
>
>> +	snd_sof_pcm_platform_trigger(sdev, substream, cmd);
>> +
>> +	/* send IPC to the DSP */
>> +	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
>> +				 sizeof(stream), &reply, sizeof(reply));
>> +
>> +	return ret;
> ... so the whole trigger action is non-atomic PCM only?
Not sure if I fully understand your point here. The trigger does indeed 
need an IPC to proceed, but the front-ends are marked as such with the 
.nonatomic field set to true. Not sure how different this is from 
existing atom/sst or Skylake drivers.
