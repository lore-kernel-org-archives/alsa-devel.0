From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Compile warning: lock types in alsa-kernel/core/init.c
Date: Sat, 7 Dec 2002 23:15:18 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021207231518.93281.qmail@web40601.mail.yahoo.com>
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

I was compiling the ALSA CVS drivers this evening when
I saw this compiler warning whizz past. I think that
this lock is a spinlock and not a rwlock.

Cheers,
Chris

Index: alsa-kernel/core/init.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/init.c,v
retrieving revision 1.23
diff -u -u -r1.23 init.c
--- alsa-kernel/core/init.c     4 Dec 2002 14:57:32
-0000       1.23
+++ alsa-kernel/core/init.c     7 Dec 2002 23:12:19
-0000
@@ -152,13 +152,13 @@
        struct file_operations *f_ops, *old_f_ops;
        int err;
 
-       write_lock(&card->files_lock);
+       spin_lock(&card->files_lock);
        if (card->shutdown) {
-               write_unlock(&card->files_lock);
+               spin_unlock(&card->files_lock);
                return 0;
        }
        card->shutdown = 1;
-       write_unlock(&card->files_lock);
+       spin_unlock(&card->files_lock);
 
        /* phase 1: disable fops (user space)
operations for ALSA API */
        write_lock(&snd_card_rwlock);


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
