From: =?koi8-r?B?4s/Ky88g7cHL08nN?= <maksboyko@yandex.ru>
Subject: [PATCH] Fix invalid volume resolution for Logitech HD
	Webcam C525
Date: Wed, 07 Aug 2013 23:24:46 +0400
Message-ID: <80181375903486@web11g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward19.mail.yandex.net (forward19.mail.yandex.net
 [95.108.253.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 95509265603
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 21:24:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Maksim Boyko <maksim.a.boyko@gmail.com>

Add the volume control quirk for avoiding the kernel warning for Logitech HD Webcam C525.
The similar patch was previously reported for Logitech HD Webcam C310 (see 36691e1be6ec551eef4a5225f126a281f8c051c2).

--- linux-3.10.5-orig/sound/usb/mixer.c	2013-08-04 12:51:49.000000000 +0400
+++ linux-3.10.5/sound/usb/mixer.c	2013-08-06 21:12:42.274197287 +0400
@@ -888,6 +888,7 @@
         case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
         case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
         case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
+	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
         case USB_ID(0x046d, 0x0991):
         /* Most audio usb devices lie about volume resolution.
          * Most Logitech webcams have res = 384.
