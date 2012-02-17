From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: ak4104: Use snd_soc_update_bits()
	for read/modify/write
Date: Fri, 17 Feb 2012 12:23:10 -0800
Message-ID: <1329510192-4442-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
	<1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D29F103FE3
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:23:20 +0100 (CET)
In-Reply-To: <1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Don't use the internal I/O functions directly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index f12c115..d6d9e40 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -110,12 +110,6 @@ static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	int val = 0;
 
-	val = ak4104_read_reg_cache(codec, AK4104_REG_CONTROL1);
-	if (val < 0)
-		return val;
-
-	val &= ~(AK4104_CONTROL1_DIF0 | AK4104_CONTROL1_DIF1);
-
 	/* set DAI format */
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
@@ -135,7 +129,13 @@ static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
 		return -EINVAL;
 
-	return ak4104_spi_write(codec, AK4104_REG_CONTROL1, val);
+	ret = snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
+				  AK4104_CONTROL1_DIF0 | AK4104_CONTROL1_DIF1,
+				  val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int ak4104_hw_params(struct snd_pcm_substream *substream,
@@ -211,16 +211,15 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 		return -ENODEV;
 
 	/* set power-up and non-reset bits */
-	val = ak4104_read_reg_cache(codec, AK4104_REG_CONTROL1);
-	val |= AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN;
-	ret = ak4104_spi_write(codec, AK4104_REG_CONTROL1, val);
+	ret = snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
+				  AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
+				  AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
 	if (ret < 0)
 		return ret;
 
 	/* enable transmitter */
-	val = ak4104_read_reg_cache(codec, AK4104_REG_TX);
-	val |= AK4104_TX_TXE;
-	ret = ak4104_spi_write(codec, AK4104_REG_TX, val);
+	ret = snd_soc_update_bits(codec, AK4104_REG_TX,
+				  AK4104_TX_TXE, AK4104_TX_TXE);
 	if (ret < 0)
 		return ret;
 
@@ -229,17 +228,10 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 
 static int ak4104_remove(struct snd_soc_codec *codec)
 {
-	int val, ret;
-
-	val = ak4104_read_reg_cache(codec, AK4104_REG_CONTROL1);
-	if (val < 0)
-		return val;
-
-	/* clear power-up and non-reset bits */
-	val &= ~(AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
-	ret = ak4104_spi_write(codec, AK4104_REG_CONTROL1, val);
+	snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
+			    AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
 
-	return ret;
+	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
-- 
1.7.9
