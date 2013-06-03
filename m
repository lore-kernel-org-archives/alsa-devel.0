From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] Add MIDI stream support with data rate
	restriction
Date: Mon, 03 Jun 2013 10:20:39 +0200
Message-ID: <51AC51D7.1040806@ladisch.de>
References: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
 <1370100337-22463-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 198B426170B
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 10:20:43 +0200 (CEST)
In-Reply-To: <1370100337-22463-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> IEC 61883-6 defines MIDI comformant deta and MMA/AMEI RP-027 defines its
> implementation. This patch add handling MIDI stream according to them.
>
> According to MMA/AMEI RP-027, one MIDI channel in AMDTP stream can handle
> 8 MIDI streams. The index of MIDI stream in one MIDI comformant
> data channel is defined as "mod(data_block_count, 8)".
>
> And one MIDI comformant data can send MIDI message up to 3 bytes. Every M=
IDI
> comformant data includes "label" to indicate the number of bytes in its m=
ost
> significant byte.
>
> Then theoretically one MIDI stream can transmit MIDI messages up to 72,000
> bytes per second at 192.0kHz (=3D 192,000 / 8 * 3).
>
> But MIDI interface is based on MPU401-UART.

Roland's MPU-401 was simply based on the MIDI specification.

> It's maximum rate is 3,150 bytes per seconds

                       3,125

In practice, many MPU-401 compatible devices transmit with two stop
bits and thus limit the actual rate to about 2841 bps.  That the
hardware MIDI ports on Fireworks devices can transmit at the full
3125 bps allowed by the spec is an exception.

I vaguely remember some MIDI spec saying that the maximum _sustained_
data rate must be about 2500 bps.

> Actually Echo's Fireworks cannot handle higer data rate. The devices can
> overflow MIDI messages when receiving at higher data rate.

Actually, higher data rates can be handled if the driver takes care to
throttle when the device's internal FIFO is about to overflow.  My
AudioFire2 has a 4 KB buffer, so that is what my old snd-fireworks
driver assumes; I don't know how your AF Pre8 handles this.

> This patch add an restriction of data rate up to 2,756 or 3,000 bytes per=
 second
> with simple logic. This restriction causes quite a small delay comparing =
to the
> maximum data rate. But I hope to keep codes to be as simple as possible.

It should be possible to adjust the interval between consecutive MIDI
bytes so that it is 320 =B5s (=3D 3125 bps) on average; this would be
similar to how packets are allocated to frames in blocking mode.  This
would require no more than one byte of buffering in the device.

However, this can be added later.

>  int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
>  		enum amdtp_stream_direction direction, enum cip_flags flags)
>  {
> +	int i;

Please note that this driver always uses "unsigned int" unless negative
values are actually needed.

> +	for (i =3D 0; i < AMDTP_MAX_MIDI_STREAMS; i +=3D 1)

i++ would be more idiomatic.

>  static void amdtp_fill_midi(struct amdtp_stream *s,
>  			    __be32 *buffer, unsigned int frames)

> +	 * This module can't support "negotiation procedure" in
> +	 * MMA/AMEI RP-027.

This comment might be misleading.  There is no such "negotiation
procedure"; RP27 mentions this only to allow for future extension.

> +			buffer[c] =3D (b[0] << 24) | (b[1] << 16) |
> +							(b[2] << 8) | b[3];
> +			buffer[c] =3D be32_to_cpu(buffer[c]);

The bytes in the b[] array are arranged in big-endian order.  Converting
them to CPU order and then back feels unnecessary.

You could just let b point to the actual buffer:  u8 *p =3D &buffer[c];

>  static void amdtp_pull_midi(struct amdtp_stream *s,
>  			    __be32 *buffer, unsigned int frames)
>  {
> +	int len, ret;

len can never be negative.

> +			ret =3D snd_rawmidi_receive(s->midi[port], b + 1, len);
> +			if (ret !=3D len) {
> +				dev_err(&s->unit->device,

snd_rawmidi_receive() already reports errors; you can just ignore its
return value.

> + * amdtp_stream_midi_insert - add MIDI stream
> + * amdtp_stream_midi_extract - remove MIDI stream

"Extract" would imply that the removed value is then used for something
else.  Just name the functions "add"/"remove".

> +bool amdtp_stream_midi_running(struct amdtp_stream *s)
> +{
> +	int i;

unsigned

> +	for (i =3D 0; i < AMDTP_MAX_MIDI_STREAMS; i +=3D 1) {

i++

> + * This module support maximum 8 MIDI streams
> +#define AMDTP_MAX_MIDI_STREAMS 16

This comment's accuracy is capable of improvement.


Regards,
Clemens
