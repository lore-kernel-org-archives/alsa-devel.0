From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [alsa-driver patch] inclide/adriver.h: fix warning about
 CONFIG_ISA_DMA_API redefinition
Date: Sun, 11 Sep 2005 22:36:11 +0300
Message-ID: <20050911193611.GA31765@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

With recent CVS I've got warnings like this:

In file included from /home/sasha/src/alsa/alsa-driver/include/sound/driver.h:42,
                 from /home/sasha/src/alsa/alsa-driver/alsa-kernel/core/pcm.c:22,
                 from /home/sasha/src/alsa/alsa-driver/acore/pcm.c:1:
/home/sasha/src/alsa/alsa-driver/include/adriver.h:193:1: warning: "CONFIG_ISA_DMA_API" redefined
In file included from include/linux/config.h:4,
                 from /home/sasha/src/alsa/alsa-driver/include/sound/driver.h:29,
                 from /home/sasha/src/alsa/alsa-driver/alsa-kernel/core/pcm.c:22,
                 from /home/sasha/src/alsa/alsa-driver/acore/pcm.c:1:
include/linux/autoconf.h:242:1: warning: this is the location of the previous definition

, etc.

The patch below fixes it.

Sasha.




Fix warnings about CONFIG_ISA_DMA_API redefinition.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-driver/include/adriver.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/include/adriver.h,v
retrieving revision 1.138
diff -u -p -r1.138 adriver.h
--- alsa-driver/include/adriver.h	9 Sep 2005 16:39:11 -0000	1.138
+++ alsa-driver/include/adriver.h	11 Sep 2005 17:00:36 -0000
@@ -190,9 +190,11 @@ static inline struct proc_dir_entry *PDE
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 13)
 #ifdef CONFIG_SND_ISA
+#ifndef CONFIG_ISA_DMA_API
 #define CONFIG_ISA_DMA_API
 #endif
 #endif
+#endif
 
 #include <linux/types.h>
 #ifndef __bitwise


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
