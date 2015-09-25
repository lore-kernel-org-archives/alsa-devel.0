From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH  V1 3/6] ASoC: tlv320aic26: Make SND_SOC_TLV320AIC26 user-visible
Date: Fri, 25 Sep 2015 14:30:06 -0400
Message-ID: <1443205809-27549-4-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

Allow SND_SOC_TLV320AIC26 to be built.

Based on commit: http://mailman.alsa-project.org/pipermail/alsa-devel/2008-October/011287.html

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce8ba38..a70b5a00dc5e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -640,7 +640,7 @@ config SND_SOC_TLV320AIC23_SPI
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-	tristate
+	tristate "Texas Instruments TLV320AIC26 Codec support"
 	depends on SPI
 
 config SND_SOC_TLV320AIC31XX
-- 
1.9.1
