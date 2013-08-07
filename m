From: =?koi8-r?B?4s/Ky88g7cHL08nN?= <maksboyko@yandex.ru>
Subject: Re: Linux 3.10.4 and Logitech HD Webcam C525/C310
Date: Wed, 07 Aug 2013 14:37:11 +0400
Message-ID: <800141375871831@web3e.yandex.ru>
References: <36731375776759@web15h.yandex.ru>
 <Pine.LNX.4.44L0.1308060958070.1154-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9.mail.yandex.net (forward9.mail.yandex.net
 [77.88.61.48]) by alsa0.perex.cz (Postfix) with ESMTP id 50458261B11
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 12:37:14 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1308060958070.1154-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Alan,

Thank you very much for  quick response and the patch. The patch fixed the mic on both cameras.

I have also added the following patch (see https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=36691e1be6ec551eef4a5225f126a281f8c051c2) for avoiding the kernel warning.

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

--
Maksim Boyko
