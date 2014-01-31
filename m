From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: wm8962: Check if we runtime resume
	the device when starting FLL
Date: Fri, 31 Jan 2014 15:29:59 +0000
Message-ID: <1391182201-29439-2-git-send-email-broonie@kernel.org>
References: <1391182201-29439-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 35BC0264FEB
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:30:16 +0100 (CET)
In-Reply-To: <1391182201-29439-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index aa7ae76d5e28..8eccf7afe9db 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2886,7 +2886,11 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	try_wait_for_completion(&wm8962->fll_lock);
 
-	pm_runtime_get_sync(codec->dev);
+	ret = pm_runtime_get_sync(codec->dev);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to resume device: %d\n", ret);
+		return ret;
+	}
 
 	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 			    WM8962_FLL_FRAC | WM8962_FLL_REFCLK_SRC_MASK |
-- 
1.9.rc1
