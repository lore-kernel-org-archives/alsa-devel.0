From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: pcm1681: Fix setting de-emphasis
 sampling rate selection
Date: Thu, 23 Jul 2015 23:22:26 +0800
Message-ID: <1437664946.20606.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 3061D2606F9
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:22:33 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so159107316pac.3
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 08:22:32 -0700 (PDT)
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
Cc: Marek Belisko <marek.belisko@streamunlimited.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The de-emphasis sampling rate selection is controlled by BIT[3:4] of
PCM1681_DEEMPH_CONTROL register. Do proper left shift to set it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/pcm1681.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index b2c990f..1011142 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -102,7 +102,7 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
 
 	if (val != -1) {
 		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
-					PCM1681_DEEMPH_RATE_MASK, val);
+				   PCM1681_DEEMPH_RATE_MASK, val << 3);
 		enable = 1;
 	} else
 		enable = 0;
-- 
2.1.0
