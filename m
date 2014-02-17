From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3] MIDI driver for Behringer BCD2000 USB
 device
Date: Mon, 17 Feb 2014 10:18:55 +0100
Message-ID: <5301D3FF.4000309@zonque.org>
References: <1392071668-10722-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id F383A261A9F
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 10:18:56 +0100 (CET)
In-Reply-To: <1392071668-10722-1-git-send-email-dev@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mario,

On 02/10/2014 11:34 PM, Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
> 
> I also plan to add support for the audio part, but I assume that this will
> require more effort than the rather simple MIDI interface. Progress can be
> tracked at https://github.com/anyc/snd-usb-bcd2000.

This looks mostly nice to me now. I just have some minor comments inline.

>  sound/usb/Kconfig           |  13 ++
>  sound/usb/Makefile          |   2 +-
>  sound/usb/bcd2000/Makefile  |   3 +
>  sound/usb/bcd2000/bcd2000.c | 484 ++++++++++++++++++++++++++++++++++++++++++++

As soon as you add more functionality here such as audio, please rename
the file so it describes what it's doing, and split functionality into
something like card.c, midi.c, pcm.c etc. I think for now, the naming is
acceptable.

> +static unsigned char bcd2000_init_sequence[] = {
> +	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
> +	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
> +	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff};

'};' to a new line, please.

> +static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
> +					const unsigned char *buf, int len)

You're passing the 'len' parameter from urb->actual_length, which is
unsigned int. For consistency, make the type match here.

> +{
> +	unsigned char length, tocopy;
> +
> +	if (!bcd2k->midi_receive_substream)
> +		return;
> +
> +	bcd2000_dump_buffer(PREFIX "received from device: ", buf, len);
> +
> +	if (len < 2)
> +		return;
> +
> +	/*
> +	 * Packet structure: mm nn oo (pp)
> +	 *	mm: payload length
> +	 *	nn: MIDI command or note
> +	 *	oo: note or velocity
> +	 *	pp: velocity
> +	 */
> +
> +	length = buf[0];
> +
> +	/* ignore packets without payload */
> +	if (length == 0)
> +		return;
> +
> +	tocopy = min(length, (unsigned char) (len-1));

I'd rather like it the other way around: make 'length' and 'tocopy'
unsigned int, so you can avoid the cast and prevent the statement from
overflowing.

> +static void bcd2000_midi_send(struct bcd2000 *bcd2k,
> +				struct snd_rawmidi_substream *substream)
> +{
> +	int len, ret;
> +
> +	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= BUFSIZE);
> +	/* copy the "set LED" command bytes */
> +	memcpy(bcd2k->midi_out_buf, device_cmd_prefix,
> +		sizeof(device_cmd_prefix));
> +
> +	/*
> +	 * get MIDI packet and leave space for command prefix
> +	 * and payload length
> +	 */
> +	len = snd_rawmidi_transmit(substream,
> +				bcd2k->midi_out_buf + 3, BUFSIZE - 3);
> +
> +	if (len < 0)
> +		snd_printk("%s: snd_rawmidi_transmit error %d\n",
> +				__func__, len);

Takashi just went through all the drivers and replaced the snd_printk()
calls with pr_* and dev_* functions. This driver should also follow that
new fashion ...

> +	if (ret < 0)
> +		dev_err(&bcd2k->dev->dev, PREFIX
> +			"%s (%p): usb_submit_urb() failed, ret=%d, len=%d\n",
> +			__func__, substream, ret, len);

... like you do here.



Thanks!
Daniel
