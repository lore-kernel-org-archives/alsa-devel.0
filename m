From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 6/6] arm: prima2: defconfig: enable sound
	components
Date: Fri, 19 Jul 2013 19:07:22 +0800
Message-ID: <1374232042-26088-7-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F552656AF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 13:09:58 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so4301540pbc.32
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 04:09:58 -0700 (PDT)
In-Reply-To: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 002a1ce..07a87c8 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_RELAY=y
@@ -39,6 +38,11 @@ CONFIG_SPI=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SIRF_SOC=y
+CONFIG_SND_SIRF_INNER=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
@@ -59,12 +63,12 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_INFO=y
 CONFIG_CRC_CCITT=y
-- 
1.8.2.3
