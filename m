From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/17] firewire-lib: Add support for AMDTP
 transmit stream and PCM capture
Date: Tue, 26 Nov 2013 19:50:25 +0900
Message-ID: <52947CF1.3000004@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
 <52936C65.9020602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 548CC2615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 11:50:29 +0100 (CET)
In-Reply-To: <52936C65.9020602@ladisch.de>
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
>> -		if (s->dual_wire)
>> +		if (s->direction == AMDTP_TRANSMIT_STREAM) {
>> +			if (s->dual_wire)
>> +				s->transfer_samples = amdtp_read_s16_dualwire;
>> +			else
>> +				s->transfer_samples = amdtp_read_s16;
>> +		} else if (s->dual_wire)
>>   			s->transfer_samples = amdtp_write_s16_dualwire;
>>   		else
>>   			s->transfer_samples = amdtp_write_s16;
>
> It's inconsistent to have braces around the if branch but not around the
> else branch.

OK. I'm sorry but I forget to run checkpatch.pl for this series.

>> +static void amdtp_read_s16(struct amdtp_stream *s,
>> +			   struct snd_pcm_substream *pcm,
>> +			   __be32 *buffer, unsigned int frames)
>> +{
>
>> +			*dst = be32_to_cpu(buffer[c]) << 8;
>
>                                                        >> 8
> (also in _dualwire)

I also took mistakes of this bit-shift in this patch and patch 11.
I should have tested it with S16LE.

 > It might be a good idea to completely drop S16 support.

Please give me a bit time to consider about this.

>> +static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
>> +				     struct snd_pcm_substream *pcm,
>> +				     __be32 *buffer, unsigned int frames)
>> +{
>
>> +	for (i = 0; i < frames; ++i) {
>> +		for (c = 0; c < channels; ++c) {
>> +			*dst =
>> +			     be32_to_cpu(buffer[c]) << 8;
>> +			dst++;
>> +		}
>> +		buffer += 1;
>> +		for (c = 0; c < channels; ++c) {
>> +			*dst =
>> +			     be32_to_cpu(buffer[c]) << 8;
>> +			dst++;
>> +		}
>> +		buffer += s->data_block_quadlets - 1;
>
> This is not correct.
>
> If we assume SYT_INTERVAL = 4, two channels at 192 kHz, and MIDI, the
> samples L1 R1 L2 R2 L3 R3 ... L8 R8 would be arranged in the data
> block's quadlets like four channels at 96 kHz, like this:
>
>    L1 L4 R1 R4 L2 L5 R2 R5 L3 L6 R3 R6 L4 L7 R4 R8 MIDI

This is my fault to create patches. These codes will be correctly 
modified in later patch 11. But I should have notice in this patch...

>> +static void handle_in_packet(struct amdtp_stream *s,
>> +			     unsigned int payload_quadlets,
>> +			     __be32 *buffer)
>
>> +	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
>> +	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
>> +	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
>> +		dev_info(&s->unit->device,
>> +			 "Invalid CIP header for AMDTP: %08X:%08X\n",
>> +			 cip_header[0], cip_header[1]);
>
> If some device sends 'wrong' values for all packets, the log will
> overflow with these messages.  Please use printk_ratelimit().

OK.

>> +	if ((payload_quadlets < 3) ||
>> +	     ((s->flags & CIP_BLOCKING) &&
>> +	      ((cip_header[1] & CIP_SYT_MASK) == CIP_SYT_NO_INFO)))
>
> In the general case, we do not know if the stream is blocking or non-
> blocking, so the driver should always be able to handle (=ignore) no-
> data packets.

OK. And we should consider about AMDTP special non-empty packet for 
no-data, I should have written like this:

#define AMDTP_FDF_NO_DATA 0xff

/* ignore CIP empty packet or AMDTP NO-DATA packet */
if ((payload_quadlets < 3) ||
     ((cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SFC_SHIFT)  == 
AMDTP_FDF_NO_DATA)))

>> +	data_block_counter = (cip_header[1] & AMDTP_DBC_MASK);
>
> These parentheses are not needed.

OK.

>> +	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
>> +	if (s->data_block_counter != data_block_counter) {
>> +		dev_err(&s->unit->device,
>> +			"Detect uncontinuity of CIP packets\n");
>> +		s->data_block_counter = data_block_counter;
>> +		return;
>> +	}
>
> The correct thing to do would be to insert the missing samples, or to
> stop the stream.

OK. But I remember there are some devices which transmits packets with 
0x0000 in its SYT field (Digidesign 003 Rack, I don't touch its 
development.). So I want to remove these codes if possible.


Thank you.

Takashi Sakamoto
