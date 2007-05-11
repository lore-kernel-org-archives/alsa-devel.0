From: "thomas@devbase.at" <thomas@devbase.at>
Subject: [PATCH] Coping with short replies in usbmixer
Date: Fri, 11 May 2007 22:28:16 +0200
Message-ID: <4644D1E0.2010203@devbase.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060208000405070703050605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpgw01.world4you.com (smtpgw01.world4you.com [80.243.163.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D0E66244AF
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 22:28:18 +0200 (CEST)
Received: from [85.124.169.7] (helo=[192.168.1.76])
	by smtpgw01.world4you.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67) (envelope-from <thomas@devbase.at>) id 1Hmbir-0000NY-TY
	for alsa-devel@alsa-project.org; Fri, 11 May 2007 22:28:18 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060208000405070703050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
while trying to find out why a USB handset (Yealink P1K) frequently gets 
muted when changing volume, I found that short USB responses cause the 
problem.

The function get_ctl_value(..) in usbmixer.c requests the state of a 
certain control and retries up to 10 times if an error occurs. However a 
short USB response is not treated as an error as neither the transfer 
flag URB_SHORT_NOT_OK is set nor is the return value of 
snd_usb_ctl_msg(..) compared with the requested amount of data. As a 
result the function get_ctl_value(..) might not retry the USB request 
but returns an unpredictable result without reporting an error.

The attached patch forces the number of returned bytes to be at least 
val_len. It was generated from kernel version 2.6.21. If there are any 
issues with the patch please let me know. Otherwise I would be happy if 
it could be applied to the ALSA sources.
Regards,
-Thomas

--------------060208000405070703050605
Content-Type: text/x-patch;
 name="usbmixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbmixer.patch"

diff -rup a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
--- a/sound/usb/usbmixer.c	2007-05-11 21:58:33.000000000 +0200
+++ b/sound/usb/usbmixer.c	2007-05-11 21:59:14.000000000 +0200
@@ -360,7 +360,7 @@ static int get_ctl_value(struct usb_mixe
 				    request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    validx, cval->mixer->ctrlif | (cval->id << 8),
-				    buf, val_len, 100) >= 0) {
+				    buf, val_len, 100) >= val_len) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
 			return 0;
 		}

--------------060208000405070703050605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060208000405070703050605--
