From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH][ALSA] usbmidi support for Access Music
	synths.
Date: Wed, 10 Feb 2010 09:56:26 +0100
Message-ID: <4B7274BA.3040801@ladisch.de>
References: <4B726306.8070506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.38]) by alsa0.perex.cz (Postfix) with ESMTP id 5B3DB24388
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 09:56:29 +0100 (CET)
In-Reply-To: <4B726306.8070506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastien Alaiwan <sebastien.alaiwan@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sebastien Alaiwan wrote:
> here's a patch that adds MIDI support through USB for one of the
> Access Music synths, the VirusTI. 

Thanks!

Please run the checkpatch script on your patch.

> +	u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 }; // "midi send" enable
> +
> +	err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x05), seq,
> +			ARRAY_SIZE(seq), &actual_length, 1000);

There are architectures where doing DMA with data on the stack is not
possible.  Have a look at send_bulk_static_data.

>  /*
> + * Detects the endpoints for Access Music Virus TI
> + */
> +static int snd_usbmidi_detect_two_cables_per_endpoint(struct snd_usb_midi* umidi,
> +    struct snd_usb_midi_endpoint_info* endpoints)
> +{
> +	int err, i;
> +
> +	err = snd_usbmidi_detect_endpoints(umidi, endpoints, MIDI_MAX_ENDPOINTS);
> +	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
> +		if (endpoints[i].in_ep) {
> +			printk("Creating two in cables for input EP 0x%.2X\n", endpoints[i].in_ep);

If this is just for debugging, use snd_printdd.

> +			endpoints[i].in_cables = 0x0003;
> +		}
> +		if (endpoints[i].out_ep) {
> +			printk("Creating two out cables for output EP 0x%.2X\n", endpoints[i].out_ep);
> +			endpoints[i].out_cables = 0x0003;
> +		}
> +	}
> +	return err;
> +}

Does this device use more than one endpoint per direction?  If not, this
could be done with QUIRK_MIDI_FIXED_ENDPOINT.

> +++ b/sound/usb/usbquirks.h
> @@ -2105,6 +2105,28 @@
>  	}
>  },
>  
> +/* Access Music devices */
> +{
> +	/* VirusTI Desktop */
> +	USB_DEVICE_VENDOR_SPEC(0x133e, 0x0815),

Please keep the list sorted (as much as possible).

> +		.vendor_name = "AccessMusic",
> +		.product_name = "Virus TI",

These are needed only if the device hasn't vendor/product strings.

> +				// "Virus TI MIDI" and "Virus TI Synth"

If these are port names, put them into the snd_usbmidi_port_info array.


Regards,
Clemens
