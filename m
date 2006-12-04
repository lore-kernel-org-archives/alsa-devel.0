From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] Additional credits to soc-core
Date: Mon, 04 Dec 2006 14:58:11 +0000
Message-ID: <1165244291.17141.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UR5ZcKwh+jrc6RFyGouf"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org


--=-UR5ZcKwh+jrc6RFyGouf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds copyright and credit for my good friend Richard Purdie
from OpenedHand for his help and code contribution throughout the
development of the core code. Many thanks Richard (I guess we overlooked
this in trying to get everything working well).

It also adds some extra comments wrt to DAI clock matching.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-UR5ZcKwh+jrc6RFyGouf
Content-Disposition: attachment; filename=soc-core-credit.patch
Content-Type: text/x-patch; name=soc-core-credit.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bc7ef767d0cf soc/soc-core.c
--- a/soc/soc-core.c	Wed Nov 29 15:29:40 2006 +0100
+++ b/soc/soc-core.c	Mon Dec 04 14:25:36 2006 +0000
@@ -2,8 +2,12 @@
  * soc-core.c  --  ALSA SoC Audio Layer
  *
  * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
  * Author: Liam Girdwood
  *         liam.girdwood@wolfsonmicro.com or linux@wolfsonmicro.com
+ *         with code, comments and ideas from :-
+ *         Richard Purdie <richard@openedhand.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -518,7 +522,8 @@ found:
 	 * Check we have matching bitclocks. If we don't then it means the
 	 * sysclock returned by either the codec or cpu DAI (selected by the
 	 * machine sysclock function) is wrong compared with the supported DAI
-	 * modes for the codec or cpu DAI.
+	 * modes for the codec or cpu DAI. Check  your codec or CPU DAI
+	 * config_sysclock() functions.
 	 */
 	if (cpu_bclk != codec_bclk && cpu_bclk){
 		printk(KERN_ERR

--=-UR5ZcKwh+jrc6RFyGouf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-UR5ZcKwh+jrc6RFyGouf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-UR5ZcKwh+jrc6RFyGouf--
