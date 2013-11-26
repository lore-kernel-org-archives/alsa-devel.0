From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 04/17] firewire-lib: Split some codes into
 functions to reuse in future
Date: Tue, 26 Nov 2013 19:52:33 +0900
Message-ID: <52947D71.5090103@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-5-git-send-email-o-takashi@sakamocchi.jp>
 <52936C56.5010502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D77265083
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 11:52:38 +0100 (CET)
In-Reply-To: <52936C56.5010502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Nov 26 2013 00:27), Clemens Ladisch wrote:
>> +static void check_pcm_pointer(struct amdtp_stream *s,
>
> Thw word "check" does not imply that the pointers get changed.  Please
> use something like "update_pcm_pointers".

OK. I apply 'update_pcm_pointers'.

>> +static int queue_packet(struct amdtp_stream *s,
>> +{
>> +	p.skip = (!skip) ? 0: 1;
>
> 	p.skip = skip;
>
>> @@ -612,8 +618,8 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
>>   	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
>>   					   FW_ISO_CONTEXT_TRANSMIT,
>>   					   channel, speed, 0,
>> -					   out_packet_callback, s);
>> +					   out_stream_callback, s);
>> -	if (IS_ERR(s->context)) {
>> +	if (!amdtp_stream_running(s)) {
>
> The stream is not yet running at this point, so using this function here
> would be confusing.

OK.


Thank you.

Takashi Sakamoto
