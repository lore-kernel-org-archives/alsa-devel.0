From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 09/35] ASoC: wm8737: Convert to params_width()
Date: Thu, 31 Jul 2014 12:57:52 +0100
Message-ID: <1406807898-5927-9-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A53C2651B9
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:34 +0200 (CEST)
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
 sound/soc/codecs/wm8737.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index b27f26cdc049..744a422ecb05 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -367,16 +367,16 @@ static int wm8737_hw_params(struct snd_pcm_substream *substream,
 
 	clocking |= coeff_div[i].usb | (coeff_div[i].sr << WM8737_SR_SHIFT);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		af |= 0x8;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		af |= 0x10;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		af |= 0x18;
 		break;
 	default:
-- 
2.0.1
