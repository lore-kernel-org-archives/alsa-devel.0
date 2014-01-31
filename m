From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: wm8962: Reinitialise the IRQ
	completion rather than just trying it
Date: Fri, 31 Jan 2014 15:30:01 +0000
Message-ID: <1391182201-29439-4-git-send-email-broonie@kernel.org>
References: <1391182201-29439-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 35949264F74
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

This is better practice.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 55bf3f493dab..1663b6b6eb35 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2884,7 +2884,7 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	snd_soc_write(codec, WM8962_FLL_CONTROL_7, fll_div.lambda);
 	snd_soc_write(codec, WM8962_FLL_CONTROL_8, fll_div.n);
 
-	try_wait_for_completion(&wm8962->fll_lock);
+	reinit_completion(&wm8962->fll_lock);
 
 	ret = pm_runtime_get_sync(codec->dev);
 	if (ret < 0) {
-- 
1.9.rc1
