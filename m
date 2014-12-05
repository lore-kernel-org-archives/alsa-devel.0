From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: samsung: Fix error handling for clock
	lookup
Date: Fri,  5 Dec 2014 19:58:58 +0000
Message-ID: <1417809538-5365-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA6412605C8
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 20:59:14 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Return the error code we got from clk_get() and check to make sure that
clk_prepare_enable() worked.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 25919e090983..500b9ba5ebaa 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -972,6 +972,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
+	int ret;
 
 	if (other && other->clk) { /* If this is probe on secondary */
 		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
@@ -989,9 +990,14 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	if (IS_ERR(i2s->clk)) {
 		dev_err(&i2s->pdev->dev, "failed to get i2s_clock\n");
 		iounmap(i2s->addr);
-		return -ENOENT;
+		return PTR_ERR(i2s->clk);
+	}
+
+	ret = clk_prepare_enable(i2s->clk);
+	if (ret != 0) {
+		dev_err(&i2s->pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
 	}
-	clk_prepare_enable(i2s->clk);
 
 	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
-- 
2.1.3
