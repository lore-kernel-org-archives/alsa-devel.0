From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH5/5] ASoC S3C24xx machine drivers - Kconfig
Date: Thu, 10 May 2007 14:00:52 +0100
Message-ID: <1178802052.10518.73.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kqCZArFDxAEnaZsFzAqe"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id 64FDC2438C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:01:05 +0200 (CEST)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T7f82b3bae8ac140805bcc@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Thu, 10 May 2007 14:01:03 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--=-kqCZArFDxAEnaZsFzAqe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Graeme Gregory <gg@opensource.wolfsonmicro.com>

This patch adds Kconfig and build support for the Neo1973, SMDK2443 and
S3C2443 AC97 ALSA audio drivers.

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-kqCZArFDxAEnaZsFzAqe
Content-Disposition: attachment; filename="kconfig.patch"
Content-Type: text/x-patch; name="kconfig.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/soc/s3c24xx/Kconfig	Mon May 07 09:29:32 2007 +0200
+++ b/soc/s3c24xx/Kconfig	Wed May 09 11:12:48 2007 +0100
@@ -1,6 +1,7 @@ config SND_S3C24XX_SOC
 config SND_S3C24XX_SOC
 	tristate "SoC Audio for the Samsung S3C24XX chips"
 	depends on ARCH_S3C2410 && SND_SOC
+	select SND_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the S3C24XX AC97, I2S or SSP interface. You will also need
@@ -8,3 +9,29 @@ config SND_S3C24XX_SOC
 
 config SND_S3C24XX_SOC_I2S
 	tristate
+
+config SND_S3C2443_SOC_AC97
+	tristate
+	select AC97_BUS
+	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
+	
+config SND_S3C24XX_SOC_NEO1973_WM8753
+	tristate "SoC I2S Audio support for NEO1973 - WM8753"
+	depends on SND_S3C24XX_SOC && MACH_GTA01
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_WM8753
+	help
+	  Say Y if you want to add support for SoC audio on smdk2440
+	  with the WM8753.
+
+config SND_S3C24XX_SOC_SMDK2443_WM9710
+	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
+	depends on SND_S3C24XX_SOC && MACH_SMDK2443
+	select SND_S3C2443_SOC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  Say Y if you want to add support for SoC audio on smdk2443
+	  with the WM9710.
+
+
--- a/soc/s3c24xx/Makefile	Mon May 07 09:29:32 2007 +0200
+++ b/soc/s3c24xx/Makefile	Tue May 08 10:16:09 2007 +0100
@@ -1,6 +1,15 @@
 # S3c24XX Platform Support
 snd-soc-s3c24xx-objs := s3c24xx-pcm.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
+snd-soc-s3c2443-ac97-objs := s3c2443-ac97.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
+obj-$(CONFIG_SND_S3C2443_SOC_AC97) += snd-soc-s3c2443-ac97.o
+
+# S3C24XX Machine Support
+snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
+snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
+
+obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o

--=-kqCZArFDxAEnaZsFzAqe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-kqCZArFDxAEnaZsFzAqe--
