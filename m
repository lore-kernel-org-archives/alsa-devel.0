From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: cht-bsw-rt5645: Also enable/disable the
	clock on Cherry Trail
Date: Sat, 14 Oct 2017 14:22:13 +0200
Message-ID: <20171014122213.7769-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C89266D77
 for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2017 14:22:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Just like on Bay Trail the codec mclk is also controlled by the common
clk framework as pmc_plt_clk_3 on Cherry Trail and the cht-bsw-rt5645
needs to control it so that it has the right frequency and gets
en/disabled as appropriate.

This fixes the sound crackling (like a bonfire) when the clock was not
set up properly before Linux boots and turns the clock off when not in
use saving power.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196351
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 5bcde01d15e6..d553e2b67c92 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -682,14 +682,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 			cht_rt5645_cpu_dai_name;
 	}
 
-	if (is_valleyview()) {
-		drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-		if (IS_ERR(drv->mclk)) {
-			dev_err(&pdev->dev,
-				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-				PTR_ERR(drv->mclk));
-			return PTR_ERR(drv->mclk);
-		}
+	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (IS_ERR(drv->mclk)) {
+		dev_err(&pdev->dev,
+			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+			PTR_ERR(drv->mclk));
+		return PTR_ERR(drv->mclk);
 	}
 
 	snd_soc_card_set_drvdata(card, drv);
-- 
2.14.2
