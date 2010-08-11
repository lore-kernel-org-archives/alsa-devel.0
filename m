From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound: usb: USB3 Super Speed patch
Date: Wed, 11 Aug 2010 08:58:29 +0200
Message-ID: <4C624A15.206@ladisch.de>
References: <F6C4814A9B336243ABC3D1FB44E08AE8012C2846E3@US01WXMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
	[80.67.31.41]) by alsa0.perex.cz (Postfix) with ESMTP id 2CD2A103838
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 08:59:01 +0200 (CEST)
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE8012C2846E3@US01WXMBX1.internal.synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@suse.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Paul Zimmerman wrote:
> This patch adds Super Speed support to the USB drivers under sound/. It adds
> tests for USB_SPEED_SUPER to all the places that check for the USB speed.

> +++ b/sound/usb/midi.c
> @@ -834,7 +834,8 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
> +++ b/sound/usb/misc/ua101.c
> +++ b/sound/usb/usx2y/us122l.c
> +++ b/sound/usb/usx2y/usb_stream.c

These devices do not support super speed.

> +++ b/sound/usb/pcm.c
> -	if (snd_usb_get_speed(subs->dev) != USB_SPEED_HIGH)
> +	if (snd_usb_get_speed(subs->dev) != USB_SPEED_HIGH &&
> +	    snd_usb_get_speed(subs->dev) != USB_SPEED_SUPER)
>  		/* full speed devices have fixed data packet interval */
>  		ptmin = 1000;

In places like this, it would be better to write something like
	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL)
or
	if (snd_usb_get_speed(subs->dev) < USB_SPEED_HIGH)


Regards,
Clemens
