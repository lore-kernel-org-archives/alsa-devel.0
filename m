From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Re: devfs_remove() not present in linux 2.4.19
Date: Sat, 23 Nov 2002 21:13:46 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021123211346.64077.qmail@web40612.mail.yahoo.com>
References: <Pine.LNX.4.33.0211232146090.503-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211232146090.503-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

OK, thanks. One minor point, though ;-):

$ cvsalsa diff -u alsa-driver/acore/misc.c
Index: alsa-driver/acore/misc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/misc.c,v
retrieving revision 1.11
diff -u -u -r1.11 misc.c
--- alsa-driver/acore/misc.c    23 Nov 2002 20:51:05
-0000      1.11
+++ alsa-driver/acore/misc.c    23 Nov 2002 21:12:50
-0000
@@ -6,7 +6,7 @@
 
 #include <linux/devfs_fs_kernel.h>
 
-void snd_compat_devfs_remove(const char *str, ...)
+void snd_compat_devfs_remove(const char *fmt, ...)
 {
        char buf[64];
        va_list args;

Cheers,
Chris

 --- Jaroslav Kysela <perex@suse.cz> wrote: > On Sat,
23 Nov 2002, [iso-8859-1] Chris Rankin
> wrote:
> 
> > Hi,
> > 
> > I am having problems with the latest ALSA CVS
> using
> > Linux 2.4.19-SMP and devfs. Specifically:
> > 
> > # depmod -ae
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.19/kernel/drivers/sound/snd.o
> > depmod:         devfs_remove
> 
> Fixed. I forgot to commit code in alsa-driver
> directory from my disc ;-(
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 
>
-------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel 

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
