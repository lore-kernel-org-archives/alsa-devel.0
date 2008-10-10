From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Make TLV320AIC26 user-visible
Date: Fri, 10 Oct 2008 15:52:14 +0100
Message-ID: <1223650337-15371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081010145127.GA15329@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDADB24766
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:52:35 +0200 (CEST)
In-Reply-To: <20081010145127.GA15329@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The TLV320AIC26 Kconfig option is unusual in that it supports the
OpenFirmware machine driver which doesn't have a hard binding to the
codec driver but discovers the codec via the device tree.  This makes it
meaningful to select the codec without a machine driver.

Ideally there would be a proxy entry so that this option was only
visible on OpenFirmware systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 11eebce..4975d85 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,7 +68,7 @@ config SND_SOC_TLV320AIC23
 	depends on I2C
 
 config SND_SOC_TLV320AIC26
-	tristate
+	tristate "TI TLV320AIC26 Codec support"
 	depends on SPI
 
 config SND_SOC_TLV320AIC3X
-- 
1.5.6.5
