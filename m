From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] MIDI driver for Behringer BCD2000 USB
	device
Date: Thu, 20 Feb 2014 13:44:59 +0100
Message-ID: <5305F8CB.30506@zonque.org>
References: <1392899467-8956-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 08AB72654CB
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 13:45:01 +0100 (CET)
In-Reply-To: <1392899467-8956-1-git-send-email-dev@kicherer.org>
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

On 02/20/2014 01:31 PM, Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
> 
> I also plan to add support for the audio part, but I assume that this will
> require more effort than the rather simple MIDI interface. Progress can be
> tracked at https://github.com/anyc/snd-usb-bcd2000. 

...

> +static int bcd2000_probe(struct usb_interface *interface,
> +				const struct usb_device_id *usb_id)
> +{

...

> +	usb_set_intfdata(interface, bcd2k);
> +	devices_used[card_index/sizeof(int)*8] |=
> +		1 << (card_index%(sizeof(int)*8));
> +

...

> +static void bcd2000_disconnect(struct usb_interface *interface)
> +{

...

> +	devices_used[bcd2k->card_index/sizeof(int)*8] &=
> +		~(1 << (bcd2k->card_index%(sizeof(int)*8)));

We have much nicer ways of doing this :)

Have a look at include/linux/bitmap.h, especially set_bit(), clear_bit()
and DECLARE_BITMAP().
