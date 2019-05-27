From: Maxime Jourdan <mjourdan@baylibre.com>
Subject: [PATCH] ASoC: max98357a: Show KConfig entry
Date: Mon, 27 May 2019 18:38:09 +0200
Message-ID: <20190527163809.28104-1-mjourdan@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The SEI510 board features a standalone MAX98357A codec.
Add a tristate prompt to allow selecting the codec.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e730d47ac85b..48c94065072a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -708,7 +708,8 @@ config SND_SOC_MAX98095
        tristate
 
 config SND_SOC_MAX98357A
-       tristate
+	tristate "Maxim MAX98357A CODEC"
+	depends on GPIOLIB
 
 config SND_SOC_MAX98371
        tristate
-- 
2.21.0
