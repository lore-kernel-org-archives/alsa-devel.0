From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] ASoC: twl4030: fix child-node lookup
Date: Mon, 13 Nov 2017 12:12:56 +0100
Message-ID: <20171113111256.24140-2-johan@kernel.org>
References: <20171113111256.24140-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171113111256.24140-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent codec node was also prematurely freed,
while the child node was leaked.

Fixes: 2d6d649a2e0f ("ASoC: twl4030: Support for DT booted kernel")
Cc: stable <stable@vger.kernel.org>     # 3.7
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/twl4030.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c482b2e7a7d2..cfe72b9d4356 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -232,7 +232,7 @@ static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 	struct twl4030_codec_data *pdata = dev_get_platdata(codec->dev);
 	struct device_node *twl4030_codec_node = NULL;
 
-	twl4030_codec_node = of_find_node_by_name(codec->dev->parent->of_node,
+	twl4030_codec_node = of_get_child_by_name(codec->dev->parent->of_node,
 						  "codec");
 
 	if (!pdata && twl4030_codec_node) {
@@ -241,9 +241,11 @@ static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 				     GFP_KERNEL);
 		if (!pdata) {
 			dev_err(codec->dev, "Can not allocate memory\n");
+			of_node_put(twl4030_codec_node);
 			return NULL;
 		}
 		twl4030_setup_pdata_of(pdata, twl4030_codec_node);
+		of_node_put(twl4030_codec_node);
 	}
 
 	return pdata;
-- 
2.15.0
