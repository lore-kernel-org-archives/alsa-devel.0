From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb-audio: constify usb_protocol_ops
	structures
Date: Fri, 11 Dec 2015 16:17:15 +0100
Message-ID: <566AE8FB.4000502@ladisch.de>
References: <1449845557-22444-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 23ECB2654D5
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 16:17:17 +0100 (CET)
In-Reply-To: <1449845557-22444-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Julia Lawall wrote:
> The usb_protocol_ops structures are never modified, so declare them as
> const.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/usb/midi.c |   25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index ee212e7..cc39f63 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -112,7 +112,7 @@ struct snd_usb_midi {
>  	struct usb_interface *iface;
>  	const struct snd_usb_audio_quirk *quirk;
>  	struct snd_rawmidi *rmidi;
> -	struct usb_protocol_ops *usb_protocol_ops;
> +	const struct usb_protocol_ops *usb_protocol_ops;
>  	struct list_head list;
>  	struct timer_list error_timer;
>  	spinlock_t disc_lock;
> @@ -671,31 +671,32 @@ static void snd_usbmidi_standard_output(struct snd_usb_midi_out_endpoint *ep,
>  	}
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_standard_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_standard_ops = {
>  	.input = snd_usbmidi_standard_input,
>  	.output = snd_usbmidi_standard_output,
>  	.output_packet = snd_usbmidi_output_standard_packet,
>  };
>
> -static struct usb_protocol_ops snd_usbmidi_midiman_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_midiman_ops = {
>  	.input = snd_usbmidi_midiman_input,
>  	.output = snd_usbmidi_standard_output,
>  	.output_packet = snd_usbmidi_output_midiman_packet,
>  };
>
> -static struct usb_protocol_ops snd_usbmidi_maudio_broken_running_status_ops = {
> +static const
> +struct usb_protocol_ops snd_usbmidi_maudio_broken_running_status_ops = {
>  	.input = snd_usbmidi_maudio_broken_running_status_input,
>  	.output = snd_usbmidi_standard_output,
>  	.output_packet = snd_usbmidi_output_standard_packet,
>  };
>
> -static struct usb_protocol_ops snd_usbmidi_cme_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_cme_ops = {
>  	.input = snd_usbmidi_cme_input,
>  	.output = snd_usbmidi_standard_output,
>  	.output_packet = snd_usbmidi_output_standard_packet,
>  };
>
> -static struct usb_protocol_ops snd_usbmidi_ch345_broken_sysex_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_ch345_broken_sysex_ops = {
>  	.input = ch345_broken_sysex_input,
>  	.output = snd_usbmidi_standard_output,
>  	.output_packet = snd_usbmidi_output_standard_packet,
> @@ -795,7 +796,7 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
>  	}
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_akai_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_akai_ops = {
>  	.input = snd_usbmidi_akai_input,
>  	.output = snd_usbmidi_akai_output,
>  };
> @@ -835,7 +836,7 @@ static void snd_usbmidi_novation_output(struct snd_usb_midi_out_endpoint *ep,
>  	urb->transfer_buffer_length = 2 + count;
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_novation_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_novation_ops = {
>  	.input = snd_usbmidi_novation_input,
>  	.output = snd_usbmidi_novation_output,
>  };
> @@ -867,7 +868,7 @@ static void snd_usbmidi_raw_output(struct snd_usb_midi_out_endpoint *ep,
>  	urb->transfer_buffer_length = count;
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_raw_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_raw_ops = {
>  	.input = snd_usbmidi_raw_input,
>  	.output = snd_usbmidi_raw_output,
>  };
> @@ -883,7 +884,7 @@ static void snd_usbmidi_ftdi_input(struct snd_usb_midi_in_endpoint *ep,
>  		snd_usbmidi_input_data(ep, 0, buffer + 2, buffer_length - 2);
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_ftdi_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_ftdi_ops = {
>  	.input = snd_usbmidi_ftdi_input,
>  	.output = snd_usbmidi_raw_output,
>  };
> @@ -927,7 +928,7 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
>  	urb->transfer_buffer_length = ep->max_transfer;
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_122l_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_122l_ops = {
>  	.input = snd_usbmidi_us122l_input,
>  	.output = snd_usbmidi_us122l_output,
>  };
> @@ -1060,7 +1061,7 @@ static void snd_usbmidi_emagic_output(struct snd_usb_midi_out_endpoint *ep,
>  	urb->transfer_buffer_length = ep->max_transfer - buf_free;
>  }
>
> -static struct usb_protocol_ops snd_usbmidi_emagic_ops = {
> +static const struct usb_protocol_ops snd_usbmidi_emagic_ops = {
>  	.input = snd_usbmidi_emagic_input,
>  	.output = snd_usbmidi_emagic_output,
>  	.init_out_endpoint = snd_usbmidi_emagic_init_out,
