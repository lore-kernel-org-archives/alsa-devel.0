From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: pcm1681: Improve the logic for
 de-emphasis sampling rate selection
Date: Thu, 23 Jul 2015 23:23:35 +0800
Message-ID: <1437665015.20606.6.camel@ingics.com>
References: <1437664946.20606.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E922657DD
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:23:47 +0200 (CEST)
Received: by pdbbh15 with SMTP id bh15so113042081pdb.1
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 08:23:45 -0700 (PDT)
In-Reply-To: <1437664946.20606.5.camel@ingics.com>
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

Slightly improve the logic for de-emphasis sampling rate selection by break
out the loop if the rate is matched.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/pcm1681.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 1011142..5832523 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -95,17 +95,22 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 	int i = 0, val = -1, enable = 0;
 
-	if (priv->deemph)
-		for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++)
-			if (pcm1681_deemph[i] == priv->rate)
+	if (priv->deemph) {
+		for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++) {
+			if (pcm1681_deemph[i] == priv->rate) {
 				val = i;
+				break;
+			}
+		}
+	}
 
 	if (val != -1) {
 		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
 				   PCM1681_DEEMPH_RATE_MASK, val << 3);
 		enable = 1;
-	} else
+	} else {
 		enable = 0;
+	}
 
 	/* enable/disable deemphasis functionality */
 	return regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
-- 
2.1.0
