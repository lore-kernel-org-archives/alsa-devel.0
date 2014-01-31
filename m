From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: wm8962: Clean up error handling for
	failed FLL start
Date: Fri, 31 Jan 2014 15:30:00 +0000
Message-ID: <1391182201-29439-3-git-send-email-broonie@kernel.org>
References: <1391182201-29439-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2258A264F34
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:30:13 +0100 (CET)
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

Don't record the FLL as having started and leave the hardware disabled
ensuring we are in a better state if this does happen to be a transient
error and making debugging easier.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8eccf7afe9db..55bf3f493dab 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2898,8 +2898,6 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
-	ret = 0;
-
 	/* This should be a massive overestimate but go even
 	 * higher if we'll error out
 	 */
@@ -2913,14 +2911,17 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	if (timeout == 0 && wm8962->irq) {
 		dev_err(codec->dev, "FLL lock timed out");
-		ret = -ETIMEDOUT;
+		snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
+				    WM8962_FLL_ENA, 0);
+		pm_runtime_put(codec->dev);
+		return -ETIMEDOUT;
 	}
 
 	wm8962->fll_fref = Fref;
 	wm8962->fll_fout = Fout;
 	wm8962->fll_src = source;
 
-	return ret;
+	return 0;
 }
 
 static int wm8962_mute(struct snd_soc_dai *dai, int mute)
-- 
1.9.rc1
