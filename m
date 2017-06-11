From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ALSA: firewire-lib: Fix stall of
 process context at packet error
Date: Sun, 11 Jun 2017 15:53:42 +0900
Message-ID: <ca99aecf-a170-6ab7-50cd-bf3e50361b20@sakamocchi.jp>
References: <20170609132031.21058-1-o-takashi@sakamocchi.jp>
 <0c1fcd71-7ec8-dd41-a001-190dd698e21d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 62393266A09
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 08:53:48 +0200 (CEST)
In-Reply-To: <0c1fcd71-7ec8-dd41-a001-190dd698e21d@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jun 9 2017 22:27, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> ---
>>   sound/firewire/amdtp-stream.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
>> index 9678bc75dc5b..de4f6b6dbd47 100644
>> --- a/sound/firewire/amdtp-stream.c
>> +++ b/sound/firewire/amdtp-stream.c
>> @@ -701,7 +701,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
>>   		cycle = increment_cycle_count(cycle, 1);
>>   		if (s->handle_packet(s, 0, cycle, i) < 0) {
>>   			s->packet_index = -1;
>> -			amdtp_stream_pcm_abort(s);
>> +			WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
>>   			return;
>>   		}
>>   	}
>> @@ -753,7 +753,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
>>   	/* Queueing error or detecting invalid payload. */
>>   	if (i < packets) {
>>   		s->packet_index = -1;
>> -		amdtp_stream_pcm_abort(s);
>> +		WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
>>   		return;
>>   	}
> 
> SNDRV_PCM_POS_XRUN has type unsigned long and might not fit into an unsigned int.

I forgot to add it to staging...

Furthermore, I realized that we should care of software IRQ context for 
OHCI 1394 context. Packets are handled and we need to abort PCM 
substream in this context.


Thanks

Takashi Sakaomto
