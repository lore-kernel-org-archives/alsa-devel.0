From: denk <denk@post.com>
Subject: Plantronics DA45 cannot get freq at ep 0x4
Date: Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Message-ID: <1712952849.47831328.1455441745316.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by alsa0.perex.cz (Postfix) with ESMTP id EBD02260509
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 926A4761182
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id GQ1W8Hcllomc for <alsa-devel@alsa-project.org>;
 Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 75E0A7615CD
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id S_LyUOljTQPK for <alsa-devel@alsa-project.org>;
 Sun, 14 Feb 2016 10:22:25 +0100 (CET)
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by skylla.efm.de (Postfix) with ESMTP id 601F7761182
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2016 10:22:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

using the Plantronics DA45 Headset Adapter leads to many lines of cannot get freq at ep 0x4 and cannot get freq at ep 0x84. I found a similar error in the following discussion: http://www.spinics.net/lists/linux-usb/msg125029.html
I added the USB ID of the DA45, recompiled the kernel and the messages are gone. I would be happy if you could accept this simple addition made by the following patch:

--- a/sound/usb/quirks.c	2015-12-15 06:41:43.000000000 +0100
+++ b/sound/usb/quirks.c	2016-01-28 08:15:35.207785555 +0100
@@ -1122,6 +1122,7 @@
 	case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
+	case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
 		return true;
 	}
 	return false;

If there are any questions or something missing, please ask.

Thanks in advance.
Best
denk
