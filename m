From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 06/39] firewire-lib: Add support for MIDI
 capture/playback
Date: Sun, 09 Mar 2014 21:48:26 +0100
Message-ID: <531CD39A.9090100@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-7-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5B94C2655CD
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 21:49:05 +0100 (CET)
In-Reply-To: <1394016507-15761-7-git-send-email-o-takashi@sakamocchi.jp>
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
> For capturing/playbacking MIDI messages, this commit adds one MIDI conformant
> data channel. This channel supports 8 MPX-MIDI data streams then maximum number
> of supported MIDI ports is limited by 8.
>
> And this commit allows to set PCM format even if AMDTP stream already starts.
> I suppose the case that PCM stream is going to be joined into AMDTP streams after
> AMDTP stream is already started by MIDI. Each driver must count how many MIDI
> substreams use AMDTP stream to stop AMDTP stream.
>
> IEC 61883-6 refers to AMEI/MMA RP-027 for implementation of MIDI conformant
> data. In the specification, 'MIDI1.0-2x/3x-SPEED' mode are described with
> 'negotiation procedure' and 'encapsulation details'. But there is no
> specifications to define them. This module implement 'MIDI1.0-1x-SPEED' mode.

> +++ b/sound/firewire/amdtp.c
> @@ -505,11 +509,46 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
>  static void amdtp_fill_midi(struct amdtp_stream *s,

> +	unsigned int f, port;
> +	u8 *b;
> +
> +	for (f = 0; f < frames; f++) {
> +		buffer[s->pcm_channels + 1] = 0x00;

This is a 32-bit value.

> +		b = (u8 *)&buffer[s->pcm_channels + 1];
> +
> +		port = (s->data_block_counter + f) % 8;
> +		if ((s->midi[port] == NULL) ||
> +		    (snd_rawmidi_transmit(s->midi[port], b + 1, 1) <= 0)) {
> +			b[0] = 0x80;
> +			b[1] = 0x00;	/* confirm to be zero */

snd_rawmidi_transmit() will not write an unsused byte, and in any
case, zero can be a valid MIDI data byte.

> +static void amdtp_pull_midi(struct amdtp_stream *s,
> +			    __be32 *buffer, unsigned int frames)
> +{
> +	for (f = 0; f < frames; f++) {
> ...
> +		if (s->midi[port] == NULL)
> +			continue;
> +
> +		snd_rawmidi_receive(s->midi[port], b + 1, len);
> +		buffer += s->data_block_quadlets;
> +	}

The buffer pointer must be increased even when there is no active port.

> +++ b/sound/firewire/amdtp.h
>  /**
> + * amdtp_stream_pcm_running - check PCM stream is running or not
> + * @s: the AMDTP stream
> + *
> + * If this function returns true, PCM stream in the stream is running.
> + */
> +static inline bool amdtp_stream_pcm_running(struct amdtp_stream *s)
> +{
> +	return !IS_ERR_OR_NULL(s->pcm);
> +}

fw_iso_context_create() can return an error code, but for s->pcm,
all the IS_ERR stuff is not necessary.  This should be a plain NULL
check.


Regards,
Clemens
