From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: Enable SND_SIMPLE_CARD for Odroid X2/U3
Date: Wed, 18 Mar 2015 11:52:19 +0100
Message-ID: <1426675939-25125-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: liquid.acid@gmx.net, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

Odroid X2/U3 sound support can now be specified in device tree using
the simple card binding, make SND_SOC_ODROIDX2 select SND_SIMPLE_CARD
to ensure there are always required drivers in place.

Reported-by: Tobias Jakobi <liquid.acid@gmx.net>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 0632a36..25caadf 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -226,6 +226,7 @@ config SND_SOC_ODROIDX2
 	depends on SND_SOC_SAMSUNG && I2C
 	select SND_SOC_MAX98090
 	select SND_SAMSUNG_I2S
+	select SND_SIMPLE_CARD
 	help
 	  Say Y here to enable audio support for the Odroid-X2/U3.
 
-- 
1.7.9.5
