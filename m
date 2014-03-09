From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 11/39] firewire-lib: Add support for
 channel mapping
Date: Sun, 09 Mar 2014 22:20:42 +0100
Message-ID: <531CDB2A.8020304@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-12-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4F7252655D4
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:21:22 +0100 (CET)
In-Reply-To: <1394016507-15761-12-git-send-email-o-takashi@sakamocchi.jp>
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
> Some devices arrange the position of PCM/MIDI data channel in AMDTP packet.
> This commit allows drivers to set channel mapping.
>
> To be simple, the mapping table is an array with fixed length. Then the number
> of channels for PCM is restricted by 64 channels.

> +++ b/sound/firewire/amdtp.c
> @@ -351,22 +358,20 @@ static void amdtp_write_s32(struct amdtp_stream *s,
>  			    __be32 *buffer, unsigned int frames)
>  {
>  	struct snd_pcm_runtime *runtime = pcm->runtime;
> -	unsigned int channels, remaining_frames, frame_step, i, c;
> +	unsigned int remaining_frames, i, c;
>  	const u32 *src;
>
> -	channels = s->pcm_channels;

This change is not necessary.  I used a separate local variable
deliberately to allow the compiler to recognize that it cannot be
aliased with the buffer contents.

> @@ -403,29 +406,29 @@ static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
>  	for (i = 0; i < frames; ++i) {
>  		for (c = 0; c < channels; ++c) {
> +			buffer[s->pcm_positions[c] * 2] =
> +					cpu_to_be32((*src >> 8) | 0x40000000);
>  			src++;
>  		}
> +		buffer += 1;
>  		for (c = 0; c < channels; ++c) {
> +			buffer[s->pcm_positions[c] * 2] =
> +					cpu_to_be32((*src >> 8) | 0x40000000);
>  			src++;
>  		}
> +		buffer += s->data_block_quadlets - 1;
> +		if (--remaining_frames == 0)
> +			src = (void *)runtime->dma_area;
>  	}

AFAICS the dual-wire format could be handled easier by setting pcm_positions[]
in the dice driver.


Regards,
Clemens
