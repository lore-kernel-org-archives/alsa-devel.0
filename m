From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas5086: Improve the logic for
	de-emphasis sampling rate selection" to the asoc tree
Date: Thu, 23 Jul 2015 16:47:27 +0100
Message-ID: <E1ZIIiV-0008BR-F2@debutante>
References: <1437664416.20606.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C653F26128B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:47:37 +0200 (CEST)
In-Reply-To: <1437664416.20606.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Daniel Mack <daniel@zonque.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas5086: Improve the logic for de-emphasis sampling rate selection

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

>From 9425e9d8c77dd9f40c5f199127a63be2e2b7c1f4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 23:13:36 +0800
Subject: [PATCH] ASoC: tas5086: Improve the logic for de-emphasis sampling
 rate selection

Slightly improve the logic for de-emphasis sampling rate selection by break
out the loop if the rate is matched.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5086.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 32942bed34b1..16a6c6443aa8 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -266,10 +266,14 @@ static int tas5086_set_deemph(struct snd_soc_codec *codec)
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int i, val = 0;
 
-	if (priv->deemph)
-		for (i = 0; i < ARRAY_SIZE(tas5086_deemph); i++)
-			if (tas5086_deemph[i] == priv->rate)
+	if (priv->deemph) {
+		for (i = 0; i < ARRAY_SIZE(tas5086_deemph); i++) {
+			if (tas5086_deemph[i] == priv->rate) {
 				val = i;
+				break;
+			}
+		}
+	}
 
 	return regmap_update_bits(priv->regmap, TAS5086_SYS_CONTROL_1,
 				  TAS5086_DEEMPH_MASK, val);
-- 
2.1.4
