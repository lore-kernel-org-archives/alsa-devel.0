From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs42l56: Remove unneeded
 regulator_bulk_free call in cs42l56_remove
Date: Thu, 28 Aug 2014 17:55:20 +0800
Message-ID: <1409219720.21395.5.camel@phoenix>
References: <1409219678.21395.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id AF245268E39
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 11:55:26 +0200 (CEST)
Received: by mail-ie0-f173.google.com with SMTP id lx4so647688iec.4
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 02:55:25 -0700 (PDT)
In-Reply-To: <1409219678.21395.4.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The regulator_bulk_free() call is not required because current code is using
devm_regulator_bulk_get().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l56.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index c766a5a..5a2d732 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1175,11 +1175,8 @@ static int cs42l56_probe(struct snd_soc_codec *codec)
 
 static int cs42l56_remove(struct snd_soc_codec *codec)
 {
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
-
 	cs42l56_free_beep(codec);
 	cs42l56_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(cs42l56->supplies), cs42l56->supplies);
 
 	return 0;
 }
-- 
1.9.1
