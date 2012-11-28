From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5102: Enable DVFS support for the
	DSP
Date: Wed, 28 Nov 2012 17:26:04 +0000
Message-ID: <1354123564-7005-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1354123564-7005-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A93226172B
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:32:26 +0100 (CET)
In-Reply-To: <1354123564-7005-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 5a1eb5b..760df35 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1459,7 +1459,7 @@ static int __devinit wm5102_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct wm5102_priv *wm5102;
-	int i;
+	int i, ret;
 
 	wm5102 = devm_kzalloc(&pdev->dev, sizeof(struct wm5102_priv),
 			      GFP_KERNEL);
@@ -1478,6 +1478,10 @@ static int __devinit wm5102_probe(struct platform_device *pdev)
 	wm5102->core.adsp[0].mem = wm5102_dsp1_regions;
 	wm5102->core.adsp[0].num_mems = ARRAY_SIZE(wm5102_dsp1_regions);
 
+	ret = wm_adsp2_init(&wm5102->core.adsp[0], true);
+	if (ret != 0)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(wm5102->fll); i++)
 		wm5102->fll[i].vco_mult = 1;
 
-- 
1.7.10.4
