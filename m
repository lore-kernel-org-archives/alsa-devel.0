From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/44] fireworks: Add PCM interface
Date: Sun, 06 Apr 2014 21:44:53 +0900
Message-ID: <53414C45.2070006@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-27-git-send-email-o-takashi@sakamocchi.jp>
 <533E71C8.9030606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 0508C26525F
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 14:44:58 +0200 (CEST)
In-Reply-To: <533E71C8.9030606@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Apr 4 2014 17:48), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> This commit adds a functionality to capture/playback PCM samples.
>>
>> +++ b/sound/firewire/fireworks/fireworks_pcm.c
>> +static unsigned int freq_table[] = {
>
> This table is never changed; it can be made const.

OK.

>> +static int
>> +hw_rule_xxxxx(struct snd_pcm_hw_params *params,
>> +	     struct snd_pcm_hw_rule *rule,
>> +	     struct snd_efw *efw, unsigned int *channels)
>
> The channels parameters can be made const, too.

OK.

>> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>> +		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
>> +	} else {
>> +		substream->runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
>
> The should have been a similar symbol for AMDTP capture streams.

Do you suggest to add AMDTP_IN_PCM_FORMAT_BITS?

>> +	/*
>> +	 * AMDTP functionality in firewire-lib require periods to be aligned to
>> +	 * 16 bit, or 24bit inner 32bit.
>> +	 */
>> +	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
>> +	if (err < 0)
>> +		goto end;
>> +	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
>> +					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
>> +	if (err < 0)
>> +		goto end;
>
> The comment is not correct.
...
> This driver uses blocking mode, so aligning to packets makes sense.
> Replace _BYTES with _SIZE, and change the comment to something like this
> (I should have written a comment like this in dice.c in the first place):
>
> /*
>   * Align the period size to SYT_INTERVAL to align the period interrupts
>   * with the packet boundaries.  Align the buffer size to SYT_INTERVAL to
>   * avoid having a buffer boundary inside a packet.
>   */

Now I realize to misunderstand these codes.

Currently firewire-lib exports a table for SYT_INTERVAL so we can make 
better rules for this, can't we?

>> +static int pcm_open(struct snd_pcm_substream *substream)
>> +{
>> +	...
>> +	/*
>> +	 * When source of clock is not internal or any PCM streams are running,
>> +	 * available sampling rate is limited at current sampling rate.
>> +	 */
>> +	if ((clock_source != SND_EFW_CLOCK_SOURCE_INTERNAL) ||
>> +	    amdtp_stream_pcm_running(&efw->tx_stream) ||
>> +	    amdtp_stream_pcm_running(&efw->rx_stream)) {
>
> Opening the playback and capture streams of a single PCM device is
> protected with the same mutex, but this does not help against races with
> the MIDI callbacks.
>
> This substream management code must be protected with a mutex.
> (Also in hw_params and hw_free.)

Hm. I have no ideas for such races, except for substream counter. Can I 
request you more explaination? What race state can appears between 
PCM/MIDI functionalities?

For hw_params/hw_free, please see my reply to [24/44].


Thank you

Takashi Sakamoto
o-takashi@sakamocchi.jp
