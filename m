From: Robin Gareus <robin@gareus.org>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Mon, 16 Mar 2015 15:25:50 +0100
Message-ID: <5506E7EE.6060300@gareus.org>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CBB92610B1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 15:26:00 +0100 (CET)
In-Reply-To: <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, damien@zamaudio.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Many thanks for doing this!

On 03/15/2015 05:01 PM, Takashi Sakamoto wrote:

> +
> +void snd_dg00x_protocol_write_s32(struct amdtp_stream *s,
> +				  struct snd_pcm_substream *pcm,
> +				  __be32 *buffer, unsigned int frames)
> +{
> +	struct snd_pcm_runtime *runtime = pcm->runtime;
> +	unsigned int channels, remaining_frames, i, c;
> +	const u32 *src;
> +	static struct dot_state state;

There's no need to declare this as static. The state is per frame.

> +	channels = s->pcm_channels;
> +	src = (void *)runtime->dma_area +
> +			frames_to_bytes(runtime, s->pcm_buffer_pointer);
> +	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
> +
> +	for (i = 0; i < frames; ++i) {

..it is zeroed here, anyway:

> +		dot_state_reset(&state);


> +		for (c = 0; c < channels; ++c) {
> +			buffer[s->pcm_positions[c]] =
> +					cpu_to_be32((*src >> 8) | 0x40000000);
> +			dot_encode_step(&state, &buffer[s->pcm_positions[c]]);
> +			src++;
> +		}
> +
> +		buffer += s->data_block_quadlets;
> +		if (--remaining_frames == 0)
> +			src = (void *)runtime->dma_area;
> +	}
> +}


In any case, the algorithm to xor-encode the digidesign data is not yet
100% correct there. One will need to continue iterating after the last
channel (feeding zero) until the state->carry (dot_scrt()) is 0x00.

The current code here only works only correctly for data on the first 4
chanels (18 [total channels] - 14 [max xor-chain length]).

I'll let Damien elaborate. He has access to a Digidesign interface and
did the protocol-dumps. I only did the clean room reverse-engineering
and maths on the other end.

Cheers!
robin
