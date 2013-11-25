From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 05/17] firewire-lib: Add support for AMDTP
	transmit stream and PCM capture
Date: Mon, 25 Nov 2013 16:27:33 +0100
Message-ID: <52936C65.9020602@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
	<1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> For capturing PCM, this commit adds the functionality to handle transmitted
> stream. This is also applied for dual-wire mode.

> -		if (s->dual_wire)
> +		if (s->direction == AMDTP_TRANSMIT_STREAM) {
> +			if (s->dual_wire)
> +				s->transfer_samples = amdtp_read_s16_dualwire;
> +			else
> +				s->transfer_samples = amdtp_read_s16;
> +		} else if (s->dual_wire)
>  			s->transfer_samples = amdtp_write_s16_dualwire;
>  		else
>  			s->transfer_samples = amdtp_write_s16;

It's inconsistent to have braces around the if branch but not around the
else branch.

> +static void amdtp_read_s16(struct amdtp_stream *s,
> +			   struct snd_pcm_substream *pcm,
> +			   __be32 *buffer, unsigned int frames)
> +{

> +			*dst = be32_to_cpu(buffer[c]) << 8;

                                                      >> 8
(also in _dualwire)

It might be a good idea to completely drop S16 support.

> +static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
> +				     struct snd_pcm_substream *pcm,
> +				     __be32 *buffer, unsigned int frames)
> +{

> +	for (i = 0; i < frames; ++i) {
> +		for (c = 0; c < channels; ++c) {
> +			*dst =
> +			     be32_to_cpu(buffer[c]) << 8;
> +			dst++;
> +		}
> +		buffer += 1;
> +		for (c = 0; c < channels; ++c) {
> +			*dst =
> +			     be32_to_cpu(buffer[c]) << 8;
> +			dst++;
> +		}
> +		buffer += s->data_block_quadlets - 1;

This is not correct.

If we assume SYT_INTERVAL = 4, two channels at 192 kHz, and MIDI, the
samples L1 R1 L2 R2 L3 R3 ... L8 R8 would be arranged in the data
block's quadlets like four channels at 96 kHz, like this:

  L1 L4 R1 R4 L2 L5 R2 R5 L3 L6 R3 R6 L4 L7 R4 R8 MIDI

> +static void handle_in_packet(struct amdtp_stream *s,
> +			     unsigned int payload_quadlets,
> +			     __be32 *buffer)

> +	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
> +	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
> +	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
> +		dev_info(&s->unit->device,
> +			 "Invalid CIP header for AMDTP: %08X:%08X\n",
> +			 cip_header[0], cip_header[1]);

If some device sends 'wrong' values for all packets, the log will
overflow with these messages.  Please use printk_ratelimit().

> +	if ((payload_quadlets < 3) ||
> +	     ((s->flags & CIP_BLOCKING) &&
> +	      ((cip_header[1] & CIP_SYT_MASK) == CIP_SYT_NO_INFO)))

In the general case, we do not know if the stream is blocking or non-
blocking, so the driver should always be able to handle (=ignore) no-
data packets.

> +	data_block_counter = (cip_header[1] & AMDTP_DBC_MASK);

These parentheses are not needed.

> +	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
> +	if (s->data_block_counter != data_block_counter) {
> +		dev_err(&s->unit->device,
> +			"Detect uncontinuity of CIP packets\n");
> +		s->data_block_counter = data_block_counter;
> +		return;
> +	}

The correct thing to do would be to insert the missing samples, or to
stop the stream.


Regards,
Clemens

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
