From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 5/7] ASoC: stm32: i2s: remove useless callback
Date: Tue, 26 Feb 2019 14:51:08 +0100
Message-ID: <1551189070-15469-6-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Clocks do not need to be released on driver removal,
as this is already managed before.
Remove useless remove callback.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 95fffb61faa5..9edb753ffa1b 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -902,16 +902,6 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 }
 
-static int stm32_i2s_remove(struct platform_device *pdev)
-{
-	struct stm32_i2s_data *i2s = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(i2s->i2sclk);
-	clk_disable_unprepare(i2s->pclk);
-
-	return 0;
-}
-
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
 
 #ifdef CONFIG_PM_SLEEP
@@ -945,7 +935,6 @@ static struct platform_driver stm32_i2s_driver = {
 		.pm = &stm32_i2s_pm_ops,
 	},
 	.probe = stm32_i2s_probe,
-	.remove = stm32_i2s_remove,
 };
 
 module_platform_driver(stm32_i2s_driver);
-- 
2.7.4
