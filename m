From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 29/39] sound/rawmidi: replace schedule_timeout() with msleep()
Date: Fri, 21 Jan 2005 11:44:55 -0800
Message-ID: <20050121194455.GJ3340__37753.5049607561$1106336823$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B53D321B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:45:04 +0100 (MET)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0LJj2CO173364
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:45:02 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJj2sA447340
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:45:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJj1Ol022154
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:45:01 -0700
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

Description: Use msleep instead of schedule_timeout() to guarantee the task
delays as expected. This also removes a dependence on the value of HZ.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/core/rawmidi.c	2005-01-15 16:55:44.000000000 -0800
+++ 2.6.11-rc1-kj/sound/core/rawmidi.c	2005-01-18 13:24:06.000000000 -0800
@@ -29,6 +29,7 @@
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
+#include <linux/delay.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -149,10 +150,8 @@ int snd_rawmidi_drain_output(snd_rawmidi
 		/* we need wait a while to make sure that Tx FIFOs are empty */
 		if (substream->ops->drain)
 			substream->ops->drain(substream);
-		else {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(HZ / 20);
-		}
+		else
+			msleep(50);
 		snd_rawmidi_drop_output(substream);
 	}
 	return err;


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
