From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Makefile fix for SoundScape
Date: Wed, 21 May 2003 01:06:23 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305210006.h4L06NBC008672@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

Here's a simple fix for the CVS Makefiles. Using this, I can now build the snd-sscape.o driver.

Cheers,
Chris

Index: alsa-kernel/isa/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/Makefile,v
retrieving revision 1.8
diff -u -r1.8 Makefile
--- alsa-kernel/isa/Makefile	17 Dec 2002 20:00:40 -0000	1.8
+++ alsa-kernel/isa/Makefile	21 May 2003 00:04:44 -0000
@@ -10,6 +10,7 @@
 snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sgalaxy-objs := sgalaxy.o
+snd-sscape-objs := sscape.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-als100.o
@@ -19,6 +20,7 @@
 obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
+obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
 		     sb/ wavefront/


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
