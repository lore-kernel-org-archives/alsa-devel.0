From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] Add MIDI stream support with data rate restriction
Date: Wed, 05 Jun 2013 20:44:39 +0900
Message-ID: <51AF24A7.9010005@sakamocchi.jp>
References: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370100337-22463-3-git-send-email-o-takashi@sakamocchi.jp>
	<51AC51D7.1040806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <51AC51D7.1040806@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

Thank you to review my patches and I'm really sorry to include much =

mistakes, misleads and so on in my patches...

 >> It's maximum rate is 3,150 bytes per seconds
 >                       3,125

Yes. This is my mistake.

 > In practice, many MPU-401 compatible devices transmit with two stop
 > bits and thus limit the actual rate to about 2841 bps.
 > That the hardware MIDI ports on Fireworks devices can transmit at
 > the full 3125 bps allowed by the spec is an exception.

I have a little knowledgement about MIDI specification and =

implementation. Here I should refer just to MMA/AMEI RP-027 and =

shouldn't have menthioned MPU-401..

 > It should be possible to adjust the interval between consecutive MIDI
 > bytes so that it is 320 =B5s (=3D 3125 bps) on average; this would be
 > similar to how packets are allocated to frames in blocking mode.  This
 > would require no more than one byte of buffering in the device.
 >
 > However, this can be added later.

OK. From the first I planed to improve these codes after snd-fireworks =

discussion.

 > This comment might be misleading.  There is no such "negotiation
 > procedure"; RP27 mentions this only to allow for future extension.

Yes, it's misleading. It should be rewritten.

Here I can't find such a specification that define this "negotiation =

procedure". Do you know about it?

 > snd_rawmidi_receive() already reports errors; you can just ignore its
 > return value.

I understand you mean "ALSA core prints debug message if =

snd_rawmidi_receive() failed so you don't need to check return value."

 > The bytes in the b[] array are arranged in big-endian order.
 > Converting them to CPU order and then back feels unnecessary.

This is my bad mistake. I was preoccupied with the restriction and =

snd-fireworks...

 > "Extract" would imply that the removed value is then used
 > for something else.  Just name the functions "add"/"remove".

OK. I name them "amdtp_stream_midi_add()" and
"amdtp_stream_midi_remove()". And I'm sorry that I added wrong prototype =

declarations in a patch for amdtp.h.

 > Please note that this driver always uses "unsigned int" unless
 > negative values are actually needed.

 > i++ would be more idiomatic.

 > len can never be negative.

 > unsigned

 > i++

 > This comment's accuracy is capable of improvement.

All OK.

Regards


Takashi Sakamoto
o-takashi@sakamocchi.jp

(Jun 3 2013 17:20), Clemens Ladisch wrote:
> o-takashi@sakamocchi.jp wrote:
>> IEC 61883-6 defines MIDI comformant deta and MMA/AMEI RP-027 defines its
>> implementation. This patch add handling MIDI stream according to them.
>>
>> According to MMA/AMEI RP-027, one MIDI channel in AMDTP stream can handle
>> 8 MIDI streams. The index of MIDI stream in one MIDI comformant
>> data channel is defined as "mod(data_block_count, 8)".
>>
>> And one MIDI comformant data can send MIDI message up to 3 bytes. Every =
MIDI
>> comformant data includes "label" to indicate the number of bytes in its =
most
>> significant byte.
>>
>> Then theoretically one MIDI stream can transmit MIDI messages up to 72,0=
00
>> bytes per second at 192.0kHz (=3D 192,000 / 8 * 3).
>>
>> But MIDI interface is based on MPU401-UART.
>
> Roland's MPU-401 was simply based on the MIDI specification.
>
>> It's maximum rate is 3,150 bytes per seconds
>
>                         3,125
>
> In practice, many MPU-401 compatible devices transmit with two stop
> bits and thus limit the actual rate to about 2841 bps.  That the
> hardware MIDI ports on Fireworks devices can transmit at the full
> 3125 bps allowed by the spec is an exception.
>
> I vaguely remember some MIDI spec saying that the maximum _sustained_
> data rate must be about 2500 bps.
>
>> Actually Echo's Fireworks cannot handle higer data rate. The devices can
>> overflow MIDI messages when receiving at higher data rate.
>
> Actually, higher data rates can be handled if the driver takes care to
> throttle when the device's internal FIFO is about to overflow.  My
> AudioFire2 has a 4 KB buffer, so that is what my old snd-fireworks
> driver assumes; I don't know how your AF Pre8 handles this.
>
>> This patch add an restriction of data rate up to 2,756 or 3,000 bytes pe=
r second
>> with simple logic. This restriction causes quite a small delay comparing=
 to the
>> maximum data rate. But I hope to keep codes to be as simple as possible.
>
> It should be possible to adjust the interval between consecutive MIDI
> bytes so that it is 320 =B5s (=3D 3125 bps) on average; this would be
> similar to how packets are allocated to frames in blocking mode.  This
> would require no more than one byte of buffering in the device.
>
> However, this can be added later.
>
>>   int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
>>   		enum amdtp_stream_direction direction, enum cip_flags flags)
>>   {
>> +	int i;
>
> Please note that this driver always uses "unsigned int" unless negative
> values are actually needed.
>
>> +	for (i =3D 0; i < AMDTP_MAX_MIDI_STREAMS; i +=3D 1)
>
> i++ would be more idiomatic.
>
>>   static void amdtp_fill_midi(struct amdtp_stream *s,
>>   			    __be32 *buffer, unsigned int frames)
>
>> +	 * This module can't support "negotiation procedure" in
>> +	 * MMA/AMEI RP-027.
>
> This comment might be misleading.  There is no such "negotiation
> procedure"; RP27 mentions this only to allow for future extension.
>
>> +			buffer[c] =3D (b[0] << 24) | (b[1] << 16) |
>> +							(b[2] << 8) | b[3];
>> +			buffer[c] =3D be32_to_cpu(buffer[c]);
>
> The bytes in the b[] array are arranged in big-endian order.  Converting
> them to CPU order and then back feels unnecessary.
>
> You could just let b point to the actual buffer:  u8 *p =3D &buffer[c];
>
>>   static void amdtp_pull_midi(struct amdtp_stream *s,
>>   			    __be32 *buffer, unsigned int frames)
>>   {
>> +	int len, ret;
>
> len can never be negative.
>
>> +			ret =3D snd_rawmidi_receive(s->midi[port], b + 1, len);
>> +			if (ret !=3D len) {
>> +				dev_err(&s->unit->device,
>
> snd_rawmidi_receive() already reports errors; you can just ignore its
> return value.
>
>> + * amdtp_stream_midi_insert - add MIDI stream
>> + * amdtp_stream_midi_extract - remove MIDI stream
>
> "Extract" would imply that the removed value is then used for something
> else.  Just name the functions "add"/"remove".
>
>> +bool amdtp_stream_midi_running(struct amdtp_stream *s)
>> +{
>> +	int i;
>
> unsigned
>
>> +	for (i =3D 0; i < AMDTP_MAX_MIDI_STREAMS; i +=3D 1) {
>
> i++
>
>> + * This module support maximum 8 MIDI streams
>> +#define AMDTP_MAX_MIDI_STREAMS 16
>
> This comment's accuracy is capable of improvement.
>
>
> Regards,
> Clemens


---------------------------------------------------------------------------=
---
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
