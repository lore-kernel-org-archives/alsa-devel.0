From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] ASoC: tlv320aic23: add missing EXPORT_SYMBOLs
Date: Sat,  8 Mar 2014 13:31:06 +0400
Message-ID: <1394271066-25380-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6846426536C
 for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2014 10:31:45 +0100 (CET)
Received: by mail-la0-f42.google.com with SMTP id ec20so3515031lab.1
 for <alsa-devel@alsa-project.org>; Sat, 08 Mar 2014 01:31:45 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This fixes the following build errors when aic23 is configured as
module:

>> ERROR: "tlv320aic23_probe"
>> [sound/soc/codecs/snd-soc-tlv320aic23-i2c.ko] undefined!
>> ERROR: "tlv320aic23_regmap"
>> [sound/soc/codecs/snd-soc-tlv320aic23-i2c.ko] undefined!

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 sound/soc/codecs/tlv320aic23.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 455250f..a934add 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -59,6 +59,7 @@ const struct regmap_config tlv320aic23_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(tlv320aic23_reg),
 	.cache_type = REGCACHE_RBTREE,
 };
+EXPORT_SYMBOL(tlv320aic23_regmap);
 
 static const char *rec_src_text[] = { "Line", "Mic" };
 static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
@@ -634,6 +635,7 @@ int tlv320aic23_probe(struct device *dev, struct regmap *regmap)
 	return snd_soc_register_codec(dev, &soc_codec_dev_tlv320aic23,
 				      &tlv320aic23_dai, 1);
 }
+EXPORT_SYMBOL(tlv320aic23_probe);
 
 MODULE_DESCRIPTION("ASoC TLV320AIC23 codec driver");
 MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
-- 
1.8.1.4
