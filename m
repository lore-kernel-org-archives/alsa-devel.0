From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 28/39] sound/gus_reset: replace schedule_timeout() with msleep_interruptible()
Date: Fri, 21 Jan 2005 11:38:05 -0800
Message-ID: <20050121193805.GI3340__39419.3162829199$1106336489$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4256B21B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:38:09 +0100 (MET)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0LJc7m4099666
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:38:07 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJc77I259114
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:38:07 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJc6NY005164
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 12:38:06 -0700
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

Description: Use msleep_interruptible() instead of custom wait code involving
schedule_timeout() to guarantee the task delays as expected. This also removes a
dependence on the value of HZ.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/isa/gus/gus_reset.c	2005-01-15 16:55:45.000000000 -0800
+++ 2.6.11-rc1-kj/sound/isa/gus/gus_reset.c	2005-01-18 13:30:43.000000000 -0800
@@ -207,7 +207,6 @@ void snd_gf1_stop_voices(snd_gus_card_t 
 	unsigned long flags;
 	short i, ramp_ok;
 	unsigned short ramp_end;
-	long time;
 
 	if (!in_interrupt()) {	/* this can't be done in interrupt */
 		for (i = v_min, ramp_ok = 0; i <= v_max; i++) {
@@ -227,11 +226,7 @@ void snd_gf1_stop_voices(snd_gus_card_t 
 			}
 			spin_unlock_irqrestore(&gus->reg_lock, flags);
 		}
-		time = HZ / 20;
-		while (time > 0 && !signal_pending(current)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			time = schedule_timeout(time);
-		}
+		msleep_interruptible(50);
 	}
 	snd_gf1_clear_voices(gus, v_min, v_max);
 }


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
