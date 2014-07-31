From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 25/35] ASoC: wm8978: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:08 +0100
Message-ID: <1406807898-5927-25-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B447D2654CD
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:44 +0200 (CEST)
In-Reply-To: <1406807898-5927-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8978.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 28ef46c91f62..ee2ba574952b 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -736,16 +736,16 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface_ctl |= 0x20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface_ctl |= 0x40;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface_ctl |= 0x60;
 		break;
 	}
@@ -817,8 +817,8 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 			wm8978->sysclk == WM8978_MCLK ?
 			", consider using PLL" : "");
 
-	dev_dbg(codec->dev, "%s: fmt %d, rate %u, MCLK divisor #%d\n", __func__,
-		params_format(params), params_rate(params), best);
+	dev_dbg(codec->dev, "%s: width %d, rate %u, MCLK divisor #%d\n", __func__,
+		params_width(params), params_rate(params), best);
 
 	/* MCLK divisor mask = 0xe0 */
 	snd_soc_update_bits(codec, WM8978_CLOCKING, 0xe0, best << 5);
-- 
2.0.1
