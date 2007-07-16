From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: [PATCH 1/2] Add SPI devices to ALSA Kconfig and
	Makefile
Date: Mon, 16 Jul 2007 16:14:58 +0200
Message-ID: <11845952993023-git-send-email-hcegtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 991581037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 16:13:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kernel@avr32linux.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds SPI devices in the ALSA diretory, including the Kconfig and
Makefile.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
---
 sound/Kconfig      |    6 +++++-
 sound/Makefile     |    3 ++-
 sound/spi/Kconfig  |    6 ++++++
 sound/spi/Makefile |    2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 sound/spi/Kconfig
 create mode 100644 sound/spi/Makefile

diff --git a/sound/Kconfig b/sound/Kconfig
index 9ea4738..9217739 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -63,9 +63,13 @@ source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
 
+if SPI
+source "sound/spi/Kconfig"
+endif
+
 source "sound/mips/Kconfig"
 
-# the following will depend on the order of config.
+# tee following will depend on the order of config.
 # here assuming USB is defined before ALSA
 source "sound/usb/Kconfig"
 
diff --git a/sound/Makefile b/sound/Makefile
index b7c7fb7..581ea5e 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -5,7 +5,8 @@ obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ soc/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ \
+		      sparc/ spi/ parisc/ pcmcia/ mips/ soc/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
diff --git a/sound/spi/Kconfig b/sound/spi/Kconfig
new file mode 100644
index 0000000..60fbb2a
--- /dev/null
+++ b/sound/spi/Kconfig
@@ -0,0 +1,6 @@
+#SPI drivers
+
+menu "SPI devices"
+	depends on SND != n
+
+endmenu
diff --git a/sound/spi/Makefile b/sound/spi/Makefile
new file mode 100644
index 0000000..30d8ec9
--- /dev/null
+++ b/sound/spi/Makefile
@@ -0,0 +1,2 @@
+# Makefile for SPI drivers
+
-- 
1.5.2.3
