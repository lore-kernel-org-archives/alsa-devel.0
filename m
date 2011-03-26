From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: ad73311: drop I2C requirement
Date: Sat, 26 Mar 2011 04:38:30 -0400
Message-ID: <1301128710-3244-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 631FC103811
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 09:38:02 +0100 (CET)
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
Cc: Scott Jiang <scott.jiang@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

From: Scott Jiang <scott.jiang@analog.com>

The AD73311 codec does not use I2C, so don't require it in Kconfig.

Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d6976ed..74a4629 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD183X if SPI_MASTER
 	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
-	select SND_SOC_AD73311 if I2C
+	select SND_SOC_AD73311
 	select SND_SOC_AD74111
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
-- 
1.7.4.1
