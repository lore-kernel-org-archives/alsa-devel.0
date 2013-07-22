From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Build adau1701 when
	SND_SOC_ALL_CODECS is selected
Date: Mon, 22 Jul 2013 18:49:52 +0200
Message-ID: <1374511793-32187-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-057.synserver.de (smtp-out-057.synserver.de
 [212.40.185.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 392B0261A79
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 18:49:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The adau1701 driver was removed from SND_SOC_ALL_CODECS in commit commit ee8c7e9
("ASoC: Remove adau1701 from SND_SOC_ALL_CODECS due to Sigma dependency") due
to the dependency on the SigmaDSP firmware loader which was only available on a
limited set of platforms. This was fixed quite some time ago in commit 40216ce7
("ASoC: Move SigmaDSP firmware loader to ASoC") though, so we can add the driver
back again to SND_SOC_ALL_CODECS.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 63efc4e..d038a58 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -21,6 +21,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
 	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
+	select SND_SOC_ADAU1701 if I2C
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
-- 
1.8.0
