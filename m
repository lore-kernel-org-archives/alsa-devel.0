From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 31/39] sound/wavefront_synth: insert set_current_state() before schedule_timeout()
Date: Fri, 21 Jan 2005 11:49:29 -0800
Message-ID: <20050121194929.GL3340__16543.2616755881$1106337090$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4061D1FF
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:49:33 +0100 (MET)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0LJnVCO273670
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:49:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJnV7I321604
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:49:31 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJnULe001242
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:49:30 -0700
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

Description: Insert set_current_state() before schedule_timeout(). Without the
insertion, schedule_timeout() returns immediately, resulting in an effective
busy-wait.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/isa/wavefront/wavefront_synth.c	2005-01-15 16:55:45.000000000 -0800
+++ 2.6.11-rc1-kj/sound/isa/wavefront/wavefront_synth.c	2005-01-18 13:38:54.000000000 -0800
@@ -1751,6 +1751,7 @@ wavefront_should_cause_interrupt (snd_wa
 	outb (val,port);
 	spin_unlock_irq(&dev->irq_lock);
 	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		if ((timeout = schedule_timeout(timeout)) == 0)
 			return;
 		if (dev->irq_ok)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
