From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: tlv320aic26: Fix keyclick feature
Date: Tue,  6 Aug 2013 13:39:29 +0200
Message-ID: <1375789171-12098-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-024.synserver.de (smtp-out-024.synserver.de
 [212.40.185.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 216E42616CB
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:38:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The tlv320aic26 contains a embedded snd_soc_codec struct which is referenced in
the keyclick code. That struct is never initialized though, replace the embedded
struct with a pointer and use that in the keyclick code.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic26.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index b1f6982..b192cd4 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -29,7 +29,7 @@ MODULE_LICENSE("GPL");
 /* AIC26 driver private data */
 struct aic26 {
 	struct spi_device *spi;
-	struct snd_soc_codec codec;
+	struct snd_soc_codec *codec;
 	int master;
 	int datfm;
 	int mclk;
@@ -330,7 +330,7 @@ static ssize_t aic26_keyclick_show(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val, amp, freq, len;
 
-	val = aic26_reg_read_cache(&aic26->codec, AIC26_REG_AUDIO_CTRL2);
+	val = aic26_reg_read_cache(aic26->codec, AIC26_REG_AUDIO_CTRL2);
 	amp = (val >> 12) & 0x7;
 	freq = (125 << ((val >> 8) & 0x7)) >> 1;
 	len = 2 * (1 + ((val >> 4) & 0xf));
@@ -346,9 +346,9 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val;
 
-	val = aic26_reg_read_cache(&aic26->codec, AIC26_REG_AUDIO_CTRL2);
+	val = aic26_reg_read_cache(aic26->codec, AIC26_REG_AUDIO_CTRL2);
 	val |= 0x8000;
-	aic26_reg_write(&aic26->codec, AIC26_REG_AUDIO_CTRL2, val);
+	aic26_reg_write(aic26->codec, AIC26_REG_AUDIO_CTRL2, val);
 
 	return count;
 }
@@ -360,8 +360,11 @@ static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
  */
 static int aic26_probe(struct snd_soc_codec *codec)
 {
+	struct aic26 *aic26 = dev_get_drvdata(codec->dev);
 	int ret, err, i, reg;
 
+	aic26->codec = codec;
+
 	dev_info(codec->dev, "Probing AIC26 SoC CODEC driver\n");
 
 	/* Reset the codec to power on defaults */
-- 
1.8.0
