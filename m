From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 32/33] sound/rawmidi: replace interruptible_sleep_on_timeout() with wait_event_interruptible_timeout()
Date: Tue, 25 Jan 2005 16:47:25 -0800
Message-ID: <20050126004725.GX12649__36771.0877595984$1106700491$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1CE44220
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 01:47:32 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0Q0lUua004669
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 19:47:31 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0Q0lQEr060008
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 19:47:30 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0Q0lQJO029541
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 19:47:26 -0500
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please consider applying.

Description: Use wai_event_interruptible_timeout() instead of
deprecated interruptible_sleep_on_timeout(). Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/sound/core/rawmidi.c	2005-01-25 16:45:12.000000000 -0800
+++ 2.6.11-rc2-kj/sound/core/rawmidi.c	2005-01-24 17:22:36.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
+#include <linux/wait.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -133,17 +134,14 @@ int snd_rawmidi_drain_output(snd_rawmidi
 
 	err = 0;
 	runtime->drain = 1;
-	while (runtime->avail < runtime->buffer_size) {
-		timeout = interruptible_sleep_on_timeout(&runtime->sleep, 10 * HZ);
-		if (signal_pending(current)) {
-			err = -ERESTARTSYS;
-			break;
-		}
-		if (runtime->avail < runtime->buffer_size && !timeout) {
-			snd_printk(KERN_WARNING "rawmidi drain error (avail = %li, buffer_size = %li)\n", (long)runtime->avail, (long)runtime->buffer_size);
-			err = -EIO;
-			break;
-		}
+	timeout = wait_event_interruptible_timeout(runtime->sleep,
+				(runtime->avail >= runtime->buffer_size),
+				10*HZ);
+	if (signal_pending(current))
+		err = -ERESTARTSYS;
+	if (runtime->avail < runtime->buffer_size && !timeout) {
+		snd_printk(KERN_WARNING "rawmidi drain error (avail = %li, buffer_size = %li)\n", (long)runtime->avail, (long)runtime->buffer_size);
+		err = -EIO;
 	}
 	runtime->drain = 0;
 	if (err != -ERESTARTSYS) {


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
