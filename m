From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl4030: fix child-node lookup" to the asoc tree
Date: Thu, 16 Nov 2017 19:33:04 +0000 (GMT)
Message-ID: <20171116193304.D767544005B@finisterre.ee.mobilebroadband>
References: <20171113111256.24140-2-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171113111256.24140-2-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, stable <stable@vger.kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl4030: fix child-node lookup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 15f8c5f2415bfac73f33a14bcd83422bcbfb5298 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 13 Nov 2017 12:12:56 +0100
Subject: [PATCH] ASoC: twl4030: fix child-node lookup

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent codec node was also prematurely freed,
while the child node was leaked.

Fixes: 2d6d649a2e0f ("ASoC: twl4030: Support for DT booted kernel")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org>
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
2.14.1
