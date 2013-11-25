From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 06/17] firewire-lib: Add support for MIDI
	capture/playback
Date: Mon, 25 Nov 2013 16:27:43 +0100
Message-ID: <52936C6F.1030200@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
	<1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
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
> For capturing/playbacking MIDI message, this commit adds the functionality to
> multiplex/demultiplex MIDI messages into AMDTP sream in IEC 61883-6. As a
> result, the number of MIDI ports is limited by 16 ports, for my convinience.

> +++ b/sound/firewire/amdtp.h
> +/*
> + * This module supports maximum 2 MIDI channels.
> + * Then AMDTP packets include maximum 16 MIDI streams multiplexed.
> + * This is for our convinience.
> + */
> +#define AMDTP_MAX_CHANNELS_FOR_MIDI	2

This does not look like 16 ports ...

> -	unsigned int midi_ports;
> +	unsigned int midi_channels;

... and "MIDI channels" means something different.  The RP-027 document
defines things like "MIDI data stream", "MIDI Conformant Data Channel",
and "MPX-MIDI Data Channel"; please clarify which one you mean.

> IEC 61883-6 refers to AMEI/MMA RP-027 for implementation of MIDI conformant
> data. This module implement 'MIDI1.0-1x-SPEED' mode. In the specification,
> 'MIDI1.0-2x/3x-SPEED' mode is defined with 'negotiation procedure' and
> 'encapsulation details'. But I cannot find specifications about them.

The 2x/3x speed modes are not specified.

>  static void amdtp_fill_midi(struct amdtp_stream *s,
>  			    __be32 *buffer, unsigned int frames)

> +			if ((s->midi[port] != NULL) &&
> +			    test_bit(port, &s->midi_triggered)) {

The stream pointer (s->midi[]) is not needed when the stream is not
active (triggered).  So you could drop the midi_triggered field and
just update the stream pointer when triggering (like s->pcm).

> +			buffer[s->pcm_channels + c] =
> +				be32_to_cpu((b[0] << 24) | (b[1] << 16));

Endian conversions are required only for values that occupy more than
one byte.  You should make 'buffer' a byte pointer so that you can copy
b[] directly.


Regards,
Clemens

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
