From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/4] ASoC: tlv320dac33: Optimize power up,
	and restore
Date: Fri, 30 Apr 2010 10:31:52 +0300
Message-ID: <1272612715-13387-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id EC8D41037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 09:32:04 +0200 (CEST)
In-Reply-To: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On power up we only need to initialize the codec, and
restore only registers, which are not in either in DAPM
nor in the playback start sequence.
These are mostly gain related registers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |  111 ++++++++++++++++------------------------
 1 files changed, 44 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 54b2a05..41cad6c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -284,45 +284,54 @@ static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 	return ret;
 }
 
-static void dac33_restore_regs(struct snd_soc_codec *codec)
+static void dac33_init_chip(struct snd_soc_codec *codec)
 {
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	u8 *cache = codec->reg_cache;
-	u8 data[2];
-	int i, ret;
 
-	if (!dac33->chip_power)
+	if (unlikely(!dac33->chip_power))
 		return;
 
-	for (i = DAC33_PWR_CTRL; i <= DAC33_INTP_CTRL_B; i++) {
-		data[0] = i;
-		data[1] = cache[i];
-		/* Skip the read only registers */
-		if ((i >= DAC33_INT_OSC_STATUS &&
-				i <= DAC33_INT_OSC_FREQ_RAT_READ_B) ||
-		    (i >= DAC33_FIFO_WPTR_MSB && i <= DAC33_FIFO_IRQ_FLAG) ||
-		    i == DAC33_DAC_STATUS_FLAGS ||
-		    i == DAC33_SRC_EST_REF_CLK_RATIO_A ||
-		    i == DAC33_SRC_EST_REF_CLK_RATIO_B)
-			continue;
-		ret = codec->hw_write(codec->control_data, data, 2);
-		if (ret != 2)
-			dev_err(codec->dev, "Write failed (%d)\n", ret);
-	}
-	for (i = DAC33_LDAC_PWR_CTRL; i <= DAC33_LINEL_TO_LLO_VOL; i++) {
-		data[0] = i;
-		data[1] = cache[i];
-		ret = codec->hw_write(codec->control_data, data, 2);
-		if (ret != 2)
-			dev_err(codec->dev, "Write failed (%d)\n", ret);
-	}
-	for (i = DAC33_LINER_TO_RLO_VOL; i <= DAC33_OSC_TRIM; i++) {
-		data[0] = i;
-		data[1] = cache[i];
-		ret = codec->hw_write(codec->control_data, data, 2);
-		if (ret != 2)
-			dev_err(codec->dev, "Write failed (%d)\n", ret);
-	}
+	/* 44-46: DAC Control Registers */
+	/* A : DAC sample rate Fsref/1.5 */
+	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
+	/* B : DAC src=normal, not muted */
+	dac33_write(codec, DAC33_DAC_CTRL_B, DAC33_DACSRCR_RIGHT |
+					     DAC33_DACSRCL_LEFT);
+	/* C : (defaults) */
+	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
+
+	/* 64-65 : L&R DAC power control
+	 Line In -> OUT 1V/V Gain, DAC -> OUT 4V/V Gain*/
+	dac33_write(codec, DAC33_LDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
+	dac33_write(codec, DAC33_RDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
+
+	/* 73 : volume soft stepping control,
+	 clock source = internal osc (?) */
+	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
+
+	/* 66 : LOP/LOM Modes */
+	dac33_write(codec, DAC33_OUT_AMP_CM_CTRL, 0xff);
+
+	/* 68 : LOM inverted from LOP */
+	dac33_write(codec, DAC33_OUT_AMP_CTRL, (3<<2));
+
+	dac33_write(codec, DAC33_PWR_CTRL, DAC33_PDNALLB);
+
+	/* Restore only selected registers (gains mostly) */
+	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
+	dac33_write(codec, DAC33_RDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_RDAC_DIG_VOL_CTRL));
+
+	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
+	dac33_write(codec, DAC33_RDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_RDAC_DIG_VOL_CTRL));
+
+	dac33_write(codec, DAC33_LINEL_TO_LLO_VOL,
+		    dac33_read_reg_cache(codec, DAC33_LINEL_TO_LLO_VOL));
+	dac33_write(codec, DAC33_LINER_TO_RLO_VOL,
+		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
 }
 
 static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
@@ -358,8 +367,7 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 
 		dac33->chip_power = 1;
 
-		/* Restore registers */
-		dac33_restore_regs(codec);
+		dac33_init_chip(codec);
 
 		dac33_soft_power(codec, 1);
 	} else {
@@ -1269,35 +1277,6 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static void dac33_init_chip(struct snd_soc_codec *codec)
-{
-	/* 44-46: DAC Control Registers */
-	/* A : DAC sample rate Fsref/1.5 */
-	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
-	/* B : DAC src=normal, not muted */
-	dac33_write(codec, DAC33_DAC_CTRL_B, DAC33_DACSRCR_RIGHT |
-					     DAC33_DACSRCL_LEFT);
-	/* C : (defaults) */
-	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
-
-	/* 64-65 : L&R DAC power control
-	 Line In -> OUT 1V/V Gain, DAC -> OUT 4V/V Gain*/
-	dac33_write(codec, DAC33_LDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
-	dac33_write(codec, DAC33_RDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
-
-	/* 73 : volume soft stepping control,
-	 clock source = internal osc (?) */
-	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
-
-	/* 66 : LOP/LOM Modes */
-	dac33_write(codec, DAC33_OUT_AMP_CM_CTRL, 0xff);
-
-	/* 68 : LOM inverted from LOP */
-	dac33_write(codec, DAC33_OUT_AMP_CTRL, (3<<2));
-
-	dac33_write(codec, DAC33_PWR_CTRL, DAC33_PDNALLB);
-}
-
 static int dac33_soc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -1313,8 +1292,6 @@ static int dac33_soc_probe(struct platform_device *pdev)
 
 	/* Power up the codec */
 	dac33_hard_power(codec, 1);
-	/* Set default configuration */
-	dac33_init_chip(codec);
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-- 
1.7.0.4
