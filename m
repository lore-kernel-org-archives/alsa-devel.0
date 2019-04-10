From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Date: Wed, 10 Apr 2019 03:15:26 +0000
Message-ID: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67D58F80765
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 05:15:29 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

The table is not flexible if supported sample rate is not in the
table, so use a function to replace it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 73 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0b937924d2e4..a57c6c829060 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -26,24 +26,6 @@
 #define pair_dbg(fmt, ...) \
 	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
 
-/* Sample rates are aligned with that defined in pcm.h file */
-static const u8 process_option[][12][2] = {
-	/* 8kHz 11.025kHz 16kHz 22.05kHz 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96kHz   176kHz  192kHz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
-	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
-	{{1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
-	{{1, 2}, {1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
-	{{1, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
-	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
-	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
-};
-
 /* Corresponding to process_option */
 static int supported_input_rate[] = {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
@@ -79,6 +61,49 @@
 
 static unsigned char *clk_map[2];
 
+static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int *post_proc)
+{
+	bool det_out_op2_cond;
+	bool det_out_op0_cond;
+
+	det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
+					((Fsin > 56000) & (Fsout < 56000)));
+	det_out_op0_cond = (Fsin * 23 < Fsout * 8);
+
+	/*
+	 * Not supported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
+	 */
+	if (Fsin * 8 > 129 * Fsout)
+		*pre_proc = 5;
+	else if (Fsin * 8 > 65 * Fsout)
+		*pre_proc = 4;
+	else if (Fsin * 8 > 33 * Fsout)
+		*pre_proc = 2;
+	else if (Fsin * 8 > 15 * Fsout) {
+		if (Fsin > 152000)
+			*pre_proc = 2;
+		else
+			*pre_proc = 1;
+	} else if (Fsin < 76000)
+		*pre_proc = 0;
+	else if (Fsin > 152000)
+		*pre_proc = 2;
+	else
+		*pre_proc = 1;
+
+	if (det_out_op2_cond)
+		*post_proc = 2;
+	else if (det_out_op0_cond)
+		*post_proc = 0;
+	else
+		*post_proc = 1;
+
+	if (*pre_proc == 4 || *pre_proc == 5)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * Request ASRC pair
  *
@@ -239,8 +264,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	u32 inrate, outrate, indiv, outdiv;
 	u32 clk_index[2], div[2];
 	int in, out, channels;
+	int pre_proc, post_proc;
 	struct clk *clk;
 	bool ideal;
+	int ret;
 
 	if (!config) {
 		pair_err("invalid pair config\n");
@@ -377,11 +404,17 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
 			   ASRCTR_IDR(index) | ASRCTR_USR(index));
 
+	ret = proc_autosel(inrate, outrate, &pre_proc, &post_proc);
+	if (ret) {
+		pair_err("No supported pre-processing options\n");
+		return ret;
+	}
+
 	/* Apply configurations for pre- and post-processing */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
 			   ASRCFG_PREMODi_MASK(index) |	ASRCFG_POSTMODi_MASK(index),
-			   ASRCFG_PREMOD(index, process_option[in][out][0]) |
-			   ASRCFG_POSTMOD(index, process_option[in][out][1]));
+			   ASRCFG_PREMOD(index, pre_proc) |
+			   ASRCFG_POSTMOD(index, post_proc));
 
 	return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
 }
-- 
1.9.1
