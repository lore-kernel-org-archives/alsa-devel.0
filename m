From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 31/35] ASoC: wm8993: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:14 +0100
Message-ID: <1406807898-5927-31-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFCA9265274
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:42 +0200 (CEST)
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
 sound/soc/codecs/wm8993.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index f825dc04ebe1..93b14eda355a 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1214,19 +1214,19 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 			wm8993->tdm_slots, wm8993->tdm_width);
 		wm8993->bclk *= wm8993->tdm_width * wm8993->tdm_slots;
 	} else {
-		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S16_LE:
+		switch (params_width(params)) {
+		case 16:
 			wm8993->bclk *= 16;
 			break;
-		case SNDRV_PCM_FORMAT_S20_3LE:
+		case 20:
 			wm8993->bclk *= 20;
 			aif1 |= 0x8;
 			break;
-		case SNDRV_PCM_FORMAT_S24_LE:
+		case 24:
 			wm8993->bclk *= 24;
 			aif1 |= 0x10;
 			break;
-		case SNDRV_PCM_FORMAT_S32_LE:
+		case 32:
 			wm8993->bclk *= 32;
 			aif1 |= 0x18;
 			break;
-- 
2.0.1
