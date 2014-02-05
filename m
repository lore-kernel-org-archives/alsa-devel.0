From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] MIDI driver for Behringer BCD2000 USB
 device
Date: Wed, 05 Feb 2014 23:32:23 +0100
Message-ID: <52F2BBF7.6050802@zonque.org>
References: <1391631059-6840-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C22B2650C1
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 23:32:25 +0100 (CET)
In-Reply-To: <1391631059-6840-1-git-send-email-dev@kicherer.org>
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

On 02/05/2014 09:10 PM, Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
> 
> I also plan to add support for the audio part, but I assume that this will
> require more effort than the rather simple MIDI interface. Progress can be
> tracked at https://github.com/anyc/snd-usb-bcd2000.
> 
> Changes since v1:
>         - fixed the various code style issues, thanks to Daniel Mack and
>           checkpatch.pl.

Hmm, we're getting there :) But I still see:

total: 571 errors, 6 warnings, 580 lines checked

Mostly due to:

ERROR: DOS line endings

Did you send the patch using git send-email?

Also, please have a quick look at Documentation/CodingStyle.

> --- /dev/null
> +++ b/sound/usb/bcd2000/bcd2000.c
> @@ -0,0 +1,553 @@
> +/*
> + * Behringer BCD2000 driver
> + *
> + *   Copyright (C) 2014 Mario Kicherer (dev@kicherer.org)
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/usb/audio.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>

As long as you don't need them, skip the pcm includes.

> +#include <sound/rawmidi.h>
> +#include "../usbaudio.h"
> +#include "../midi.h"
> +
> +#define DEVICE_NAME "Behringer BCD2000"
> +#define DEVICE_SHORTNAME "bcd2000"
> +
> +#define PREFIX DEVICE_SHORTNAME ": "
> +#define BUFSIZE 64
> +
> +static struct usb_device_id id_table[] = {
> +	{ USB_DEVICE(0x1397, 0x00bd) },
> +	{ },
> +};
> +
> +static int debug;

Hmm, what about the idea of moving the hex_dump function into an own
helper? See below ...

> +module_param(debug, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(debug, "enable debug output (default: 0)");
> +
> +static unsigned char device_cmd_prefix[] = {0x03, 0x00};
> +
> +static unsigned char bcd2000_init_sequence[] = {
> +	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
> +	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
> +	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff};

'};' should be in a new line.


> +struct bcd2000 {
> +	struct usb_device *dev;
> +	struct snd_card *card;
> +	struct usb_interface *intf;
> +	int card_index;
> +	struct snd_pcm *pcm;

Unused?

> +	struct list_head midi_list;
> +	spinlock_t lock;

Unused?

> +	struct mutex mutex;

That one's also kinda unused (see below)


...

> +static DEFINE_MUTEX(devices_mutex);
> +static unsigned int devices_used;
> +static struct usb_driver bcd2000_driver;
> +
> +
> +
> +
> +

Kill excessive newlines here.

> +static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
> +					const unsigned char *buf, int len)
> +{
> +	unsigned char length, cmd, buf_offset, tocopy;
> +
> +	if (!bcd2k->midi_receive_substream)
> +		return;
> +
> +	if (debug) {
> +		print_hex_dump(KERN_DEBUG, "received from device: ",
> +				DUMP_PREFIX_NONE, 16, 1, buf, len, false);
> +	}

You could add something like this:

#ifdef CONFIG_SND_DEBUG
static void bcd2000_midi_hex_dump(const char *prefix,
				  const unsigned char *buf, int len)
{
	print_hex_dump(KERN_DEBUG, prefix,
		       DUMP_PREFIX_NONE, 16, 1, buf, len, false);
}
#else
static inline void bcd2000_midi_hex_dump(const char *prefix,
				  const unsigned char *buf, int len) {}
#endif

And then just call the function from various places. That would safe you
the module parameter, the condition check, and an indentation level.

> +
> +	if (len < 2)
> +		return;
> +
> +	/*
> +	 * The BCD2000 sends MIDI commands with 2 or 3 bytes length. In case of
> +	 * 2 bytes, the command is the same as before.
> +	 *
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
> +	/*
> +	 * The MIDI packets the BCD2000 sends can be arbitrarily truncated or
> +	 * concatenated. Therefore, this loop accumulates the bytes from the
> +	 * input buffer until a full valid MIDI packet is in the MIDI command
> +	 * buffer "midi_cmd_buf".
> +	 */
> +
> +	buf_offset = 1;
> +	while (buf_offset <= length) {
> +		cmd = buf[buf_offset];
> +
> +		if (bcd2k->midi_cmd_offset == 0 && cmd != 0x90 && cmd != 0xb0) {
> +			/*
> +			 * this is a 2-byte midi packet -> reuse command byte
> +			 * from last midi packet
> +			 */
> +			bcd2k->midi_cmd_offset = 1;
> +		}
> +
> +		/* determine the number of bytes we want to copy this time */
> +		tocopy = min(3 - bcd2k->midi_cmd_offset,
> +					length - (buf_offset - 1));
> +
> +		/* safety check */
> +		if (bcd2k->midi_cmd_offset + tocopy < BUFSIZE &&
> +				buf_offset + tocopy < len) {
> +			memcpy(&bcd2k->midi_cmd_buf[bcd2k->midi_cmd_offset],
> +				&buf[buf_offset], tocopy);
> +		} else {
> +			snd_printk(KERN_ERR PREFIX "access violation in %s\n",
> +					__func__);

You want to drop the entire packet here, right?

> +		}
> +
> +		bcd2k->midi_cmd_offset += tocopy;
> +		buf_offset += tocopy;
> +
> +		/* is our MIDI packet complete? */
> +		if (bcd2k->midi_cmd_offset == 3) {
> +			if (debug) {
> +				print_hex_dump(KERN_DEBUG,
> +						"sending to userspace: ",
> +						DUMP_PREFIX_NONE, 16, 1,
> +						bcd2k->midi_cmd_buf,
> +						bcd2k->midi_cmd_offset, false);
> +			}

{} braces are not needed when a block only holds one instruction. See
Documentation/CodingStyle.


> +static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
> +{
> +	struct bcd2000 *bcd2k = substream->rmidi->private_data;

Newline here, and elsewhere in your code, after variable declarations.

> +	if (bcd2k->midi_out_active) {
> +		usb_free_urb(bcd2k->midi_out_urb);
> +		bcd2k->midi_out_active = 0;
> +	}
> +	return 0;
> +}
> +
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
> +	if (len <= 0)
> +		return;
> +
> +	/* set payload length */
> +	bcd2k->midi_out_buf[2] = len;
> +	bcd2k->midi_out_urb->transfer_buffer_length = BUFSIZE;
> +
> +	if (debug) {
> +		print_hex_dump(KERN_DEBUG, "sending to device: ",
> +				DUMP_PREFIX_NONE, 16, 1,
> +				bcd2k->midi_out_buf, len+3, false);
> +	}
> +
> +	/* send packet to the BCD2000 */
> +	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_ATOMIC);

This function is not called from atomic context, so GFP_KERNEL is ok.

> +	if (ret < 0) {
> +		dev_err(&bcd2k->dev->dev, PREFIX
> +			"%s (%p): usb_submit_urb() failed"
> +			"ret=%d, len=%d\n", __func__, substream, ret, len);
> +	} else {
> +		bcd2k->midi_out_active = 1;
> +	}

See above.

> +}
> +
> +static void bcd2000_midi_output_done(struct urb *urb)
> +{
> +	struct bcd2000 *bcd2k = urb->context;
> +
> +	bcd2k->midi_out_active = 0;
> +	if (urb->status != 0) {
> +		dev_err(&urb->dev->dev, PREFIX "urb status: %d\n", urb->status);
> +		return;
> +	}
> +
> +	if (!bcd2k->midi_out_substream)
> +		return;
> +
> +	bcd2000_midi_send(bcd2k, bcd2k->midi_out_substream);
> +}
> +

...

> +static void bcd2000_close_midi(struct bcd2000 *bcd2k)
> +{
> +	usb_free_urb(bcd2k->midi_out_urb);
> +	usb_free_urb(bcd2k->midi_in_urb);
> +}
> +
> +
> +
> +
> +

Too many newlines :)

> +/*
> + * general part
> + */
> +
> +static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
> +						struct usb_interface *interface)
> +{
> +	struct usb_interface *intf;
> +
> +	mutex_lock(&bcd2k->mutex);
> +	intf = bcd2k->intf;
> +	bcd2k->intf = NULL;
> +	mutex_unlock(&bcd2k->mutex);

What are you trying to lock here, and against what? Without another call
site, this mutex is futile.


Thanks,
Daniel
