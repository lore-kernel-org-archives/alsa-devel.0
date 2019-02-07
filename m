From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/6] ASoC: codecs: jz4740: Add support for devicetree
Date: Thu,  7 Feb 2019 10:31:41 -0300
Message-ID: <20190207133143.5232-4-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Add support for probing the driver from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 sound/soc/codecs/jz4740.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9b3e1227a971..974e17fa1911 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -346,10 +346,19 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_codec_of_matches[] = {
+	{ .compatible = "ingenic,jz4740-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jz4740_codec_of_matches);
+#endif
+
 static struct platform_driver jz4740_codec_driver = {
 	.probe = jz4740_codec_probe,
 	.driver = {
 		.name = "jz4740-codec",
+		.of_match_table = of_match_ptr(jz4740_codec_of_matches),
 	},
 };
 
-- 
2.11.0
