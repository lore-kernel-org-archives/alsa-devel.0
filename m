From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] sound/oss: remove VIRT_TO_BUS dependency
Date: Wed, 09 Dec 2015 14:37:05 +0100
Message-ID: <1607667.Zg3De8gXcs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id DEAAC260591
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 14:37:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The OSS sound drivers used to rely on virt_to_bus(), but don't any more,
so we can remove the Kconfig dependency.

As a lot of architectures don't provide VIRT_TO_BUS any more, removing
the dependency in sounds/oss/ would make the deprecated drivers appear
there, which we probably don't want. Instead I'm replacing the
simple dependency with 'VIRT_TO_BUS || RPC || NETWINDER' so we can
still build these sound drivers for the platforms that need them,
but don't change anything on other architectures.

As a follow-up, we can remove the virt_to_bus() implementation
and Kconfig symbol in the ARM architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 48568fdf847f..4033fe58f0cf 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -240,7 +240,7 @@ config MSND_FIFOSIZE
 
 menuconfig SOUND_OSS
 	tristate "OSS sound modules"
-	depends on ISA_DMA_API && VIRT_TO_BUS
+	depends on ISA_DMA_API && (VIRT_TO_BUS || ARCH_RPC || ARCH_NETWINDER)
 	depends on !GENERIC_ISA_DMA_SUPPORT_BROKEN
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
