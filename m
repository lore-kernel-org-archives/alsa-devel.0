From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 30/39] sound/vx_core: replace schedule_timeout() with msleep()
Date: Fri, 21 Jan 2005 11:47:31 -0800
Message-ID: <20050121194731.GK3340__22599.4664164775$1106336950$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0084721B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:47:33 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0LJlWJX028779
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:47:32 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJlWDW278498
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:47:32 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJlWjx020055
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:47:32 -0500
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
To: tiwai@suse.de, perex@suse.cz
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please consider applying.

Description: Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. The check for xmsec >= 1000 / HZ seems wrong to me, as well,
since if HZ==100, that means we could mdelay() for 9 msecs! msleep() should be
usable in all cases when not in an interrupt handler.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/drivers/vx/vx_core.c	2005-01-15 16:55:45.000000000 -0800
+++ 2.6.11-rc1-kj/sound/drivers/vx/vx_core.c	2005-01-18 13:26:06.000000000 -0800
@@ -45,9 +45,8 @@ MODULE_LICENSE("GPL");
  */
 void snd_vx_delay(vx_core_t *chip, int xmsec)
 {
-	if (! in_interrupt() && xmsec >= 1000 / HZ) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((xmsec * HZ + 999) / 1000);
+	if (!in_interrupt()) {
+		msleep(xmsec);
 	} else {
 		mdelay(xmsec);
 	}


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
