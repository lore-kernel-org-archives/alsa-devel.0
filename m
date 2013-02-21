From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: max98090: Remove unnecessary braces
Date: Thu, 21 Feb 2013 12:25:00 +0530
Message-ID: <1361429700-27457-2-git-send-email-sachin.kamat@linaro.org>
References: <1361429700-27457-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 890092602C7
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 08:05:05 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id fa10so4588609pad.41
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 23:05:04 -0800 (PST)
In-Reply-To: <1361429700-27457-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Braces are not required for single line statements.
Silences the following checkpatch warnings:
WARNING: braces {} are not necessary for single statement blocks.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/max98090.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 89f83f8..ce0d364 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1701,9 +1701,8 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		 * seen for the case of TDM mode. The remaining cases have
 		 * normal logic.
 		 */
-		if (max98090->tdm_slots > 1) {
+		if (max98090->tdm_slots > 1)
 			regval ^= M98090_BCI_MASK;
-		}
 
 		snd_soc_write(codec,
 			M98090_REG_INTERFACE_FORMAT, regval);
@@ -2057,17 +2056,14 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 	if (!active)
 		return IRQ_NONE;
 
-	if (active & M98090_CLD_MASK) {
+	if (active & M98090_CLD_MASK)
 		dev_err(codec->dev, "M98090_CLD_MASK\n");
-	}
 
-	if (active & M98090_SLD_MASK) {
+	if (active & M98090_SLD_MASK)
 		dev_dbg(codec->dev, "M98090_SLD_MASK\n");
-	}
 
-	if (active & M98090_ULK_MASK) {
+	if (active & M98090_ULK_MASK)
 		dev_err(codec->dev, "M98090_ULK_MASK\n");
-	}
 
 	if (active & M98090_JDET_MASK) {
 		dev_dbg(codec->dev, "M98090_JDET_MASK\n");
@@ -2078,13 +2074,11 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 			msecs_to_jiffies(100));
 	}
 
-	if (active & M98090_DRCACT_MASK) {
+	if (active & M98090_DRCACT_MASK)
 		dev_dbg(codec->dev, "M98090_DRCACT_MASK\n");
-	}
 
-	if (active & M98090_DRCCLP_MASK) {
+	if (active & M98090_DRCCLP_MASK)
 		dev_err(codec->dev, "M98090_DRCCLP_MASK\n");
-	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.4.1
