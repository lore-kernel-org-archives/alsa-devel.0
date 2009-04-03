From: Viral Mehta <viral.mehta@einfochips.com>
Subject: [PATCH][TRIVIAL] remove extra space
Date: Fri, 03 Apr 2009 13:08:14 +0530
Message-ID: <49D5BCE6.9070901@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id B5B1110380A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:41:52 +0200 (CEST)
Received: from unknown (HELO [192.168.14.27]) (viral.mehta@[192.168.14.27])
	(envelope-sender <viral.mehta@einfochips.com>)
	by ahmedabad.einfochips.com (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 3 Apr 2009 07:39:48 -0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org


Just for the sake of readability, removing extra space

Signed-off-by: Viral Mehta <viral.mehta@einfochips.com>
--- 

--- a/sound/usb/usbmixer.c        2009-03-24 04:42:14.000000000 +0530
+++ b/sound/usb/usbmixer.c    2009-04-03 12:49:49.000000000 +0530
@@ -394,7 +394,7 @@ static int set_ctl_value(struct usb_mixe
        value_set = convert_bytes_value(cval, value_set);
        buf[0] = value_set & 0xff;
        buf[1] = (value_set >> 8) & 0xff;
-       while (timeout -- > 0)
+       while (timeout-- > 0)
                if (snd_usb_ctl_msg(cval->mixer->chip->dev,
                                    usb_sndctrlpipe(cval->mixer->chip->dev, 0),
                                    request,
