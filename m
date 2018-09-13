From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: es8328: Fix fall-through annotations
Date: Thu, 13 Sep 2018 14:08:15 -0500
Message-ID: <20180913190815.GA10487@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway21.websitewelcome.com (gateway21.websitewelcome.com
 [192.185.45.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 739882673F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 21:08:49 +0200 (CEST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id 3480E4010D6A5
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 14:08:48 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/es8328.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 4b5827d..04a3aa7 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -566,14 +566,14 @@ static int es8328_set_sysclk(struct snd_soc_dai *codec_dai,
 		break;
 	case 22579200:
 		mclkdiv2 = 1;
-		/* fallthru */
+		/* fall through */
 	case 11289600:
 		es8328->sysclk_constraints = &constraints_11289;
 		es8328->mclk_ratios = ratios_11289;
 		break;
 	case 24576000:
 		mclkdiv2 = 1;
-		/* fallthru */
+		/* fall through */
 	case 12288000:
 		es8328->sysclk_constraints = &constraints_12288;
 		es8328->mclk_ratios = ratios_12288;
-- 
2.7.4
