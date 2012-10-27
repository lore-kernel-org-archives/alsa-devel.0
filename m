From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: jz4740-codec: Add dB information
Date: Sat, 27 Oct 2012 17:15:06 +0200
Message-ID: <1351350908-4262-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-149.synserver.de (smtp-out-149.synserver.de
 [212.40.185.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 296632651D7
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2012 17:14:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Add dB TLV ranges for the various volume controls.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/jz4740.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 85d9cab..51b4f99 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -24,6 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/tlv.h>
 
 #define JZ4740_REG_CODEC_1 0x0
 #define JZ4740_REG_CODEC_2 0x1
@@ -95,15 +96,27 @@ static int jz4740_codec_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int jz4740_mic_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 2, TLV_DB_SCALE_ITEM(0, 600, 0),
+	3, 3, TLV_DB_SCALE_ITEM(2000, 0, 0),
+};
+
+static const DECLARE_TLV_DB_SCALE(jz4740_out_tlv, 0, 200, 0);
+static const DECLARE_TLV_DB_SCALE(jz4740_in_tlv, -3450, 150, 0);
+
 static const struct snd_kcontrol_new jz4740_codec_controls[] = {
-	SOC_SINGLE("Master Playback Volume", JZ4740_REG_CODEC_2,
-			JZ4740_CODEC_2_HEADPHONE_VOLUME_OFFSET, 3, 0),
-	SOC_SINGLE("Master Capture Volume", JZ4740_REG_CODEC_2,
-			JZ4740_CODEC_2_INPUT_VOLUME_OFFSET, 31, 0),
+	SOC_SINGLE_TLV("Master Playback Volume", JZ4740_REG_CODEC_2,
+			JZ4740_CODEC_2_HEADPHONE_VOLUME_OFFSET, 3, 0,
+			jz4740_out_tlv),
+	SOC_SINGLE_TLV("Master Capture Volume", JZ4740_REG_CODEC_2,
+			JZ4740_CODEC_2_INPUT_VOLUME_OFFSET, 31, 0,
+			jz4740_in_tlv),
 	SOC_SINGLE("Master Playback Switch", JZ4740_REG_CODEC_1,
 			JZ4740_CODEC_1_HEADPHONE_DISABLE_OFFSET, 1, 1),
-	SOC_SINGLE("Mic Capture Volume", JZ4740_REG_CODEC_2,
-			JZ4740_CODEC_2_MIC_BOOST_GAIN_OFFSET, 3, 0),
+	SOC_SINGLE_TLV("Mic Capture Volume", JZ4740_REG_CODEC_2,
+			JZ4740_CODEC_2_MIC_BOOST_GAIN_OFFSET, 3, 0,
+			jz4740_mic_tlv),
 };
 
 static const struct snd_kcontrol_new jz4740_codec_output_controls[] = {
-- 
1.7.2.5
