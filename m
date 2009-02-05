From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH v2 3/3] Add Atmel ALSA drivers directory
Date: Thu,  5 Feb 2009 13:11:01 +0100
Message-ID: <1233835861-5533-4-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1233835861-5533-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233835861-5533-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233835861-5533-3-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 50517103906
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 13:11:03 +0100 (CET)
In-Reply-To: <1233835861-5533-3-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
 sound/Kconfig  |    2 ++
 sound/Makefile |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 200aca1..1eceb85 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -60,6 +60,8 @@ source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
 
+source "sound/atmel/Kconfig"
+
 source "sound/spi/Kconfig"
 
 source "sound/mips/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index c76d707..ec467de 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
-	sparc/ spi/ parisc/ pcmcia/ mips/ soc/
+	sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
-- 
1.5.6.3
