From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Amstrad Delta: add info about the line
	discipline requirement to Kconfig help text
Date: Sat, 24 Oct 2009 00:06:48 +0200
Message-ID: <200910240006.50229.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 715B4243BC
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 00:08:11 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: e3-hacking@earth.li, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I thought it could be usefull to add some information on how to get the device
fully supported by loading a line discipline on the modem line.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
As you could probably notice, I am not a native English, so please feel free
to correct my poor language if desired.

--- linux-2.6.32-rc5/sound/soc/omap/Kconfig.orig	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/sound/soc/omap/Kconfig	2009-10-24 00:01:26.000000000 +0200
@@ -21,7 +21,18 @@ config SND_OMAP_SOC_AMS_DELTA
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_CX20442
 	help
-	  Say Y if you want to add support for SoC audio on Amstrad Delta.
+	  Say Y  if you want to add support  for SoC audio device  connected to
+	  a handset and a speakerphone found on Amstrad E3 (Delta) videophone.
+	  
+	  Note that in order to get those devices fully supported,  you have to
+	  build  the kernel  with  standard  serial port  driver  included  and
+	  configured for at least 4 ports.  Then, from userspace, you must load
+	  a line discipline #19 on the modem (ttyS3) serial line.  The simplest
+	  way to achieve this is to install util-linux-ng  and use the included
+	  ldattach  utility.  This  can be  started  automatically  from  udev,
+	  a simple rule like this one should do the trick (it does for me):
+	  	ACTION=="add", KERNEL=="controlC0", \
+				RUN+="/usr/sbin/ldattach 19 /dev/ttyS3"
 
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
