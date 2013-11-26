From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/17] firewire-lib: Add support for MIDI
	capture/playback
Date: Tue, 26 Nov 2013 21:04:08 +0900
Message-ID: <52948E38.4090601@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
 <52936C6F.1030200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E2632607B6
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 13:04:11 +0100 (CET)
In-Reply-To: <52936C6F.1030200@ladisch.de>
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
>> +++ b/sound/firewire/amdtp.h
>> +/*
>> + * This module supports maximum 2 MIDI channels.
>> + * Then AMDTP packets include maximum 16 MIDI streams multiplexed.
>> + * This is for our convinience.
>> + */
>> +#define AMDTP_MAX_CHANNELS_FOR_MIDI	2
>
> This does not look like 16 ports ...
>
>> -	unsigned int midi_ports;
>> +	unsigned int midi_channels;
>
> ... and "MIDI channels" means something different.  The RP-027 document
> defines things like "MIDI data stream", "MIDI Conformant Data Channel",
> and "MPX-MIDI Data Channel"; please clarify which one you mean.

In my understanding of RP-027:
'MIDI data stream' is a data stream to/from each MIDI ports
'MPX-MIDI data channel' is a data channel for each 'MIDI data stream'
'MIDI comformant data channel' has multiplexed 8 'MPX-MIDI data channel's

So I should write:

/*
  * This module supports maximum 2 MIDI comformant data channels.
  * Each MIDI comformant data channels include 8 MPX-MIDI data stream.
  * Each MPX-MIDI data streams includes data stream from/to MIDI ports.
  * Then AMDTP packets include maximum 16 MIDI streams.
  * This limitation is for our convinience.
  */

Is this OK?

>> IEC 61883-6 refers to AMEI/MMA RP-027 for implementation of MIDI conformant
>> data. This module implement 'MIDI1.0-1x-SPEED' mode. In the specification,
>> 'MIDI1.0-2x/3x-SPEED' mode is defined with 'negotiation procedure' and
>> 'encapsulation details'. But I cannot find specifications about them.
>
> The 2x/3x speed modes are not specified.

OK. I'll add it in comment.

>>   static void amdtp_fill_midi(struct amdtp_stream *s,
>>   			    __be32 *buffer, unsigned int frames)
>
>> +			if ((s->midi[port] != NULL) &&
>> +			    test_bit(port, &s->midi_triggered)) {
>
> The stream pointer (s->midi[]) is not needed when the stream is not
> active (triggered).  So you could drop the midi_triggered field and
> just update the stream pointer when triggering (like s->pcm).

Oh. That's better.

>> +			buffer[s->pcm_channels + c] =
>> +				be32_to_cpu((b[0] << 24) | (b[1] << 16));
>
> Endian conversions are required only for values that occupy more than
> one byte.  You should make 'buffer' a byte pointer so that you can copy
> b[] directly.

OK.


Thank you

Takashi Sakamoto
