From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: ASoC: ak4104: correct tranceiver
	enable handling
Date: Wed,  6 Mar 2013 22:22:16 +0100
Message-ID: <1362604936-13624-2-git-send-email-zonque@gmail.com>
References: <1362604936-13624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF42260305
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 22:22:24 +0100 (CET)
In-Reply-To: <1362604936-13624-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Move the enabling of the TX diode to hw_params() and disable it again in
hw_free(). This way, the diode is only switched on as long as it needs
to be.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak4104.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 58f390d..c7cfdf9 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -93,7 +93,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
-	int val = 0;
+	int ret, val = 0;
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
 	val |= IEC958_AES0_CON_NOT_COPYRIGHT;
@@ -134,11 +134,33 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return regmap_write(ak4104->regmap, AK4104_REG_CHN_STATUS(3), val);
+	ret = regmap_write(ak4104->regmap, AK4104_REG_CHN_STATUS(3), val);
+	if (ret < 0)
+		return ret;
+
+	/* enable transmitter */
+	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
+				 AK4104_TX_TXE, AK4104_TX_TXE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ak4104_hw_free(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+
+	/* disable transmitter */
+	return regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
+				  AK4104_TX_TXE, 0);
 }
 
 static const struct snd_soc_dai_ops ak4101_dai_ops = {
 	.hw_params = ak4104_hw_params,
+	.hw_free = ak4104_hw_free,
 	.set_fmt = ak4104_set_dai_fmt,
 };
 
-- 
1.8.1.4
