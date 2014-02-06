From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] MIDI driver for Behringer BCD2000 USB
 device
Date: Thu, 06 Feb 2014 10:21:52 +0100
Message-ID: <52F35430.8040502@ladisch.de>
References: <1391631059-6840-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 77784265160
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 10:21:53 +0100 (CET)
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

Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
>
> +config SND_USB_BCD2000
> +	tristate "Behringer BCD2000 MIDI driver"
> +	select SND_HWDEP

Why HWDEP?

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-usb-bcd2000.

There is no need to have "usb" in the module name if that is the only
bus this device works with.

> -obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/
> +obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/

If there is only a single source file, just put it into misc/.
If you plan to have multiple source files, then this file should have
"_midi" in its name.

> +#include "../usbaudio.h"
> +#include "../midi.h"

Are these headers needed?

> +static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream,
> +						int up)
> +{
> +	struct bcd2000 *bcd2k = substream->rmidi->private_data;
> +
> +	if (!bcd2k)
> +		return;

This cannot happen.  And if it happens anyway, silently returning is not
necessarily a better option than crashing.

> +static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
> +					const unsigned char *buf, int len)
> +	/*
> +	 * The MIDI packets the BCD2000 sends can be arbitrarily truncated or
> +	 * concatenated. Therefore, this loop accumulates the bytes from the
> +	 * input buffer until a full valid MIDI packet is in the MIDI command
> +	 * buffer "midi_cmd_buf".
> +	 */

ALSA does not require full MIDI commands, and handles running status.

> +static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
> +{
> +	struct bcd2000 *bcd2k = substream->rmidi->private_data;
> +	if (bcd2k->midi_out_active) {
> +		usb_free_urb(bcd2k->midi_out_urb);

Why is this the right place to free the URB?

> +static void bcd2000_midi_output_done(struct urb *urb)
> +{
> ...
> +	if (!bcd2k->midi_out_substream)
> +		return;
> +
> +	bcd2000_midi_send(bcd2k, bcd2k->midi_out_substream);

The midi_out_substream field gets modified asynchronously by the trigger
callback; this might happen between these two statements.

Assuming that setting a pointer is atomic, use ACCESS_ONCE.

> +static void bcd2000_init_midi(struct bcd2000 *bcd2k)
> +{
> +	bcd2k->midi_in_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	bcd2k->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);

Error checking.

> +static int bcd2000_probe(struct usb_interface *interface,
> +				const struct usb_device_id *usb_id)
> +{
> +	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
> +			DEVICE_NAME ", at %s, %s speed",
> +			usb_path,
> +			bcd2k->dev->speed == USB_SPEED_HIGH ? "high" : "full");

The BCD2000 does not support high speed.

> +static void bcd2000_disconnect(struct usb_interface *interface)
> +{
> +	list_for_each(midi, &bcd2k->midi_list)
> +		snd_usbmidi_disconnect(midi);

midi_list is not actually used.


Regards,
Clemens
