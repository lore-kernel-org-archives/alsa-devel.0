From: Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH 2/2] ASoC: ads117x: Add device tree compatible string
Date: Mon, 18 Jan 2016 17:04:52 +0100
Message-ID: <1453133092-29521-3-git-send-email-florian.vaussard@heig-vd.ch>
References: <1453133092-29521-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453133092-29521-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Timur Tabi <timur@freescale.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>
List-Id: alsa-devel@alsa-project.org

This patch adds the necessary device tree compatible string to allow
DT probing.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 sound/soc/codecs/ads117x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 1222282..b3f6618 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -20,6 +20,8 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <linux/of.h>
+
 #define ADS117X_RATES (SNDRV_PCM_RATE_8000_48000)
 #define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
 
@@ -75,9 +77,18 @@ static int ads117x_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id ads117x_dt_ids[] = {
+	{ .compatible = "ti,ads117x" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads117x_dt_ids);
+#endif
+
 static struct platform_driver ads117x_codec_driver = {
 	.driver = {
 			.name = "ads117x-codec",
+			.of_match_table = of_match_ptr(ads117x_dt_ids),
 	},
 
 	.probe = ads117x_probe,
-- 
2.1.0
