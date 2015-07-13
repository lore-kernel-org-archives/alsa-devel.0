From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: max98925: Remove control_data
	initialization
Date: Mon, 13 Jul 2015 19:40:52 +0200
Message-ID: <1436809252-10112-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-249.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id A3489265005
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 07:33:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anish Kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

The control_data field of the snd_soc_codec struct is no longer used by
ASoC drivers using standard regmap IO.

There is no need to initialize the field to point to the drivers regmap
struct, so drop that.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98925.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index aad6642..eddf8bc 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -523,7 +523,6 @@ static int max98925_probe(struct snd_soc_codec *codec)
 	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
 
 	max98925->codec = codec;
-	codec->control_data = max98925->regmap;
 	regmap_write(max98925->regmap, MAX98925_GLOBAL_ENABLE, 0x00);
 	/* It's not the default but we need to set DAI_DLY */
 	regmap_write(max98925->regmap,
-- 
2.1.4
