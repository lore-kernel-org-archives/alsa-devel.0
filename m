From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 26/44] fireworks: Add PCM interface
Date: Sun, 06 Apr 2014 16:52:52 +0200
Message-ID: <53416A44.6070905@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-27-git-send-email-o-takashi@sakamocchi.jp>
	<533E71C8.9030606@ladisch.de> <53414C45.2070006@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53414C45.2070006@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Apr 4 2014 17:48), Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> +    if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>>> +        substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
>>> +    } else {
>>> +        substream->runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
>>
>> The should have been a similar symbol for AMDTP capture streams.
>
> Do you suggest to add AMDTP_IN_PCM_FORMAT_BITS?

Yes; in the ideal case, this driver does not need to know which formats
are actually supported.

>> /*
>>  * Align the period size to SYT_INTERVAL to align the period interrupts
>>  * with the packet boundaries.  Align the buffer size to SYT_INTERVAL to
>>  * avoid having a buffer boundary inside a packet.
>>  */
>
> Currently firewire-lib exports a table for SYT_INTERVAL so we can make
> better rules for this, can't we?

Yes, we could make better rules, if we wanted to.

>>> +static int pcm_open(struct snd_pcm_substream *substream)
>>> +{
>>> +    ...
>>> +    /*
>>> +     * When source of clock is not internal or any PCM streams are running,
>>> +     * available sampling rate is limited at current sampling rate.
>>> +     */
>>> +    if ((clock_source != SND_EFW_CLOCK_SOURCE_INTERNAL) ||
>>> +        amdtp_stream_pcm_running(&efw->tx_stream) ||
>>> +        amdtp_stream_pcm_running(&efw->rx_stream)) {
>>
>> Opening the playback and capture streams of a single PCM device is
>> protected with the same mutex, but this does not help against races with
>> the MIDI callbacks.
>>
>> This substream management code must be protected with a mutex.
>> (Also in hw_params and hw_free.)
>
> Hm. I have no ideas for such races, except for substream counter.

There is already a mutex for everything in start_duplex(), so the only
unprotected piece of data is this counter.


Regards,
Clemens

------------------------------------------------------------------------------
