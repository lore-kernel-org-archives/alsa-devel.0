From: Pavel Roskin <proski@gnu.org>
Subject: Compile error in timer.c
Date: Thu, 6 Feb 2003 15:19:12 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50.0302061514150.27699-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
List-Id: alsa-devel@alsa-project.org

Hello!

This error was introduced on CVS just minutes ago:

gcc -D__KERNEL__ -DMODULE=1 -I/usr/local/src/alsa/alsa-driver/include
-I/lib/modules/2.4.20/build/include -O2 -mpreferred-stack-boundary=2
-march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-DEXPORT_SYMTAB -c timer.c
In file included from timer.c:1:
../alsa-kernel/core/timer.c: In function `snd_timer_user_interrupt':
../alsa-kernel/core/timer.c:956: `ctl' undeclared (first use in this
function)
../alsa-kernel/core/timer.c:956: (Each undeclared identifier is reported
only once
../alsa-kernel/core/timer.c:956: for each function it appears in.)

Patch (works for me, produces reasonable sounds):

======================
--- alsa-kernel/core/timer.c	6 Feb 2003 19:21:11 -0000	1.23
+++ alsa-kernel/core/timer.c	6 Feb 2003 20:15:57 -0000
@@ -953,7 +953,7 @@
 	}
 	spin_unlock(&tu->qlock);
 	if (_wake) {
-		kill_fasync(&ctl->fasync, SIGIO, POLL_IN);
+		kill_fasync(&tu->fasync, SIGIO, POLL_IN);
 		wake_up(&tu->qchange_sleep);
 	}
 }
======================

-- 
Regards,
Pavel Roskin


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
