From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] usbaudio.c: remove #ifndef
	CONFIG_USB_EHCI_SPLIT_ISO	code
Date: Thu, 5 Jun 2008 21:24:10 +0300
Message-ID: <20080605182335.GD1469@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 31FBC24366
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 20:24:47 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
List-Id: alsa-devel@alsa-project.org

Since USB_EHCI_SPLIT_ISO is now unconditionally enabled the
#ifndef CONFIG_USB_EHCI_SPLIT_ISO became wrong.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
e532a1cdc3f2ece89567abd4cd0c219a8e749e3a diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 410be4a..b8cfb7c 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -819,10 +819,6 @@ static const char *usb_error_string(int err)
 		return "device disabled";
 	case -EHOSTUNREACH:
 		return "device suspended";
-#ifndef CONFIG_USB_EHCI_SPLIT_ISO
-	case -ENOSYS:
-		return "enable CONFIG_USB_EHCI_SPLIT_ISO to play through a hub";
-#endif
 	case -EINVAL:
 	case -EAGAIN:
 	case -EFBIG:
