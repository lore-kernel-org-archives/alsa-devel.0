From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 1/3] Add AVR32 ALSA drivers directory.
Date: Wed,  4 Feb 2009 12:48:32 +0100
Message-ID: <1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CF5F24341
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 12:48:37 +0100 (CET)
In-Reply-To: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 sound/Kconfig  |    2 ++
 sound/Makefile |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 200aca1..0a5fbb3 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -60,6 +60,8 @@ source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
 
+source "sound/avr32/Kconfig"
+
 source "sound/spi/Kconfig"
 
 source "sound/mips/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index c76d707..a52b236 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
-	sparc/ spi/ parisc/ pcmcia/ mips/ soc/
+	sparc/ spi/ parisc/ pcmcia/ mips/ soc/ avr32/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
-- 
1.5.6.3
