From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: wl1273: Convert to params_width()
Date: Thu, 31 Jul 2014 13:02:23 +0100
Message-ID: <1406808143-8985-5-git-send-email-broonie@kernel.org>
References: <1406808143-8985-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C16A32655C2
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:02:40 +0200 (CEST)
In-Reply-To: <1406808143-8985-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wl1273.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 5d8ba779085b..f3d4e88d0b7b 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -341,8 +341,9 @@ static int wl1273_hw_params(struct snd_pcm_substream *substream,
 	struct wl1273_core *core = wl1273->core;
 	unsigned int rate, width, r;
 
-	if (params_format(params) != SNDRV_PCM_FORMAT_S16_LE) {
-		pr_err("Only SNDRV_PCM_FORMAT_S16_LE supported.\n");
+	if (params_width(params) != 16) {
+		dev_err(dai->dev, "%d bits/sample not supported\n",
+			params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
