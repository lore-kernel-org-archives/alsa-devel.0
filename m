From: Thomas Reitmayr <thomas@devbase.at>
Subject: Re: [PATCH] Coping with short replies in usbmixer
Date: Mon, 14 May 2007 19:54:34 +0200
Message-ID: <1179165274.10762.12.camel@tomcom.at.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpgw01.world4you.com (smtpgw01.world4you.com [80.243.163.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 723452470A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 19:54:45 +0200 (CEST)
Received: from [85.124.169.7] (helo=[192.168.1.76])
	by smtpgw01.world4you.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.67) (envelope-from <thomas@devbase.at>) id 1Hnekt-0003vL-Tj
	for alsa-devel@alsa-project.org; Mon, 14 May 2007 19:54:44 +0200
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

Hi,
here is it again and signed off.

This patch makes sure that short USB replies are treated as an
error when requesting the value of a certain mixer control.

Signed-off-by: Thomas Reitmayr <thomas@devbase.at>
---

 sound/usb/usbmixer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


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
