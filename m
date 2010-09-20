From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Select DMA driver for Samsung DAIs
Date: Mon, 20 Sep 2010 20:38:28 +0100
Message-ID: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 430F124548
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 21:38:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Kconfig got smart enough to do dependencies through selects so let's make
use of that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 7d8235d..1142d3e 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -10,6 +10,7 @@ config SND_S3C24XX_SOC
 config SND_S3C24XX_SOC_I2S
 	tristate
 	select S3C2410_DMA
+	select SND_S3C_SOC_PCM
 
 config SND_S3C_I2SV2_SOC
 	tristate
@@ -18,16 +19,19 @@ config SND_S3C2412_SOC_I2S
 	tristate
 	select SND_S3C_I2SV2_SOC
 	select S3C2410_DMA
+	select SND_S3C_SOC_PCM
 
 config SND_S3C64XX_SOC_I2S
 	tristate
 	select SND_S3C_I2SV2_SOC
 	select S3C64XX_DMA
+	select SND_S3C_SOC_PCM
 
 config SND_S3C64XX_SOC_I2S_V4
 	tristate
 	select SND_S3C_I2SV2_SOC
 	select S3C64XX_DMA
+	select SND_S3C_SOC_PCM
 
 config SND_S3C_SOC_PCM
 	tristate
-- 
1.7.1
