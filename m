From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: wm8770: Depend on SPI only
Date: Fri,  7 Feb 2014 15:59:30 +0000
Message-ID: <1391788770-31780-2-git-send-email-broonie@kernel.org>
References: <1391788770-31780-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D278265329
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 16:59:45 +0100 (CET)
In-Reply-To: <1391788770-31780-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The device has no I2C support so it shouldn't be buildable if only I2C is
enabled.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6b67e86f3f2c..6c87cce8b3cf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -478,7 +478,7 @@ config SND_SOC_WM8753
 
 config SND_SOC_WM8770
 	tristate "Wolfson Microelectronics WM8770 CODEC"
-	depends on SND_SOC_I2C_AND_SPI
+	depends on SPI
 
 config SND_SOC_WM8776
 	tristate "Wolfson Microelectronics WM8776 CODEC"
-- 
1.9.rc1
