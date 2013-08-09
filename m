From: Maxim Boyko <boyko-L3tJ7cdLR+rxeVrPMhq8FSjHesifYMBh@public.gmane.org>
Subject: [PATCH] usb-audio: Fix invalid volume resolution for Logitech HD
 Webcam C525
Date: Fri, 9 Aug 2013 12:37:49 +0400 (MSK)
Message-ID: <alpine.LNX.2.02.1308091232400.26590@pcqnt1.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Add the volume control quirk for avoiding the kernel warning
for the Logitech HD Webcam C525
as in the similar commit 36691e1be6ec551eef4a5225f126a281f8c051c2
for the Logitech HD Webcam C310.

Reported-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 3.10.5+
Signed-off-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
  sound/usb/mixer.c |    1 +
  1 file changed, 1 insertion(+)

--- linux-3.10.5-orig/sound/usb/mixer.c	2013-08-04 12:51:49.000000000 
+0400
+++ linux-3.10.5/sound/usb/mixer.c	2013-08-06 21:12:42.274197287 
+0400
@@ -888,6 +888,7 @@ static void volume_control_quirks(struct
  	case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
  	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
  	case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
+	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
  	case USB_ID(0x046d, 0x0991):
  	/* Most audio usb devices lie about volume resolution.
  	 * Most Logitech webcams have res = 384.


--
WBR, Maksim

P.S. Please, use this patch due to it should have correct tab symbols.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
