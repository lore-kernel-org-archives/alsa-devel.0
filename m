From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH 1/7] ASoC: Change Makefile and Kconfig to
 support atmel avr32 and at91 merging into a single atmel directory.
Date: Fri, 03 Oct 2008 16:57:50 +0200
Message-ID: <48E632EE.1090306@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050208010301030109070009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 67D8624133
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:58:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Mark Brown <broonie@sirena.org.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050208010301030109070009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Change Makefile and Kconfig to support atmel avr32 and at91 merging into a single atmel directory.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/Kconfig  |    3 +--
 sound/soc/Makefile |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..615ebf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -23,8 +23,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
-source "sound/soc/at32/Kconfig"
-source "sound/soc/at91/Kconfig"
+source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index d849349..4d475c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
 obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
-- 
1.5.3.7






--------------050208010301030109070009
Content-Type: text/plain;
 name="Change-Makefile-and-Kconfig-to-support-atmel-sound.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Change-Makefile-and-Kconfig-to-support-atmel-sound.txt"

>From ec6e9878520679b27381cad11dd07f10fb9ce426 Mon Sep 17 00:00:00 2001
From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Date: Thu, 2 Oct 2008 19:51:31 +0200
Subject: [PATCH] Change Makefile and Kconfig to support atmel avr32 and at91 merging into a
 single atmel directory.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/Kconfig  |    3 +--
 sound/soc/Makefile |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..615ebf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -23,8 +23,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
-source "sound/soc/at32/Kconfig"
-source "sound/soc/at91/Kconfig"
+source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index d849349..4d475c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
 obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
-- 
1.5.3.7



--------------050208010301030109070009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050208010301030109070009--
