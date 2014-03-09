From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/39] firewire-lib: Add support for AMDTP
 in-stream and PCM capture
Date: Sun, 09 Mar 2014 21:37:14 +0100
Message-ID: <531CD0FA.9090506@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 698992655CD
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 21:37:53 +0100 (CET)
In-Reply-To: <1394016507-15761-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> For capturing PCM, this commit adds the functionality to handle in-stream.
> This is also applied for dual-wire mode.

> +++ b/sound/firewire/amdtp.c
> @@ -200,16 +208,26 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
> +		if (s->direction == AMDTP_OUT_STREAM) {
> +			if (s->dual_wire)
> +				s->transfer_samples = amdtp_write_s32_dualwire;
> +			else
> +				s->transfer_samples = amdtp_write_s32;
> +		} else if (s->dual_wire) {
> +			s->transfer_samples = amdtp_read_s32_dualwire;
> +		} else {
> +			s->transfer_samples = amdtp_read_s32;
> +		}

Please format the if/else branches in the same way.

> +static void handle_in_packet(struct amdtp_stream *s,
> ...
> +	/* ignore empty CIP packet or NO-DATA AMDTP packet */
> +	if ((payload_quadlets < 3) ||
> +	    (((cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SFC_SHIFT) ==
> +							AMDTP_FDF_NO_DATA))

(AMDTP_FDF_NO_DATA << CIP_FDF_SFC_SHIFT) would be a constant that could
be computed at compile time.

> +	/* check packet continuity */
> +	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
> +	if (s->data_block_counter != data_block_counter) {
> +		dev_info_ratelimited(&s->unit->device,
> +				     "Detect uncontinuity of CIP packets\n");
> +		s->data_block_counter = data_block_counter;
> +		return;

In practice, this error means that a packet was dropped.  I guess this
doesn't actually happen too often, but eventually, we should handle
this either by inserting some samples or by stopping the stream.


Regards,
Clemens
