From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: PATCH 3/3] ASoC Samsung S3C24xx build
Date: Fri, 02 Feb 2007 18:03:25 +0000
Message-ID: <1170439405.18082.201.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ECKVDv6VetC6Ve8PNlJ2"
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


--=-ECKVDv6VetC6Ve8PNlJ2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch builds the Samsung S3C24xx audio DMA and I2S drivers.


Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-ECKVDv6VetC6Ve8PNlJ2
Content-Disposition: attachment; filename=asoc-s3c2-build.patch
Content-Type: text/x-patch; name=asoc-s3c2-build.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 0f9c7c3b7657 soc/Makefile
--- a/soc/Makefile	Fri Feb 02 17:23:42 2007 +0100
+++ b/soc/Makefile	Fri Feb 02 17:39:19 2007 +0000
@@ -1,4 +1,4 @@ snd-soc-core-objs := soc-core.o soc-dapm
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/
diff -r 0f9c7c3b7657 soc/Kconfig
--- a/soc/Kconfig	Fri Feb 02 17:23:42 2007 +0100
+++ b/soc/Kconfig	Fri Feb 02 17:39:05 2007 +0000
@@ -24,6 +24,7 @@ depends on SND_SOC
 depends on SND_SOC
 source "sound/soc/at91/Kconfig"
 source "sound/soc/pxa/Kconfig"
+source "sound/soc/s3c24xx/Kconfig"
 endmenu
 
 # Supported codecs
diff -r 0f9c7c3b7657 soc/s3c24xx/Kconfig
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/Kconfig	Fri Feb 02 17:41:18 2007 +0000
@@ -0,0 +1,16 @@
+menu "SoC Audio for the Samsung S3C24XX"
+
+config SND_S3C24XX_SOC
+	tristate "SoC Audio for the Samsung S3C24XX chips"
+	depends on ARCH_S3C2410 && SND
+	select SND_PCM
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the S3C24XX AC97, I2S or SSP interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_S3C24XX_SOC_I2S
+	tristate
+
+endmenu
+
diff -r 0f9c7c3b7657 soc/s3c24xx/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/Makefile	Fri Feb 02 17:41:34 2007 +0000
@@ -0,0 +1,6 @@
+# S3c24XX Platform Support
+snd-soc-s3c24xx-objs := s3c24xx-pcm.o
+snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
+
+obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
+obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o

--=-ECKVDv6VetC6Ve8PNlJ2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-ECKVDv6VetC6Ve8PNlJ2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-ECKVDv6VetC6Ve8PNlJ2--
