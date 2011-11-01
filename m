From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Tue, 01 Nov 2011 21:57:13 +0100
Message-ID: <4EB05D29.7070401@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 4A0FC244D5
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 21:57:22 +0100 (CET)
In-Reply-To: <1320063030-3502-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> +++ b/sound/usb/card.h
> +struct snd_usb_endpoint {
>  	
> +	struct snd_usb_endpoint *sync_slave;

In theory, there could be more than one slave.

> +struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
>  	...
> +	/* select the alt setting once so the endpoints become valid */
> +	snd_printk("%s() calling usb_set_interface()\n", __func__);
> +	usb_set_interface(ep->chip->dev, ep->iface, ep->alt_idx);

This needs error handling.

> +void snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
> +{
> +		usb_set_interface(ep->chip->dev, ep->iface, ep->alt_idx);

This too.

> +void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
> +{
> +		for (i = 0; i < in_ctx->packets; i++) {
> +			if (urb->iso_frame_desc[i].status == 0)
> +				out_ctx->packet_size[i] =
> +					urb->iso_frame_desc[i].actual_length / ep->stride;
> +			else
> +				out_ctx->packet_size[i] = 0;

When there is any error in any received packet (status != 0), we do not
know how many frames to send.  Sending zero frames is certain to be
wrong and will break synchronization between the two streams.

As far as I can see, the only way to handle such errors is to stop the
stream(s) and the PCM device(s).


Regards,
Clemens
