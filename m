From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Still one lock to fix in init.c
Date: Sun, 8 Dec 2002 21:56:44 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021208215644.93438.qmail@web40611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I think you missed one ;-) ...

Cheers,
Chris

Index: alsa-kernel/core/init.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/init.c,v
retrieving revision 1.24
diff -u -u -r1.24 init.c
--- alsa-kernel/core/init.c     8 Dec 2002 11:08:38
-0000       1.24
+++ alsa-kernel/core/init.c     8 Dec 2002 21:54:22
-0000
@@ -154,7 +154,7 @@
 
        spin_lock(&card->files_lock);
        if (card->shutdown) {
-               write_unlock(&card->files_lock);
+               spin_unlock(&card->files_lock);
                return 0;
        }
        card->shutdown = 1;


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
