From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v4] ASoC: sgtl5000: Fix driver probe after reset
Date: Thu,  9 May 2013 19:55:16 -0300
Message-ID: <1368140116-15289-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B60D260896
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 00:56:08 +0200 (CEST)
Received: by mail-yh0-f43.google.com with SMTP id a41so881199yho.30
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 15:56:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

After a 'reboot' command in Linux or after pressing the system's reset button
the sgtl5000 driver fails to probe:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

sgtl5000 codec does not have a reset line, nor a reset command in software, so
after a system reset the codec does not contain the default register values
from sgtl5000_reg_defaults[] anymore, as these are only valid after a 
power-on-reset cycle.

Fix this issue by explicitly reading all the reset register values from
sgtl5000_reg_defaults[] and writing them back into sgtl5000 to ensure a sane
state.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- Read sgtl5000_reg_defaults and write these values into sgtl5000
Changes since v2:
- Do not use reg_defaults_raw as it is not the correct purpose
- Manually build sgtl5000_reg_default
- Improve commitlog
Changes since v1:
- Remove sgtl5000_reg_defaults array
- Do not use num_reg_defaults_raw
 sound/soc/codecs/sgtl5000.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..be23fce 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1474,6 +1474,31 @@ static const struct regmap_config sgtl5000_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
 };
 
+/*
+ * Write all the default values from sgtl5000_reg_defaults[] array into the
+ * sgtl5000 registers, to make sure we always start with the sane registers
+ * values as stated in the datasheet.
+ *
+ * Since sgtl5000 does not have a reset line, nor a reset command in software,
+ * we follow this approach to guarantee we always start from the default values
+ * and avoid problems like, not being able to probe after an audio playback
+ * followed by a system reset or a 'reboot' command in Linux
+ */
+static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
+{
+	int i, ret, val, index;
+
+	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
+		val = sgtl5000_reg_defaults[i].def;
+		index = sgtl5000_reg_defaults[i].reg;
+		ret = regmap_write(sgtl5000->regmap, index, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int sgtl5000_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1494,6 +1519,11 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, sgtl5000);
 
+	/* Ensure sgtl5000 will start with sane register values */
+	ret = sgtl5000_fill_defaults(sgtl5000);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
 	return ret;
-- 
1.7.9.5
