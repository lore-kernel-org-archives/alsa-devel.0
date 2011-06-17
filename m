From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: allow SPI for SSM2602 parts
Date: Thu, 16 Jun 2011 22:24:15 -0400
Message-ID: <1308277455-370-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A1818244C9
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 04:23:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

This board has hardware switches for selecting SPI or I2C, so don't
require I2C for this driver.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 4d361bd..871308f 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -10,10 +10,9 @@ config SND_BF5XX_I2S
 
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio support for BF52x ezkit"
-	depends on SND_BF5XX_I2S
+	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_SSM2602
-	select I2C
 	help
 	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
 
-- 
1.7.5.3
