From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: da7210: Fix dependency to allow build
 with SND_SOC_I2C_AND_SPI
Date: Mon, 04 May 2015 17:28:02 +0800
Message-ID: <1430731682.32362.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 0569F2604B1
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 11:28:11 +0200 (CEST)
Received: by pdbqd1 with SMTP id qd1so158328532pdb.2
 for <alsa-devel@alsa-project.org>; Mon, 04 May 2015 02:28:08 -0700 (PDT)
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Dajun Chen <dchen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org

Since commit aa0e25caafb7 ("ASoC: da7210: Add support for spi regmap"),
the da7210 codec driver supports both I2C and SPI buses.
Thus update the dependency accordingly.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..ac84ac4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -54,7 +54,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4271_SPI if SPI_MASTER
 	select SND_SOC_CS42XX8_I2C if I2C
 	select SND_SOC_CX20442 if TTY
-	select SND_SOC_DA7210 if I2C
+	select SND_SOC_DA7210 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_DA7213 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
-- 
2.1.0
