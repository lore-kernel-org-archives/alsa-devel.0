From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: claim the IRQ when the fsl_ssi device is
	probed, not opened
Date: Tue, 16 Aug 2011 18:35:50 -0400
Message-ID: <1313534150-6642-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id BAEAA10383B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 00:35:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

The PowerPC Freescale SSI driver is claiming the IRQ when the IRQ when
the device is opened, which means that the /proc/interrupts entry for
the SSI exists only during playback or capture.  This also meant that
the user won't know that the IRQ number is wrong until he tries to use
the device.  Instead, we should claim the IRQ when the device is probed.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index fcd85d2..a3467bf 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -139,6 +139,7 @@ CONFIG_SND=y
 CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_PPC is not set
 # CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 908c941..9693f6e 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -140,6 +140,7 @@ CONFIG_SND=y
 CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_PPC is not set
 # CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
-- 
1.7.4.4
