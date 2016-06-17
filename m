From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: core: Remove selects of regmap buses
Date: Fri, 17 Jun 2016 14:04:29 +0100
Message-ID: <1466168669-13140-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DADC265CC8
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 15:04:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

We used to have code wrapping the regmap I2C and SPI buses as part of
the conversion of ASoC drivers from using the ASoC level I/O to the
regmap level I/O.  Since all drivers have now been converted and the
core code removed we can remove the per-bus selects and instead just
select the regmap core.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 182d92efc7c8..4935e23ff3d6 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -7,8 +7,7 @@ menuconfig SND_SOC
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
 	select SND_JACK
-	select REGMAP_I2C if I2C
-	select REGMAP_SPI if SPI_MASTER
+	select REGMAP
 	---help---
 
 	  If you want ASoC support, you should say Y here and also to the
-- 
2.8.1
