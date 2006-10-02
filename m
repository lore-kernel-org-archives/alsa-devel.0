From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC codecs: build files
Date: Mon, 02 Oct 2006 17:16:18 +0100
Message-ID: <1159805778.2382.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VnNJTzeaOIrv7sUIv1zs"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-VnNJTzeaOIrv7sUIv1zs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds an ASoC Makefile and Kconfig for the WM8731, WM8750 and
WM9712 codecs.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-VnNJTzeaOIrv7sUIv1zs
Content-Disposition: attachment; filename=asoc-codec-build.patch
Content-Type: text/x-patch; name=asoc-codec-build.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/codecs/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/codecs/Kconfig
@@ -0,0 +1,25 @@
+config SND_SOC_AC97_CODEC
+	tristate "SoC generic AC97 support"
+	depends SND_SOC
+	help
+	  Say Y or M if you want generic AC97 support. This is not required
+	  for the AC97 codecs listed below.
+
+config SND_SOC_WM8731
+	tristate "SoC driver for the WM8731 codec"
+	depends SND_SOC
+	help
+	  Say Y or M if you want to support the WM8731 codec.
+
+config SND_SOC_WM8750
+	tristate "SoC driver for the WM8750 codec"
+	depends SND_SOC
+	help
+	  Say Y or M if you want to support the WM8750 codec.
+
+
+config SND_SOC_WM9712
+	tristate "SoC driver for the WM9712 codec"
+	depends SND_SOC
+	help
+	  Say Y or M if you want to support the WM9712 codec.
Index: alsa-kernel/soc/codecs/Makefile
===================================================================
--- /dev/null
+++ alsa-kernel/soc/codecs/Makefile
@@ -0,0 +1,9 @@
+snd-soc-ac97-objs := ac97.o
+snd-soc-wm8731-objs := wm8731.o
+snd-soc-wm8750-objs := wm8750.o
+snd-soc-wm9712-objs := wm9712.o
+
+obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
+obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
+obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
+obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
Index: alsa-kernel/soc/Makefile
===================================================================
--- alsa-kernel.orig/soc/Makefile
+++ alsa-kernel/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-
+obj-$(CONFIG_SND_SOC)	+= codecs/
Index: alsa-kernel/soc/Kconfig
===================================================================
--- alsa-kernel.orig/soc/Kconfig
+++ alsa-kernel/soc/Kconfig
@@ -5,6 +5,9 @@
 menu "SoC audio support"
 	depends on SND!=n
 
+config SND_SOC_AC97_BUS
+	bool
+
 config SND_SOC
 	tristate "SoC audio support"
 	---help---
@@ -16,4 +19,10 @@ config SND_SOC
 	  This SoC audio support can also be built as a module.  If so, the module
 	  will be called snd-soc-core.
 
+# Supported codecs
+menu "SoC Codecs"
+depends on SND_SOC
+source "sound/soc/codecs/Kconfig"
+endmenu
+
 endmenu

--=-VnNJTzeaOIrv7sUIv1zs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-VnNJTzeaOIrv7sUIv1zs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-VnNJTzeaOIrv7sUIv1zs--
