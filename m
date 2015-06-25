From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: lm49453: Remove fs_rate from struct
	lm49453_priv
Date: Thu, 25 Jun 2015 17:01:14 +0800
Message-ID: <1435222874.22996.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E19260499
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 11:01:21 +0200 (CEST)
Received: by pdbep18 with SMTP id ep18so27547582pdb.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 02:01:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

fs_rate is only used in lm49453_hw_params() so don't need to store it in
private data.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/lm49453.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 6600aa0..5b4086d 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -188,7 +188,6 @@ static struct reg_default lm49453_reg_defs[] = {
 /* codec private data */
 struct lm49453_priv {
 	struct regmap *regmap;
-	int fs_rate;
 };
 
 /* capture path controls */
@@ -1112,13 +1111,10 @@ static int lm49453_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
 	u16 clk_div = 0;
 
-	lm49453->fs_rate = params_rate(params);
-
 	/* Setting DAC clock dividers based on substream sample rate. */
-	switch (lm49453->fs_rate) {
+	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
 	case 32000:
-- 
2.1.0
