From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: [PATCH] Add missing break to sound_core.c
Date: Fri, 19 Apr 2002 09:19:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16ySgL-00019x-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mel-rto2.wanadoo.fr (smtp-out-2.wanadoo.fr [193.252.19.254])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA32446
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 09:20:33 +0200
Received: from duncan by baldrick with local (Exim 3.35 #1 (Debian))
	id 16ySgL-00019x-00
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 09:19:45 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch is against 2.5.8.  It is not needed for 2.4.18.
It adds in a missing break.

All the best,

Duncan.

--- linux-2.5.8.orig/sound/sound_core.c	Sun Apr 14 21:18:51 2002
+++ linux-2.5.8/sound/sound_core.c	Fri Apr 19 09:14:39 2002
@@ -243,6 +243,7 @@
 		if (unit >= SOUND_STEP)
 			goto __unknown;
 		max_unit = unit + 1;
+		break;
 	    case 2:
 		name = "midi";
 		break;
