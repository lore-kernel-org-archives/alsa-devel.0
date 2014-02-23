From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v6] MIDI driver for Behringer BCD2000 USB
 device
Date: Sun, 23 Feb 2014 21:24:22 +0100
Message-ID: <530A58F6.7030700@ladisch.de>
References: <1392909089-6242-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id F07EF2651D1
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 21:24:54 +0100 (CET)
In-Reply-To: <1392909089-6242-1-git-send-email-dev@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mario Kicherer wrote:
> +static unsigned char bcd2000_init_sequence[] = {
> +	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
> +	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
> +	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff
> +};

I wonder how much of this is the actual init sequence, and how much is
random garbage.  :-)

> +	/*
> +	 * Packet structure: mm nn oo (pp)
> +	 *	mm: payload length
> +	 *	nn: MIDI command or note
> +	 *	oo: note or velocity
> +	 *	pp: velocity

The device often sends data as single-byte packets, so the structure
actually is "length data...".

> +	/* copy the "set LED" command bytes */
> +	memcpy(bcd2k->midi_out_buf, device_cmd_prefix,
> +		sizeof(device_cmd_prefix));

This is also used for data request and input selection, so it's not
"set LED" but just "MIDI output".

> +static void bcd2000_input_complete(struct urb *urb)
> +{
> +	if (urb->status) {
> +		dev_warn(dev, PREFIX "input urb->status: %i\n", urb->status);
> +		return;
> +	}

This will stop the input even on transient errors.

> +	/* acknowledge received packet */
> +	ret = usb_submit_urb(bcd2k->midi_in_urb, GFP_ATOMIC);
> +	if (ret < 0)
> +		dev_err(dev, "unable to submit urb. OOM!?\n");

Don't guess, just show ret.  :)

> +	strcpy(card->driver, DEVICE_NAME);
> +	strcpy(card->shortname, DEVICE_SHORTNAME);
> +	usb_make_path(bcd2k->dev, usb_path, sizeof(usb_path));
> +	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
> +			DEVICE_NAME ", at %s",
> +			usb_path);

$ cat /proc/asound/cards
...
18 [bcd2000        ]: Behringer BCD200bcd2000 - bcd2000
                      Behringer BCD2000, at usb-0000:00:13.1-3

The driver name just identifies the driver, it does not need the vendor
name.  (And it should not overflow its buffer.)

The short name is shown to the user in many places, so it should be
properly capitalized.

The long name does not need the comma.

> +	dev_info(&bcd2k->dev->dev, PREFIX "%s", bcd2k->card->longname);

What use does this message have in the log?


Regards,
Clemens
