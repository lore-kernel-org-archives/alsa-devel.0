From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tobermory: Stop the FLL if we fail to
	switch SYSCLK to it
Date: Fri,  7 Feb 2014 20:01:19 +0000
Message-ID: <1391803279-12650-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E9B0265454
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 21:05:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsnmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/samsung/tobermory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index f21ff608a819..1807b75ccc12 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -44,6 +44,8 @@ static int tobermory_set_bias_level(struct snd_soc_card *card,
 						     SND_SOC_CLOCK_IN);
 			if (ret < 0) {
 				pr_err("Failed to set SYSCLK: %d\n", ret);
+				snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
+						    0, 0, 0);
 				return ret;
 			}
 		}
-- 
1.9.rc1
