From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tpa6130a2: TLV mapping for tpa6140a2
Date: Tue,  4 May 2010 11:08:18 +0300
Message-ID: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3827F24399
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 10:08:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ilkka.koskinen@nokia.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Both tpa6130a2, and tpa6140a2 is supported by the
same driver, but the gain dB scaling is different on
the amplifiers.

Provide different mixer control for the chips with correct
TLV mapping.

User space will see:
"TPA6130A2 Headphone Playback Volume" in case of 6130
"TPA6140A2 Headphone Playback Volume" in case of 6140

The way machine drivers are using this amplifier remained
the same.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 958d49c..0cf3e38 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -53,6 +53,7 @@ struct tpa6130a2_data {
 	struct regulator_bulk_data supplies[TPA6130A2_NUM_SUPPLIES];
 	int power_gpio;
 	unsigned char power_state;
+	enum tpa_model id;
 };
 
 static int tpa6130a2_i2c_read(int reg)
@@ -263,6 +264,20 @@ static const struct snd_kcontrol_new tpa6130a2_controls[] = {
 		       tpa6130_tlv),
 };
 
+static const unsigned int tpa6140_tlv[] = {
+	TLV_DB_RANGE_HEAD(3),
+	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
+	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
+	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
+};
+
+static const struct snd_kcontrol_new tpa6140a2_controls[] = {
+	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
+		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
+		       tpa6130a2_get_reg, tpa6130a2_set_reg,
+		       tpa6140_tlv),
+};
+
 /*
  * Enable or disable channel (left or right)
  * The bit number for mute and amplifier are the same per channel:
@@ -368,13 +383,22 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 {
+	struct	tpa6130a2_data *data;
+
+	BUG_ON(tpa6130a2_client == NULL);
+	data = i2c_get_clientdata(tpa6130a2_client);
+
 	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
 				ARRAY_SIZE(tpa6130a2_dapm_widgets));
 
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	return snd_soc_add_controls(codec, tpa6130a2_controls,
-				ARRAY_SIZE(tpa6130a2_controls));
+	if (data->id == TPA6140A2)
+		return snd_soc_add_controls(codec, tpa6140a2_controls,
+						ARRAY_SIZE(tpa6140a2_controls));
+	else
+		return snd_soc_add_controls(codec, tpa6130a2_controls,
+						ARRAY_SIZE(tpa6130a2_controls));
 
 }
 EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
@@ -407,6 +431,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 
 	pdata = client->dev.platform_data;
 	data->power_gpio = pdata->power_gpio;
+	data->id = pdata->id;
 
 	mutex_init(&data->mutex);
 
@@ -425,7 +450,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 		gpio_direction_output(data->power_gpio, 0);
 	}
 
-	switch (pdata->id) {
+	switch (data->id) {
 	case TPA6130A2:
 		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
 			data->supplies[i].supply = tpa6130a2_supply_names[i];
-- 
1.7.1
