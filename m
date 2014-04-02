From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/44] firewire-lib: Add support for MIDI
 capture/playback
Date: Wed, 02 Apr 2014 21:29:20 +0200
Message-ID: <533C6510.7000605@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E91D626550F
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 21:29:28 +0200 (CEST)
In-Reply-To: <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> For capturing/playbacking MIDI messages, this commit adds one MIDI conformant
> data channel.
>
> +++ b/sound/firewire/amdtp.c
> +static void amdtp_pull_midi(struct amdtp_stream *s,
> +			    __be32 *buffer, unsigned int frames)
> +{
> +	unsigned int f, port;
> +	int len;
> +	u8 *b;
> +
> +	for (f = 0; f < frames; f++) {
> +		port = (s->data_block_counter + f) % 8;
> +		b = (u8 *)&buffer[s->pcm_channels + 1];
>
> +		len = b[0] - 0x80;
> +		if ((len > 1) &&  (3 < len) && (s->midi[port]))

This condition is true only for len==2.

> +			snd_rawmidi_receive(s->midi[port], b + 1, len);
> +
> +		buffer += s->data_block_quadlets;
> +	}
>  }


Regards,
Clemens
