From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max98925: Fix mask for setting DAI
	invert mode
Date: Tue, 26 May 2015 20:35:08 +0800
Message-ID: <1432643708.30725.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A617A2619F0
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:35:14 +0200 (CEST)
Received: by paza2 with SMTP id a2so82750217paz.3
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 05:35:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Anish kumar <anish.kumar@maximintegrated.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ralph Birt <rdbirt@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The M98925_DAI_WCI_MASK bit is not updated with current code.
To properly set the DAI invert mode, the mask should be
M98925_DAI_BCI_MASK | M98925_DAI_WCI_MASK.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 9b5a17d..aad6642 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -346,7 +346,7 @@ static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	regmap_update_bits(max98925->regmap, MAX98925_FORMAT,
-			M98925_DAI_BCI_MASK, invert);
+			M98925_DAI_BCI_MASK | M98925_DAI_WCI_MASK, invert);
 	return 0;
 }
 
-- 
2.1.0
