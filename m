From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm1681: Improve the logic for
	de-emphasis sampling rate selection" to the asoc tree
Date: Fri, 24 Jul 2015 12:31:15 +0100
Message-ID: <E1ZIbC7-00033a-E5@debutante>
References: <1437665015.20606.6.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1004A2605A1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 13:31:23 +0200 (CEST)
In-Reply-To: <1437665015.20606.6.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm1681: Improve the logic for de-emphasis sampling rate selection

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 48f403be3eb9b603cfaf946ca7a0c76272750469 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 23:23:35 +0800
Subject: [PATCH] ASoC: pcm1681: Improve the logic for de-emphasis sampling
 rate selection

Slightly improve the logic for de-emphasis sampling rate selection by break
out the loop if the rate is matched.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1681.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index e7ba557979cb..490970e5ab8c 100644
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
2.1.4
