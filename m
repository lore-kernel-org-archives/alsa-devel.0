From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: firewire-lib: add buffer-over-run protection
	at receiving more data blocks than expected
Date: Tue, 19 May 2015 09:25:56 +0900
Message-ID: <555A8314.2050503@sakamocchi.jp>
References: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>	<1431775365-25211-2-git-send-email-o-takashi@sakamocchi.jp>
	<s5ha8x2uju4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5ha8x2uju4.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 18 2015 21:54, Takashi Iwai wrote:
> At Sat, 16 May 2015 20:22:42 +0900,
> Takashi Sakamoto wrote:
>>
>> In IEC 61883-6, the number of data blocks in a packet is limited up to
>> the value of SYT_INTERVAL. Current implementation is compliant to the
>> limitation, while it can cause buffer-over-run when the value of dbs
>> field in received packet is illegally large.
>>
>> This commit adds a validator to detect such illegal packets to prevent
>> the buffer-over-run. Actually, the buffer is aligned to the size of memory
>>   page, thus this issue hardly causes system errors due to the room to page
>> alignment.
>>
>> But, Behringer F-Control Audio 202 (based on OXFW 970) has a quirk to
>> postpone transferring isochronous packet till finish handling any
>> asynchronous packets. In this case, this model is lazy, transfers no
>> packets during several cycle-start packets. After finishing, this model
>> pushes required data in next isochronous packet. As a result, the
>> packet include more data blocks than IEC 61883-6 defines.
>>
>> To continue to support this model, this commit adds a new flag to extend
>> the length of calculated payload. This flag allows the size of payload
>> 5 times as large as IEC 61883-6 defines. As a result, packets from this
>> model passed the validator successfully.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/firewire/amdtp.c            | 15 ++++++++++++++-
>>   sound/firewire/amdtp.h            |  4 ++++
>>   sound/firewire/oxfw/oxfw-stream.c | 10 ++++++++--
>>   3 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
>> index e061355..6424382 100644
>> --- a/sound/firewire/amdtp.c
>> +++ b/sound/firewire/amdtp.c
>> @@ -251,7 +251,12 @@ EXPORT_SYMBOL(amdtp_stream_set_parameters);
>>    */
>>   unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
>>   {
>> -	return 8 + s->syt_interval * s->data_block_quadlets * 4;
>> +	unsigned int multiplier = 1;
>> +
>> +	if (s->flags & CIP_JUMBO_DATA_BLOCKS)
>> +		multiplier = 5;
>> +
>> +	return 8 + s->syt_interval * s->data_block_quadlets * 4 * multiplier;
>>   }
>>   EXPORT_SYMBOL(amdtp_stream_get_max_payload);
>>
>> @@ -687,6 +692,14 @@ static void handle_in_packet(struct amdtp_stream *s,
>>   	struct snd_pcm_substream *pcm = NULL;
>>   	bool lost;
>>
>> +	/* Protect from buffer-over-run. */
>> +	if (payload_quadlets > amdtp_stream_get_max_payload(s)) {
>> +		dev_info(&s->unit->device,
>> +			 "Too many data blocks in a packet: %02X %02X\n",
>> +			 amdtp_stream_get_max_payload(s), payload_quadlets);
>> +		goto err;
>
> How often may this message appear?  My concern is the flood of such
> error message.  Some messages are already with _ratelimited() for
> avoiding it.

When detecting such jumbo size of payload, the firewire-lib stops 
processing the isochronous stream packet. Therefore, the error messaging 
doesn't continue.

The firewire-lib also sets XRUN to the state of PCM substream. ALSA PCM 
applications can recover this state by calling snd_pcm_prepare() (or 
snd_pcm_recover()). But this operation starts new isochronous context. 
In this case, one message per several hundreds mili-seconds. So the 
error messaging doesn't continue such frequently.

For me, no floading issues occur to these codes.


By the way, I think it good to use dev_err() instead of dev_info() 
because drivers should not handle such devices which transfer packets 
with such jumbo payload. This should be reported to developers.

Additionally, amdtp_stream_get_max_payload() returns the same value 
during streaming. So it's no need to calculate every packet. Ideally, I 
should add new member to 'struct amdtp_stream' for this value, while the 
value should be re-calculated when stream is not running. So I want to 
move the code to in_stream_callback() and use stack to keep the value.

I'd like to keep this patchset pending till posting new one.


Thanks

Takashi Sakamoto

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
