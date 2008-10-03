From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH 2/7] ASoC: Add new directory: sound/soc/atmel
Date: Fri, 03 Oct 2008 16:58:08 +0200
Message-ID: <48E63300.4060301@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070002070303090508070008"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A8602414D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:58:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070002070303090508070008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add new directory: sound/soc/atmel which is a merge between sound/soc/at91 and sound/soc/at32.
Add Makefile and Kconfig for this directory.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/atmel/Kconfig  |   43 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/atmel/Makefile |   15 +++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
new file mode 100644
index 0000000..170d9da
--- /dev/null
+++ b/sound/soc/atmel/Kconfig
@@ -0,0 +1,43 @@
+config SND_ATMEL_SOC
+	tristate "SoC Audio for the Atmel System-on-Chip"
+	depends on ARCH_AT91 || AVR32
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the ATMEL SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ATMEL_SOC_SSC
+	tristate
+	depends on SND_ATMEL_SOC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface. You will also needs to select the individual
+	  machine drivers to support below.
+
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        select SND_ATMEL_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
+
+config SND_AT32_SOC_PLAYPAQ_SLAVE
+        bool "Run CODEC on PlayPaq in slave mode"
+        depends on SND_AT32_SOC_PLAYPAQ
+        default n
+        help
+          Say Y if you want to run with the AT32 SSC generating the BCLK
+          and FRAME signals on the PlayPaq.  Unless you want to play
+          with the AT32 as the SSC master, you probably want to say N here,
+          as this will give you better sound quality.
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
new file mode 100644
index 0000000..f54a7cc
--- /dev/null
+++ b/sound/soc/atmel/Makefile
@@ -0,0 +1,15 @@
+# AT91 Platform Support
+snd-soc-atmel-pcm-objs := atmel-pcm.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
+obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
+# AT91 Machine Support
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
-- 
1.5.3.7




--------------070002070303090508070008
Content-Type: text/plain;
 name="Add-new-directry-sound-soc-atmel.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Add-new-directry-sound-soc-atmel.txt"

>From 2443ad5a23c54948ed86f774538b65ad69ff37ee Mon Sep 17 00:00:00 2001
From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Date: Fri, 3 Oct 2008 11:25:36 +0200
Subject: [PATCH] Add new directry: sound/soc/atmel which is a merge between sound/soc/at91 and
 sound/soc/at32.
 Add Makefile and Kconfig for this directory.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/atmel/Kconfig  |   43 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/atmel/Makefile |   15 +++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
new file mode 100644
index 0000000..170d9da
--- /dev/null
+++ b/sound/soc/atmel/Kconfig
@@ -0,0 +1,43 @@
+config SND_ATMEL_SOC
+	tristate "SoC Audio for the Atmel System-on-Chip"
+	depends on ARCH_AT91 || AVR32
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the ATMEL SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ATMEL_SOC_SSC
+	tristate
+	depends on SND_ATMEL_SOC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface. You will also needs to select the individual
+	  machine drivers to support below.
+
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        select SND_ATMEL_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
+
+config SND_AT32_SOC_PLAYPAQ_SLAVE
+        bool "Run CODEC on PlayPaq in slave mode"
+        depends on SND_AT32_SOC_PLAYPAQ
+        default n
+        help
+          Say Y if you want to run with the AT32 SSC generating the BCLK
+          and FRAME signals on the PlayPaq.  Unless you want to play
+          with the AT32 as the SSC master, you probably want to say N here,
+          as this will give you better sound quality.
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
new file mode 100644
index 0000000..f54a7cc
--- /dev/null
+++ b/sound/soc/atmel/Makefile
@@ -0,0 +1,15 @@
+# AT91 Platform Support
+snd-soc-atmel-pcm-objs := atmel-pcm.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
+obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
+# AT91 Machine Support
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
-- 
1.5.3.7





--------------070002070303090508070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070002070303090508070008--
