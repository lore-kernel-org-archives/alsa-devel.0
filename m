From: Kiran Padwal <kiran.padwal21@gmail.com>
Subject: [PATCH] ASoC: ak4642: Make of_device_id array const
Date: Thu, 24 Jul 2014 17:28:36 +0530
Message-ID: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, s.hauer@pengutronix.de, fabio.estevam@freescale.com, kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, kiran.padwal21@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Make of_device_id array const, because all OF functions handle it as const

Signed-off-by: Kiran Padwal <kiran.padwal21@gmail.com>
---
 sound/soc/codecs/ak4642.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 3ba4c0f..4b2ae61 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
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
