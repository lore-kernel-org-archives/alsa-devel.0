From: eliot@blennerhassett.gen.nz
Subject: [PATCH] Refresh patch,
	.reset_resume added to struct usb_driver
Date: Sun, 09 Feb 2014 17:38:22 +1300
Message-ID: <1391920702-18430-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB4E2610B7
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2014 05:38:30 +0100 (CET)
Received: from mxin2-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp5.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0N0P00CR5OW2NU40@smtp5.clear.net.nz> for
 alsa-devel@alsa-project.org; Sun, 09 Feb 2014 17:38:27 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 alsa/usb/card.patch |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/alsa/usb/card.patch b/alsa/usb/card.patch
index 679bf15..a37c93d 100644
--- a/alsa/usb/card.patch
+++ b/alsa/usb/card.patch
@@ -1,5 +1,5 @@
---- ../alsa-kernel/usb/card.c	2013-10-09 14:00:50.128683771 +0200
-+++ card.c	2013-10-15 15:45:31.779430219 +0200
+--- ../alsa-kernel/usb/card.c	2014-02-09 14:35:45.872517538 +1300
++++ card.c	2014-02-09 16:45:45.116673978 +1300
 @@ -1,3 +1,4 @@
 +#include "card.inc"
  /*
@@ -67,15 +67,15 @@
  /*
   * new 2.5 USB kernel API
   */
-@@ -727,6 +742,7 @@
- #define usb_audio_suspend	NULL
+@@ -738,6 +753,7 @@
  #define usb_audio_resume	NULL
+ #define usb_audio_reset_resume	NULL
  #endif		/* CONFIG_PM */
 +#endif	/* OLD_USB */
  
  static struct usb_device_id usb_audio_ids [] = {
  #include "quirks-table.h"
-@@ -742,13 +758,25 @@
+@@ -753,14 +769,25 @@
   */
  
  static struct usb_driver usb_audio_driver = {
@@ -88,6 +88,7 @@
 +#ifndef OLD_USB
  	.suspend =	usb_audio_suspend,
  	.resume =	usb_audio_resume,
+-	.reset_resume =	usb_audio_reset_resume,
 +#endif
 +#ifdef OLD_USB
 +	.driver_list =	LIST_HEAD_INIT(usb_audio_driver.driver_list), 
-- 
1.7.10.4
