From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Pain and anguish: ALSA CVS and Linux-2.4.20
Date: Sun, 1 Dec 2002 18:33:14 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021201183314.93948.qmail@web40606.mail.yahoo.com>
References: <Pine.LNX.4.33.0212011920130.534-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212011920130.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote:
> Could you try the current CVS? Hopefully, I fixed
> the problem.

Just one small spelling mistake ;-)

Index: alsa-kernel/core/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/control.c,v
retrieving revision 1.21
diff -u -u -r1.21 control.c
--- alsa-kernel/core/control.c  1 Dec 2002 18:20:16
-0000       1.21
+++ alsa-kernel/core/control.c  1 Dec 2002 18:32:25
-0000
@@ -132,7 +132,7 @@
                        control->owner = NULL;
        }
        write_unlock(&card->control_owner_lock);
-       write_lock_irqrestore(&card->control_rwlock,
flags);
+       write_unlock_irqrestore(&card->control_rwlock,
flags);
        snd_ctl_empty_read_queue(ctl);
        snd_magic_kfree(ctl);
        dec_mod_count(card->module);

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
