From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: da7213: Fix setting dmic_samplephase
 and dmic_clk_rate
Date: Thu, 09 May 2013 21:14:20 +0800
Message-ID: <1368105260.10534.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 071E42602F3
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 15:14:26 +0200 (CEST)
Received: by mail-pb0-f43.google.com with SMTP id md12so1983480pbc.30
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 06:14:25 -0700 (PDT)
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
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When set dmic_samplephase and dmic_clk_rate bits for dmic_cfg,
current code checks pdata->dmic_data_sel which is wrong.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This looks like a copy-paste bug.

 sound/soc/codecs/da7213.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 41230ad..4a6f1da 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1488,17 +1488,17 @@ static int da7213_probe(struct snd_soc_codec *codec)
 				     DA7213_DMIC_DATA_SEL_SHIFT);
 			break;
 		}
-		switch (pdata->dmic_data_sel) {
+		switch (pdata->dmic_samplephase) {
 		case DA7213_DMIC_SAMPLE_ON_CLKEDGE:
 		case DA7213_DMIC_SAMPLE_BETWEEN_CLKEDGE:
-			dmic_cfg |= (pdata->dmic_data_sel <<
+			dmic_cfg |= (pdata->dmic_samplephase <<
 				     DA7213_DMIC_SAMPLEPHASE_SHIFT);
 			break;
 		}
-		switch (pdata->dmic_data_sel) {
+		switch (pdata->dmic_clk_rate) {
 		case DA7213_DMIC_CLK_3_0MHZ:
 		case DA7213_DMIC_CLK_1_5MHZ:
-			dmic_cfg |= (pdata->dmic_data_sel <<
+			dmic_cfg |= (pdata->dmic_clk_rate <<
 				     DA7213_DMIC_CLK_RATE_SHIFT);
 			break;
 		}
-- 
1.8.1.2
