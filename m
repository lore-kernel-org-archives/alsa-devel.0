From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 10/10] ASoC: tlv320aic32x4: Make driver selectable in Kconfig
Date: Tue, 12 Dec 2017 16:43:11 -0600
Message-ID: <20171212224311.24045-10-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a42ddbc93f3d..7780dcf02f99 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -913,12 +913,12 @@ config SND_SOC_TLV320AIC32X4
 	tristate
 
 config SND_SOC_TLV320AIC32X4_I2C
-	tristate
+	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - I2C"
 	depends on I2C
 	select SND_SOC_TLV320AIC32X4
 
 config SND_SOC_TLV320AIC32X4_SPI
-	tristate
+	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - SPI"
 	depends on SPI_MASTER
 	select SND_SOC_TLV320AIC32X4
 
-- 
2.15.0
