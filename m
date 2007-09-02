From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: [PATCH] Support Rane SL 1 (aka. Serato Scratch
 Live) interface
Date: Sun, 02 Sep 2007 17:30:53 +0200
Message-ID: <46DAD72D.7020007@gmx.net>
References: <alpine.BSO.0.9999.0709021447440.32425@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 6D3B6243B2
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Sep 2007 17:31:10 +0200 (CEST)
In-Reply-To: <alpine.BSO.0.9999.0709021447440.32425@metheny.ijneb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,
There should already be a quirks entry present using
USB_DEVICE(0x13e5, 0x0001),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
	{
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_AUDIO_STANDARD_INTERFACE
	}

At least for my device this is working...

Mark Hills wrote:
> Support Rane SL 1 (aka. Serato Scratch Live) interface
> 
> This quirk ensures the SL 1 interface is detected and can be used. The 
> interface is USB and is supplied with the Serato Scratch Live system for 
> DJs.
> 
> Signed-off-by: Mark Hills <mark@pogo.org.uk>
> 
> --- alsa-driver-1.0.15rc1/sound/usb/usbquirks.h	Thu Aug 30 09:27:00 2007
> +++ alsa-driver/sound/usb/usbquirks.h	Sun Sep  2 14:55:00 2007
> @@ -1748,6 +1748,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>   	}
>   },
> 
> +/* Rane SL 1 (aka. Serato Scratch Live) device */
> +{
> +	USB_DEVICE(0x13e5, 0x0001),
> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +		.vendor_name = "Rane",
> +		.product_name = "SL-1",
> +		.ifnum = QUIRK_NO_INTERFACE
> +	}
> +},
> +
>   /* Novation EMS devices */
>   {
>   	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
