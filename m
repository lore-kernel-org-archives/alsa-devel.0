From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] memory_wrapper.c compilation fix
Date: Mon, 14 Apr 2003 08:30:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304140829270.3123-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


Including the Makefile in alsa-kernel overwrites the contents of the
snd-page-alloc-objs variable.

An alternative to the patch below would be to use += in the alsa-kernel
Makefile.


Index: alsa-driver/acore/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/Makefile,v
retrieving revision 1.15
diff -u -r1.15 Makefile
--- alsa-driver/acore/Makefile	8 Apr 2003 15:38:19 -0000	1.15
+++ alsa-driver/acore/Makefile	14 Apr 2003 06:25:27 -0000
@@ -3,10 +3,6 @@
 include $(TOPDIR)/toplevel.config
 include $(TOPDIR)/Makefile.conf

-ifeq ($(CONFIG_PCI),y)
-snd-page-alloc-objs += memory_wrapper.o
-endif
-
 obj-$(CONFIG_SND_SERIALMIDI) += snd-rawmidi.o snd.o
 obj-$(CONFIG_SND_SSCAPE) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_MSND_PINNACLE) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
@@ -20,5 +16,9 @@

 TOPDIR = $(MAINSRCDIR)
 include $(TOPDIR)/alsa-kernel/core/Makefile
+
+ifeq ($(CONFIG_PCI),y)
+snd-page-alloc-objs += memory_wrapper.o
+endif

 include $(TOPDIR)/Rules.make




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
