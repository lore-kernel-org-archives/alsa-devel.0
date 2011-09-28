From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/6] ASoC: Remove unused "control_data" field of struct
 ak4671_priv
Date: Wed, 28 Sep 2011 10:00:18 +0800
Message-ID: <1317175218.14102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4671.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 88b29f8..2ecf128 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -26,7 +26,6 @@
 /* codec private data */
 struct ak4671_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 };
 
 /* ak4671 register cache & default register settings */
@@ -675,7 +674,6 @@ static int __devinit ak4671_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, ak4671);
-	ak4671->control_data = client;
 	ak4671->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&client->dev,
-- 
1.7.4.1
