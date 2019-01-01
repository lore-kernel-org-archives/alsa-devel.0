From: Mike Brady <mikebrady@eircom.net>
Subject: Re: [PATCH v2] ARM: staging: bcm2835-audio:
	interpolate audio delay
Date: Tue, 1 Jan 2019 10:02:30 +0000
Message-ID: <2BEB4E93-1280-47BE-906F-106D5FFCF5F0@eircom.net>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
 <s5h7ehgdiqq.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe05-2.mx.upcmail.net
 (vie01a-dmta-pe05-2.mx.upcmail.net [84.116.36.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 45F87267946
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2019 11:02:35 +0100 (CET)
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
 by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
 (envelope-from <mikebrady@eircom.net>) id 1geGsd-0007O4-GL
 for alsa-devel@alsa-project.org; Tue, 01 Jan 2019 11:02:35 +0100
In-Reply-To: <s5h7ehgdiqq.wl-tiwai@suse.de>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, f.fainelli@gmail.com, julia.lawall@lip6.fr, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, nishka.dasgupta_ug18@ashoka.edu.in, Kirill Marinushkin <k.marinushkin@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Apologies for the delay coming back to this.

Having had a long look at the further implications of this proposed change, I would like to withdraw the suggested patch.

I agree that is would seem excessive to have to change the PCM core to accommodate it. Furthermore, the idea only works if is is legitimate to assume that frames are smoothly consumed in the interpolation interval. If that assumption were not to hold for some reason, then the delay reported would be wrong.

Thanks to everyone for their comments and inputs.

Regards
Mike



> On 13 Nov 2018, at 16:50, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Sun, 11 Nov 2018 19:21:29 +0100,
> Mike Brady wrote:
>> 
>> /* hardware definition */
>> static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
>> 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>> -		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
>> +		 SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_DRAIN_TRIGGER |
>> +		 SNDRV_PCM_INFO_SYNC_APPLPTR),
> 
> As already mentioned, the addition of SNDRV_PCM_INFO_BATCH should be
> irrelevant with this change.  Please create another patch to add this
> and clarify it in the changelog.
> 
>> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
>> index 4e6110d778bd..574df7d7a1fa 100644
>> --- a/sound/core/pcm_lib.c
>> +++ b/sound/core/pcm_lib.c
>> @@ -229,19 +229,38 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
>> 		(runtime->audio_tstamp_report.actual_type ==
>> 			SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
>> 
>> -		/*
>> -		 * provide audio timestamp derived from pointer position
>> -		 * add delay only if requested
>> -		 */
>> +		// provide audio timestamp derived from pointer position
>> 
>> 		audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
>> 
>> -		if (runtime->audio_tstamp_config.report_delay) {
>> +		/*
>> +		 * If the runtime->delay is greater than zero, it's a
>> +		 * genuine delay, e.g. a delay due to a hardware fifo.
>> +		 *
>> +		 * But if the runtime->delay is less than zero, it's an
>> +		 * interpolated estimate of the number of frames output
>> +		 * since the hardware pointer was last updated.
>> +		 *
>> +		 * It would be calculated in the pointer callback.
>> +		 * For example, for the bcm_2835 driver, it is calculated in
>> +		 * snd_bcm2835_pcm_pointer().
>> +		 */
>> +
>> +		if (runtime->delay < 0) {
>> +			// The delay is an interpolated estimate...
>> 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> -				audio_frames -=  runtime->delay;
>> -			else
>> -				audio_frames +=  runtime->delay;
>> +				audio_frames += runtime->delay;
>> +		} else {
>> +			// The delay is a real delay. Add it if requested.
>> +			if (runtime->audio_tstamp_config.report_delay) {
>> +				if (substream->stream ==
>> +				    SNDRV_PCM_STREAM_PLAYBACK)
>> +					audio_frames -=  runtime->delay;
>> +				else
>> +					audio_frames +=  runtime->delay;
>> +			}
>> 		}
> 
> Well, honestly speaking, I'm really not fond of changing the PCM core
> just for this.
> 
> Can we make bcm audio driver providing the finer pointer update
> instead?  If we have a module option to disable that behavior, it's an
> enough excuse in case anyone really cares about the accuracy.
> 
> 
> thanks,
> 
> Takashi
