From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ASoC: rt5514: work around link error
Date: Fri, 10 Nov 2017 15:54:43 +0100
Message-ID: <20171110145455.821805-2-arnd@arndb.de>
References: <20171110145455.821805-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D7A26705E
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 15:56:08 +0100 (CET)
In-Reply-To: <20171110145455.821805-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The main rt5514 driver optionally calls into the SPI back-end to load
the firmware. This causes a link error when one driver selects rt5514
as built-in and another driver selects rt5514-spi as a loadable module:

sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
rt5514.c:(.text+0xac8): undefined reference to `rt5514_spi_burst_write'

As a workaround, this adds another silent symbol, to force rt5514-spi
to be built-in for that configuration. I'm not overly happy with
that solution, but couldn't come up with anything better. Using
'IS_REACHABLE()' would break the case that relies on the loadable
module, and all other ideas would result in more complexity.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig  | 4 ++++
 sound/soc/codecs/Makefile | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0838ae710941..a42ddbc93f3d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -749,6 +749,10 @@ config SND_SOC_RT5514
 config SND_SOC_RT5514_SPI
 	tristate
 
+config SND_SOC_RT5514_SPI_BUILTIN
+	bool # force RT5514_SPI to be built-in to avoid link errors
+	default SND_SOC_RT5514=y && SND_SOC_RT5514_SPI=m
+
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 05018b7ca72b..0001069ce2a7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -360,6 +360,7 @@ obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
 obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
+obj-$(CONFIG_SND_SOC_RT5514_SPI_BUILTIN)	+= snd-soc-rt5514-spi.o
 obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
-- 
2.9.0
