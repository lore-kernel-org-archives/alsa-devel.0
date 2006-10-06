From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC codecs: build files
Date: Fri, 06 Oct 2006 16:52:39 +0100
Message-ID: <1160149959.16898.41.camel@localhost.localdomain>
References: <1159805778.2382.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z876xYflB8D2U//xSE3F"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1159805778.2382.114.camel@localhost.localdomain>
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


--=-z876xYflB8D2U//xSE3F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-10-02 at 17:16 +0100, Liam Girdwood wrote:
> This patch adds an ASoC Makefile and Kconfig for the WM8731, WM8750
> and
> WM9712 codecs. 

Now changed to allow only the selected machines codec to be built.

Liam

--=-z876xYflB8D2U//xSE3F
Content-Disposition: attachment; filename=asoc-codec-build.patch
Content-Type: text/x-patch; name=asoc-codec-build.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/codecs/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/codecs/Kconfig
@@ -0,0 +1,15 @@
+config SND_SOC_AC97_CODEC
+	tristate
+	depends SND_SOC
+
+config SND_SOC_WM8731
+	tristate
+	depends SND_SOC
+
+config SND_SOC_WM8750
+	tristate
+	depends SND_SOC
+
+config SND_SOC_WM9712
+	tristate
+	depends SND_SOC
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
@@ -16,4 +19,7 @@ config SND_SOC
 	  This SoC audio support can also be built as a module.  If so, the module
 	  will be called snd-soc-core.
 
+# Supported codecs
+source "sound/soc/codecs/Kconfig"
+
 endmenu

--=-z876xYflB8D2U//xSE3F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-z876xYflB8D2U//xSE3F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-z876xYflB8D2U//xSE3F--
