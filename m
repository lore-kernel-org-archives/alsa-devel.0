From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 1/7] ASoC: tlv320aic26: Allow tlv320aic26 to be selected in menuconfig
Date: Thu, 21 Mar 2019 18:15:43 -0400
Message-ID: <20190321221549.13765-2-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Without a description you can't select the device in menuconfig
Set depends to SPI_MASTER to match conditional in SND_SOC_ALL_CODECS

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114edfd57..cd697a015819 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1087,8 +1087,8 @@ config SND_SOC_TLV320AIC23_SPI
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-	tristate
-	depends on SPI
+	tristate "Texas Instruments TLV320AIC26 audio CODEC - SPI"
+	depends on SPI_MASTER
 
 config SND_SOC_TLV320AIC31XX
 	tristate "Texas Instruments TLV320AIC31xx CODECs"
-- 
2.21.0
