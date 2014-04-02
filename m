From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v8] MIDI driver for Behringer BCD2000 USB
	device
Date: Wed, 02 Apr 2014 18:34:33 +0200
Message-ID: <533C3C19.2010400@zonque.org>
References: <1396454213-10863-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 970582654E8
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 18:34:39 +0200 (CEST)
In-Reply-To: <1396454213-10863-1-git-send-email-dev@kicherer.org>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

the only things I spotted are style nits ...


On 04/02/2014 05:56 PM, Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
> 
> I also plan to add support for the audio part, but I assume that this will
> require more effort than the rather simple MIDI interface. Progress can be
> tracked at https://github.com/anyc/snd-usb-bcd2000.

Text such as the lines starting here ...

> 
> Daniel or Clemens: could I get another ACK on this? Thank you both!
> 
> Best regards,
> Mario
> 
> Changes since v7:
> 	- replaced snd_card_create with snd_card_new
> 
> Changes since v6:
>         - applied more style improvements
> 
> Changes since v5:
> 	- use kernel bitmap functions for devices_used
> 
> Changes since v4:
> 	- devices_used as array to support arbitrary number of SNDRV_CARDS
> 	- removed unused array "enable"
> 
> Changes since v3:
>         - applied style and snd_printk changes as suggested by Daniel Mack
> 
> Changes since v2:
>         - applied more changes from Daniel Mack and Clemens Ladisch
> 
> Changes since v1:
>         - fixed the various code style issues, thanks to Daniel Mack and
>           checkpatch.pl.

... to here should go ...


> Signed-off-by: Mario Kicherer <dev@kicherer.org>
> ---

... here. IOW, Everything that is not supposed to become part of the
actual commit log message eventually has to be put underneath "---".

> +static struct usb_driver bcd2000_driver = {
> +	.name =	"snd-bcd2000",
> +	.probe =	bcd2000_probe,
> +	.disconnect =	bcd2000_disconnect,
> +	.id_table =	id_table,
> +};

Something's wrong with the indent here.

> +static int __init bcd2000_init(void)
> +{
> +	int retval = 0;
> +
> +	retval = usb_register(&bcd2000_driver);
> +	if (retval)
> +		pr_info(PREFIX "usb_register failed. Error: %d", retval);
> +	return retval;
> +}
> +
> +static void __exit bcd2000_exit(void)
> +{
> +	usb_deregister(&bcd2000_driver);
> +}
> +
> +module_init(bcd2000_init);
> +module_exit(bcd2000_exit);

You can replace all that with the module_usb_driver() helper function.
See include/linux/usb.h.

Other than that, it looks fine to me.


Thanks,
Daniel
