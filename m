From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] ASoC: jz4740: Depend on MIPS instead of MACH_JZ4740
Date: Tue, 19 Mar 2019 15:00:14 +0100
Message-ID: <20190319140014.26796-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Depending on MACH_JZ4740 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6b6e87..b3f9c41b4319 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,6 +1,6 @@
 config SND_JZ4740_SOC
 	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.11.0
