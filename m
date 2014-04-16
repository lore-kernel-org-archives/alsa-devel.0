From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: rt5640: Add minimal support for RT5642
Date: Wed, 16 Apr 2014 16:16:16 +0300
Message-ID: <1397654176-5736-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2052652FF
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 15:16:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have been using rt5640.c codec driver with RT5642 codec chip before commit
022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts using
device ID reading in reset register for adding device specific controls and
routes runtime.

Now since device ID appears to be different between RT5640 and RT5642 the
driver doesn't add those controls and routes that are valid also on RT5642.

Fix this by adding a device ID found by debugging and minimal code for
supporting RT5642.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 2 ++
 sound/soc/codecs/rt5640.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index b947c820697d..ffde5bf11789 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2000,6 +2000,7 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 
 	switch (snd_soc_read(codec, RT5640_RESET)) {
 	case RT5640_RESET_ID:
+	case RT5642_RESET_ID:
 		snd_soc_add_codec_controls(codec,
 			rt5640_specific_snd_controls,
 			ARRAY_SIZE(rt5640_specific_snd_controls));
@@ -2150,6 +2151,7 @@ static const struct regmap_config rt5640_regmap = {
 static const struct i2c_device_id rt5640_i2c_id[] = {
 	{ "rt5640", 0 },
 	{ "rt5639", 0 },
+	{ "rt5642", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 3b50459a83b4..d31faeaa637e 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -16,6 +16,7 @@
 
 #define RT5639_RESET_ID				0x0008
 #define RT5640_RESET_ID				0x000c
+#define RT5642_RESET_ID				0x0006
 
 /* Info */
 #define RT5640_RESET				0x00
-- 
1.9.1
