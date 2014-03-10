From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ak4642: show error if register write fails
Date: Mon, 10 Mar 2014 18:15:55 +0000
Message-ID: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rainbowdash.ducie.codethink.co.uk (82-68-191-81.dsl.posilan.com
 [82.68.191.81]) by alsa0.perex.cz (Postfix) with ESMTP id EA434265204
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 19:16:00 +0100 (CET)
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
Cc: linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>, broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The calls to snd_soc_update_bits() and snd_soc_write() return error
codes if the calls fails. The ak4642 driver discards these errors
which means that the user is not informed if there is an issue with
the bus providing the register access.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 sound/soc/codecs/ak4642.c | 62 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 4717fa9..15795f6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -225,6 +225,34 @@ static const struct reg_default ak4648_reg[] = {
 	{ 36, 0x00 }, { 37, 0x88 }, { 38, 0x88 }, { 39, 0x08 },
 };
 
+/* wrapper functions to show any errors to updating register values */
+
+static inline int ak4642_update_bits(struct snd_soc_codec *codec,
+				     unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	int ret = snd_soc_update_bits(codec, reg, mask, val);
+
+	if (ret < 0) {
+		pr_info("%s: error %d writing %04x (%08x, mask %08x)\n",
+			codec->name, ret, reg, mask, val);
+	}
+
+	return ret;
+}
+
+static inline int ak4642_soc_write(struct snd_soc_codec *codec,
+				   unsigned int reg, unsigned int value)
+{
+	int ret = snd_soc_write(codec, reg, value);
+
+	if (ret < 0)
+		pr_info("%s: error %d writing %04x to %08x\n",
+			codec->name, ret, reg, value);
+
+	return ret;
+}
+
 static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -242,8 +270,8 @@ static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 		 * This operation came from example code of
 		 * "ASAHI KASEI AK4642" (japanese) manual p97.
 		 */
-		snd_soc_write(codec, L_IVC, 0x91); /* volume */
-		snd_soc_write(codec, R_IVC, 0x91); /* volume */
+		ak4642_soc_write(codec, L_IVC, 0x91); /* volume */
+		ak4642_soc_write(codec, R_IVC, 0x91); /* volume */
 	} else {
 		/*
 		 * start stereo input
@@ -258,11 +286,11 @@ static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 		 * This operation came from example code of
 		 * "ASAHI KASEI AK4642" (japanese) manual p94.
 		 */
-		snd_soc_update_bits(codec, SG_SL1, PMMP | MGAIN0, PMMP | MGAIN0);
-		snd_soc_write(codec, TIMER, ZTM(0x3) | WTM(0x3));
-		snd_soc_write(codec, ALC_CTL1, ALC | LMTH0);
-		snd_soc_update_bits(codec, PW_MGMT1, PMADL, PMADL);
-		snd_soc_update_bits(codec, PW_MGMT3, PMADR, PMADR);
+		ak4642_update_bits(codec, SG_SL1, PMMP | MGAIN0, PMMP | MGAIN0);
+		ak4642_soc_write(codec, TIMER, ZTM(0x3) | WTM(0x3));
+		ak4642_soc_write(codec, ALC_CTL1, ALC | LMTH0);
+		ak4642_update_bits(codec, PW_MGMT1, PMADL, PMADL);
+		ak4642_update_bits(codec, PW_MGMT3, PMADR, PMADR);
 	}
 
 	return 0;
@@ -277,9 +305,9 @@ static void ak4642_dai_shutdown(struct snd_pcm_substream *substream,
 	if (is_play) {
 	} else {
 		/* stop stereo input */
-		snd_soc_update_bits(codec, PW_MGMT1, PMADL, 0);
-		snd_soc_update_bits(codec, PW_MGMT3, PMADR, 0);
-		snd_soc_update_bits(codec, ALC_CTL1, ALC, 0);
+		ak4642_update_bits(codec, PW_MGMT1, PMADL, 0);
+		ak4642_update_bits(codec, PW_MGMT3, PMADR, 0);
+		ak4642_update_bits(codec, ALC_CTL1, ALC, 0);
 	}
 }
 
@@ -312,7 +340,7 @@ static int ak4642_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, MD_CTL1, PLL_MASK, pll);
+	ak4642_update_bits(codec, MD_CTL1, PLL_MASK, pll);
 
 	return 0;
 }
@@ -339,8 +367,8 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, PW_MGMT2, MS | MCKO | PMPLL, data);
-	snd_soc_update_bits(codec, MD_CTL1, BCKO_MASK, bcko);
+	ak4642_update_bits(codec, PW_MGMT2, MS | MCKO | PMPLL, data);
+	ak4642_update_bits(codec, MD_CTL1, BCKO_MASK, bcko);
 
 	/* format type */
 	data = 0;
@@ -357,7 +385,7 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, MD_CTL1, DIF_MASK, data);
+	ak4642_update_bits(codec, MD_CTL1, DIF_MASK, data);
 
 	return 0;
 }
@@ -411,7 +439,7 @@ static int ak4642_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, MD_CTL2, FS_MASK, rate);
+	ak4642_update_bits(codec, MD_CTL2, FS_MASK, rate);
 
 	return 0;
 }
@@ -421,10 +449,10 @@ static int ak4642_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, PW_MGMT1, 0x00);
+		ak4642_soc_write(codec, PW_MGMT1, 0x00);
 		break;
 	default:
-		snd_soc_update_bits(codec, PW_MGMT1, PMVCM, PMVCM);
+		ak4642_update_bits(codec, PW_MGMT1, PMVCM, PMVCM);
 		break;
 	}
 	codec->dapm.bias_level = level;
-- 
1.9.0
