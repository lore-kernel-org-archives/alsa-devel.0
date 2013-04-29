From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/4] Add handling AMDTP receive stream
Date: Mon, 29 Apr 2013 13:30:28 +0900
Message-ID: <517DF764.1020703@sakamocchi.jp>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367125334-446-5-git-send-email-o-takashi@sakamocchi.jp>
	<517D1BA3.9010503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <517D1BA3.9010503@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your review. Thanks for your review. I arrange these issues 
to 6 items below.

amdtp[PATCH4/4]:
1. It would be easier to add some local variables for CIP headers.
OK. Actually be32_to_cpu() was used six times. I add "u32 cip_header[2]" 
for them and reduce the time.

2. "CIP header error" should be handled approproately, ignored or abort.
OK. Here I want to select ignoring.

3. The comment about Fireworks' data block counter
I'm sorry but it includes wrong description in the patch. It was old one 
working with inappropriate code. The wrong code reported me the wrong 
result  and I added the comment with it...

This comment is true:
"Echo Audio's Fireworks reports wrong number of data block counter. It 
always reports it with increment by 8 blocks even if actual data blocks 
different from 8."

4. The comment related to ignoring SYT field should be indicate that 
ALSA has no spec equivalent to "presentation timestamp".
OK. I rewrite the comment to mean it.

5. "data_block_counter" is unused.
I forget to add some description to commit log that I plan to use it for 
future patches to add handling MIDI. For my convinience, I want to keep 
it here.

6. typo of "calcurate"
OK. I rewrite.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Apr 28 2013 21:52), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> To handle AMDTP receive stream, this patch adds some codes with condition of its
>> direction and new functions. Once amdtp_stream_init() is executed with its
>> direction, AMDTP receive and transmit stream can be handles by the same way.
>>
>> Unfortunatelly Echo Audio's Fireworks(TM) is not fully compliant to IEC 61883-6
>> against their guide. This patch include some work arounds for Fireworks.
>
>> +++ b/sound/firewire/amdtp.c
>
>> +static void handle_in_packet_data(struct amdtp_stream *s,
>> +						unsigned int data_quadlets)
>
>> +	/* checking CIP headers for AMDTP with restriction of this module */
>> +	if (((be32_to_cpu(buffer[0]) & CIP_EOH_MASK) == CIP_EOH) ||
>> +	    ((be32_to_cpu(buffer[1]) & CIP_EOH_MASK) != CIP_EOH) ||
>> +	    ((be32_to_cpu(buffer[1]) & CIP_FMT_MASK) != CIP_FMT_AM)) {
>
> It would be easier and a little bit more efficient to convert the two
> header quadlets at the beginning and to store them in some local
> variables.
>
>> +		dev_err(&s->unit->device, "CIP headers error: %08X:%08X\n",
>> +			be32_to_cpu(buffer[0]), be32_to_cpu(buffer[1]));
>> +		return;
>
> This error should either be ignored (resubmit the packet) or cause the
> stream to abort (see "queueing error" below).
>
> But I'm not sure which.
>
>> +		 * Echo Audio's Fireworks reports wrong number of data block
>> +		 * counter. Mostly it reports it with increment of 8 blocks
>> +		 * but sometimes it increments with NO-DATA packet.
>
> Does this imply that the DBC field could not be used to detect dropped
> packets?
>
>> +		 * Handling syt field is related to time stamp,
>> +		 * but the cost is bigger than the effect.
>
> Actually, the SYT specifies the presentation timestamp, but when doing
> capturing in ALSA, there is no "presentation" in the sense of the spec,
> so not handling the SYT field is the correct thing to do regardless of
> the cost.  :-)
>
>> +		 * NOTE: this module doesn't check dbc ...
>
>> +		data_block_counter  = (be32_to_cpu(buffer[0]) & AMDTP_DBC_MASK);
>
> Unused.
>
>> +		/* for next packet */
>> +		s->data_block_quadlets = data_block_quadlets;
>> +		s->data_block_counter  = data_block_counter;
>
> Unused.
>
>> +	/* calcurate packet index */
>
>> +	/* calcurate period and buffer borders */
>
> 	   calculate
>
>
> Regards,
> Clemens
>


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
