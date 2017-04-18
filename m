From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ASoC: dwc: disallow building designware_pcm as
	a module
Date: Tue, 18 Apr 2017 12:59:54 +0200
Message-ID: <20170418105954.23368-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shell.v3.sk (shell.v3.sk [92.60.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id C40792666FE
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 13:00:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

It makes not sense: the whether the PIO PCM extension is used is
hardcoded to the designware_i2s driver and designware_pcm doesn't
have any module metadata, causing a kernel taint:

  [   44.287000] designware_pcm: module license 'unspecified' taints kernel.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sound/soc/dwc/Kconfig                                     | 4 ++--
 sound/soc/dwc/Makefile                                    | 6 +++++-
 sound/soc/dwc/{designware_i2s.c => designware_i2s_main.c} | 2 +-
 sound/soc/dwc/{designware_pcm.c => designware_i2s_pcm.c}  | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)
 rename sound/soc/dwc/{designware_i2s.c => designware_i2s_main.c} (99%)
 rename sound/soc/dwc/{designware_pcm.c => designware_i2s_pcm.c} (99%)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index c297efe..704b7b2 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -8,10 +8,10 @@ config SND_DESIGNWARE_I2S
 	 maximum of 8 channels each for play and record.
 
 config SND_DESIGNWARE_PCM
-	tristate "PCM PIO extension for I2S driver"
+	bool "PCM PIO extension for I2S driver"
 	depends on SND_DESIGNWARE_I2S
 	help
-	 Say Y, M or N if you want to add a custom ALSA extension that registers
+	 Say Y if you want to add a custom ALSA extension that registers
 	 a PCM and uses PIO to transfer data.
 
 	 This functionality is specially suited for I2S devices that don't have
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 38f1ca3..05c594f 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,5 +1,9 @@
 # SYNOPSYS Platform Support
+
 obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
+
+designware_i2s-objs := designware_i2s_main.o
+
 ifdef CONFIG_SND_DESIGNWARE_PCM
-obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_pcm.o
+designware_i2s-objs += designware_i2s_pcm.o
 endif
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s_main.c
similarity index 99%
rename from sound/soc/dwc/designware_i2s.c
rename to sound/soc/dwc/designware_i2s_main.c
index bdf8398..23c2212 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s_main.c
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC Synopsys I2S Audio Layer
  *
- * sound/soc/dwc/designware_i2s.c
+ * sound/soc/dwc/designware_i2s_main.c
  *
  * Copyright (C) 2010 ST Microelectronics
  * Rajeev Kumar <rajeevkumar.linux@gmail.com>
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_i2s_pcm.c
similarity index 99%
rename from sound/soc/dwc/designware_pcm.c
rename to sound/soc/dwc/designware_i2s_pcm.c
index 4a83a22..27664e2 100644
--- a/sound/soc/dwc/designware_pcm.c
+++ b/sound/soc/dwc/designware_i2s_pcm.c
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC Synopsys PIO PCM for I2S driver
  *
- * sound/soc/dwc/designware_pcm.c
+ * sound/soc/dwc/designware_i2s_pcm.c
  *
  * Copyright (C) 2016 Synopsys
  * Jose Abreu <joabreu@synopsys.com>
-- 
2.9.3
