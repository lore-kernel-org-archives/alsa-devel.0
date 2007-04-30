From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] snd-usb-audio: explicitly match
	Logitech QuickCam
Date: Mon, 30 Apr 2007 10:15:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704301008220.3269-100000@iolanthe.rowland.org>
References: <20070430031301.206B07B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070430031301.206B07B409F@zog.reactivated.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Daniel Drake <dsd@gentoo.org>
Cc: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Apr 2007, Daniel Drake wrote:

> Commit 93c8bf45e083b89dffe3a708363c15c1b220c723 modified the USB device
> matching behaviour to ignore interface class matches if the device class
> is vendor-specific.
> 
> This patch adds an explicit ID match for the Logitech QuickCam Messenger,
> which has a vendor specific device class (but standards-compliant audio
> interfaces).
> 
> This fixes a 2.6.20 regression where the audio component of this device was
> no longer usable.
> 
> http://bugs.gentoo.org/show_bug.cgi?id=175715
> https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/93822
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3040
> 
> Based on a patch from sergiom
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> Index: linux/sound/usb/usbquirks.h
> ===================================================================
> --- linux.orig/sound/usb/usbquirks.h
> +++ linux/sound/usb/usbquirks.h
> @@ -40,6 +40,21 @@
>  	.bInterfaceClass = USB_CLASS_VENDOR_SPEC
>  
>  /*
> + * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
> + * class matches do not take effect without an explicit ID match.
> + */
> +
> +{
> +	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
> +		       USB_DEVICE_ID_MATCH_INT_CLASS |
> +		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
> +	.idVendor = 0x046d,
> +	.idProduct = 0x08f0,
> +	.bInterfaceClass = USB_CLASS_AUDIO,
> +	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
> +},
> +
> +/*
>   * Yamaha devices
>   */

This ought to fix the problem.

You might want to consider adding a macro to include/linux/usb.h to handle
cases like this.  Something like USB_DEVICE_AND_INTERFACE_INFO() -- it
would make life easier for other people in the future when faced with the
same problem.

Alan Stern


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
