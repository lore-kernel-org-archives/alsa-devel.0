From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 27/39] sound/gus_pcm: insert set_current_state() before schedule_timeout()
Date: Fri, 21 Jan 2005 11:36:36 -0800
Message-ID: <20050121193636.GH3340__20088.146281387$1106336368$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9F30321B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 20:36:39 +0100 (MET)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0LJac7j001848
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:36:38 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0LJabDW278392
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:36:37 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0LJab3o019961
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 14:36:37 -0500
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
insertion, schedule_timeout() returns immediately.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc1-kj-v/sound/isa/gus/gus_pcm.c	2005-01-15 16:55:45.000000000 -0800
+++ 2.6.11-rc1-kj/sound/isa/gus/gus_pcm.c	2005-01-18 13:27:24.000000000 -0800
@@ -333,6 +333,7 @@ static int snd_gf1_pcm_poke_block(snd_gu
 			}
 		}
 		if (count > 0 && !in_interrupt()) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 			if (signal_pending(current))
 				return -EAGAIN;


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
