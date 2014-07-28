From: Kiran Padwal <kiran.padwal21@gmail.com>
Subject: [PATCH] ASoC: ak4642: Make of_device_id array const
Date: Mon, 28 Jul 2014 11:41:04 +0530
Message-ID: <1406527864-22092-1-git-send-email-kiran.padwal21@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, s.hauer@pengutronix.de, fabio.estevam@freescale.com, kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, kiran.padwal21@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Make of_device_id array const, because all OF functions handle it as const

Signed-off-by: Kiran Padwal <kiran.padwal21@gmail.com>
---
 sound/soc/codecs/ak4642.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 3ba4c0f..0417125 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -547,7 +547,7 @@ static const struct ak4642_drvdata ak4648_drvdata = {
 	.extended_frequencies = 1,
 };
 
-static struct of_device_id ak4642_of_match[];
+static const struct of_device_id ak4642_of_match[];
 static int ak4642_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -593,7 +593,7 @@ static int ak4642_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct of_device_id ak4642_of_match[] = {
+static const struct of_device_id ak4642_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_drvdata},
 	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4643_drvdata},
 	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_drvdata},
-- 
1.7.9.5
