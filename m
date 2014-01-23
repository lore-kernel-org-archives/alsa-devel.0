From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak4554: Add to SND_SOC_ALL_CODECS
Date: Thu, 23 Jan 2014 12:58:42 +0000
Message-ID: <1390481922-4266-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD31C2625D4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 13:58:54 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

For build coverage.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5f74fc3f672c..fa989cb77fe4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -25,6 +25,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
+	select SND_SOC_AK4554
 	select SND_SOC_AK4641 if I2C
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
-- 
1.8.5.3
