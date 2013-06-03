From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 6/8] add PCM interface
Date: Mon, 03 Jun 2013 13:18:50 +0200
Message-ID: <51AC7B9A.7040408@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370102158-24389-7-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-7-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> + * Additionally, according to AudioFire Owner's Manual Version 2.2,
> + * the number of PCM channels for digital input has more restriction
> + *  depending on which digital interface is selected.
> + *  - S/PDIF coaxial and optical	: use input 1-2
> + *  - ADAT optical with 32.0-48.0 kHz	: use input 1-8
> + *  - ADAT optical with 88.2-96.0 kHz	: use input 1-4 (S/MUX format)
> + * If these restriction is applied, the number of channels in stream is decided
> + * according to above modes.
> + *
> + * Currently this module doesn't have rules for the latter.

Does the number of channels in the AMDTP stream change, or are those
channel still there, but filled with zeros?

> +pcm_init_hw_params(struct snd_efw *efw,
> +			struct snd_pcm_substream *substream)

> +		.info = SNDRV_PCM_INFO_MMAP |
> +			SNDRV_PCM_INFO_BATCH |
> +			SNDRV_PCM_INFO_INTERLEAVED |
> +			SNDRV_PCM_INFO_SYNC_START |
> +			SNDRV_PCM_INFO_FIFO_IN_FRAMES |
> +			/* for Open Sound System compatibility */
> +			SNDRV_PCM_INFO_MMAP_VALID |
> +			SNDRV_PCM_INFO_BLOCK_TRANSFER,

Set SNDRV_PCM_INFO_JOINT_DUPLEX to specify that the playback/capture
streams are somehow related (must use the same rate).

> +	/* format of PCM samples is 16bit or 24bit inner 32bit */
> +	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
> +				SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
> +	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
> +				SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);

This has nothing to do with the sample format.

The AMDTP code requires(?) buffers and periods to be aligned with
packets, so you need constraints for 8/16/32 *frames*.

> +	/*
> +	 * The same sampling rate must be used for transmit and receive stream
> +	 * as long as the streams include PCM samples
> +	 */
> +	if ((amdtp_stream_running(&efw->receive_stream) &&
> +	     amdtp_stream_pcm_running(&efw->receive_stream)) ||
> +	    (amdtp_stream_running(&efw->transmit_stream) &&
> +	     amdtp_stream_pcm_running(&efw->transmit_stream))) {
> +		err = snd_efw_command_get_sampling_rate(efw, &sampling_rate);
> +		if (err < 0)
> +			goto end;
> +		substream->runtime->hw.rate_min = sampling_rate;
> +		substream->runtime->hw.rate_max = sampling_rate;
> +	}

What is the purpose of the "Sampling Rate" mixer control?

> +pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct snd_efw *efw = substream->private_data;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		return amdtp_stream_pcm_pointer(&efw->receive_stream);
> +	else
> +		return amdtp_stream_pcm_pointer(&efw->transmit_stream);
> +}

If the playback/capture callbacks have nothing in common, just use two
functions.


Regards,
Clemens

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
