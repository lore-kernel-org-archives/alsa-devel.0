From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 26/39] sound/emu8000: replace schedule_timeout() with msleep()
Date: Fri, 21 Jan 2005 11:35:00 -0800
Message-ID: <20050121193500.GG3340__11075.393917463$1106336238$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9A7B21B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:35:03 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0LJZ2SK027963
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:35:02 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJZ1DW277624
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:35:02 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJZ1nT014895
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:35:01 -0500
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
To: perex@suse.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please consider applying.

Description: Use ssleep() instead of schedule_timeout() to guarantee the task
delays as expected. The current code uses TASK_INTERRUPTIBLE, but does not check
for signals / early return, so ssleep() should be appropriate. I am fairly
certain the time conversion is ok, as well.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/isa/sb/emu8000.c	2005-01-15 16:55:45.000000000 -0800
+++ 2.6.11-rc1-kj/sound/isa/sb/emu8000.c	2005-01-21 11:32:38.000000000 -0800
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/emu8000.h>
 #include <sound/emu8000_reg.h>
@@ -355,8 +356,7 @@ init_arrays(emu8000_t *emu)
 {
 	send_array(emu, init1, ARRAY_SIZE(init1)/4);
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ * (44099 + 1024)) / 44100); /* wait for 1024 clocks */
+	ssleep(1);
 	send_array(emu, init2, ARRAY_SIZE(init2)/4);
 	send_array(emu, init3, ARRAY_SIZE(init3)/4);
 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
