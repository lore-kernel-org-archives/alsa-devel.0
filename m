From: Graeme Gregory <gg@wolfsonmicro.com>
Subject: [PATCH] ASoC S3C24xx machine drivers - lm4857-h
	missing patch
Date: Mon, 18 Jun 2007 13:59:06 +0100
Message-ID: <1182171546.5326.3.camel@gg-desktop.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lreZKdvw1cwBrS0qS1le"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id A819B2439D
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 14:59:55 +0200 (CEST)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T804b8ab3e6ac14080514b0@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 13:59:55 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--=-lreZKdvw1cwBrS0qS1le
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Somewhere when dealing with the s3c24xx patches and requested changes I
managed to miss this file on re-submission.

Its a header file required for compilation of neo1973-wm8573.c and
should be a no brainer.

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>

Graeme


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-lreZKdvw1cwBrS0qS1le
Content-Disposition: attachment; filename="lm4857-h.patch"
Content-Type: text/x-patch; name="lm4857-h.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 96495fe7cc13 soc/s3c24xx/lm4857.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/lm4857.h	Mon Jun 18 13:50:03 2007 +0100
@@ -0,0 +1,32 @@
+/*
+ * lm4857.h  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    18th Jun 2007   Initial version.
+ */
+
+#ifndef LM4857_H_
+#define LM4857_H_
+
+/* The register offsets in the cache array */
+#define LM4857_MVOL 0
+#define LM4857_LVOL 1
+#define LM4857_RVOL 2
+#define LM4857_CTRL 3
+
+/* the shifts required to set these bits */
+#define LM4857_3D 5
+#define LM4857_WAKEUP 5
+#define LM4857_EPGAIN 4
+
+#endif /*LM4857_H_*/
+

--=-lreZKdvw1cwBrS0qS1le
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-lreZKdvw1cwBrS0qS1le--
