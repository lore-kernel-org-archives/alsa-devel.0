From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] let 2.5.51 build
Date: Wed, 11 Dec 2002 10:51:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2k7igc29i.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

this patch enable 2.5.51 kernel to build without sequencer support :

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa-fix-compile.diff

fix compiling without sequencer support
--- ./sound/synth/Makefile.tv	2002-12-10 22:02:00.000000000 -0500
+++ ./sound/synth/Makefile	2002-12-10 21:50:37.000000000 -0500
@@ -12,8 +12,8 @@
 obj-$(CONFIG_SND_TRIDENT) += snd-util-mem.o
 ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
   obj-$(CONFIG_SND_SBAWE) += snd-util-mem.o
+obj-$(CONFIG_SND) += emux/
 endif
 
-obj-$(CONFIG_SND) += emux/
 
 include $(TOPDIR)/Rules.make

--=-=-=--



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
