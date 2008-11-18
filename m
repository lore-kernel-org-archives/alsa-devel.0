From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/17] ASoC: Blackfin: do not force TWI bus for
	ssm2602 codec
Date: Tue, 18 Nov 2008 12:38:20 +0000
Message-ID: <1227011903-2825-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B513B103820
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:28 +0100 (CET)
In-Reply-To: <1227011903-2825-13-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

Cc: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 43d89fc..f0fd235 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -13,7 +13,6 @@ config SND_BF5XX_SOC_SSM2602
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_SSM2602
 	select I2C
-	select I2C_BLACKFIN_TWI
 	help
 	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
 
-- 
1.5.6.5
