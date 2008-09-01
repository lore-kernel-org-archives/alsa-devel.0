From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: Make all codecs depend on rather
	than selecting I2C
Date: Mon,  1 Sep 2008 18:46:57 +0100
Message-ID: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36F6B1037FB
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:47:07 +0200 (CEST)
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

The I2C layer uses I/O operations that aren't available on all
architectures and since select bypasses Kconfig dependency checking
selecting I2C breaks builds like allmodconfig on some architectures.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5d77dc3..13ae4fd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
-	select I2C
+	depends on I2C
 	select SPI
 	select SND_SOC_AK4535
 	select SND_SOC_UDA1380
-- 
1.5.6.5
