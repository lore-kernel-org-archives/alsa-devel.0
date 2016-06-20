From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: dwc: make pcm support built-in when
	necessary
Date: Mon, 20 Jun 2016 18:01:19 +0200
Message-ID: <20160620160131.2565092-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 554E32665AC
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 17:59:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The new PIO mode for the dwc audio driver causes a link failure
when it is built as a loadable module but the audio driver is built-in:

sound/built-in.o: In function `i2s_irq_handler':
:(.text+0x58c64): undefined reference to `dw_pcm_push_tx'
sound/built-in.o: In function `dw_i2s_probe':
:(.text+0x593dc): undefined reference to `dw_pcm_register'

We could link both into a single module, but apparently the
author intended them to be separate, so this instead changes
the Makefile to force the pcm module to be built-in if the
base module is. This is a bit hacky but not as bad as trying
to work around it in Kconfig language.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 79361b2b98b7 ("ASoC: dwc: Add PIO PCM extension")
---
 sound/soc/dwc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 1b48bcccbc51..38f1ca31c5fa 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,4 +1,5 @@
 # SYNOPSYS Platform Support
 obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
-obj-$(CONFIG_SND_DESIGNWARE_PCM) += designware_pcm.o
-
+ifdef CONFIG_SND_DESIGNWARE_PCM
+obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_pcm.o
+endif
-- 
2.9.0
