From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 55/63] sound/usbmixer: change parameters of usb_{control,bulk}_msg() to msecs
Date: Tue, 8 Feb 2005 22:42:24 -0800
Message-ID: <20050209064224.GZ1419@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9EC5F26D
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 18:14:50 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.10) with ESMTP id j19HEn4f022813
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 12:14:49 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j19HEm2t220692
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 12:14:48 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j19HEmmp020591
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 12:14:48 -0500
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hi,

Description: Change units of parameters being passed to
usb_{control,bulk}_msg() to milliseconds. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-rc3-kj-v/sound/usb/usbmixer.c	2005-02-03 16:57:41.000000000 -0800
+++ 2.6.11-rc3-kj/sound/usb/usbmixer.c	2005-02-08 14:14:07.000000000 -0800
@@ -305,7 +305,7 @@ static int get_ctl_value(usb_mixer_elem_
 				    request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    validx, cval->ctrlif | (cval->id << 8),
-				    buf, val_len, HZ / 10) >= 0) {
+				    buf, val_len, 100) >= 0) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
 			return 0;
 		}
@@ -343,7 +343,7 @@ static int set_ctl_value(usb_mixer_elem_
 				    request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				    validx, cval->ctrlif | (cval->id << 8),
-				    buf, val_len, HZ / 10) >= 0)
+				    buf, val_len, 100) >= 0)
 			return 0;
 	snd_printdd(KERN_ERR "cannot set ctl value: req = 0x%x, wValue = 0x%x, wIndex = 0x%x, type = %d, data = 0x%x/0x%x\n", request, validx, cval->ctrlif | (cval->id << 8), cval->val_type, buf[0], buf[1]);
 	return -EINVAL;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
