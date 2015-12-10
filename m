From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_asrc: add support for 8-30kHz output
	sample rate
Date: Thu, 10 Dec 2015 19:02:49 +0800
Message-ID: <1449745370-18960-2-git-send-email-zidan.wang@freescale.com>
References: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 by alsa0.perex.cz (Postfix) with ESMTP id CF85A2665B1
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:00:42 +0100 (CET)
In-Reply-To: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

Add 8kHz, 11.025kHz, 16kHz, 22.05kHz output sample rate support.

According referance menual, "Limited support for the case when
output sampling rates is between 8kHz and 30kHz. The limitation
is the supported ratio (Fsin/Fsout) range as between 1/24 to 8."

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_asrc.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 942e74bc..cf17a1f 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -31,21 +31,21 @@
 	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
 
 /* Sample rates are aligned with that defined in pcm.h file */
-static const u8 process_option[][8][2] = {
-	/* 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96kHz   176kHz  192kHz */
-	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
-	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
-	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
-	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
-	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
-	{{0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
-	{{1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
-	{{1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
-	{{1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
-	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
+static const u8 process_option[][12][2] = {
+	/* 8kHz 11.025kHz 16kHz 22.05kHz 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96kHz   176kHz  192kHz */
+	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
+	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
+	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
+	{{1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
+	{{1, 2}, {1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
+	{{1, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
+	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
+	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
+	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
+	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
+	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
+	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
+	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
 };
 
 /* Corresponding to process_option */
@@ -55,7 +55,7 @@ static int supported_input_rate[] = {
 };
 
 static int supported_asrc_rate[] = {
-	32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
+	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
 };
 
 /**
@@ -287,6 +287,13 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
+	if ((outrate > 8000 && outrate < 30000) &&
+			(outrate/inrate > 24 || inrate/outrate > 8)) {
+		pair_err("exceed supported ratio range [1/24, 8] for \
+				inrate/outrate: %d/%d\n", inrate, outrate);
+		return -EINVAL;
+	}
+
 	/* Validate input and output clock sources */
 	clk_index[IN] = clk_map[IN][config->inclk];
 	clk_index[OUT] = clk_map[OUT][config->outclk];
-- 
1.9.1
