From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] g_midi: New USB MIDI Gadget class
	driver.
Date: Thu, 06 Jul 2006 11:27:15 +0200
Message-ID: <20060706092715.GA13194@turing.informatik.uni-halle.de>
References: <44ACA882.7090209@greyinnovation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-reply-to: <44ACA882.7090209@greyinnovation.com>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Ben Williamson <ben.williamson@greyinnovation.com>
Cc: David Brownell <david-b@pacbell.net>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ben Williamson wrote:
> This patch adds a USB MIDI Gadget driver. This driver is glue between
> the USB gadget interface and the ALSA MIDI interface.

Looks good.  (Not that I tested it.  ;-)

Some remarks below.

> +config USB_MIDI_GADGET
> +	tristate "MIDI Gadget (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL

You need something like this:
	depends on SND
	select SND_RAWMIDI

> +#include <sound/asequencer.h>

This header isn't needed.

> +	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1, THIS_MODULE, 0);

Other ALSA drivers have module options for index and id.

I could imagine that a synthesizer has another sound card for PCM
output; it would make sense for at least the index to be configurable.

> +enomem:
> +	...
> +	return -ENOMEM;

These error handlers could return err instead.


Regards,
Clemens

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
