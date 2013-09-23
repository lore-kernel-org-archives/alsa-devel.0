From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/6] ASoC: tlv320aic3x: Don't reference cache
	datastructure directly
Date: Tue, 24 Sep 2013 00:12:47 +0100
Message-ID: <1379977968-25982-5-git-send-email-broonie@kernel.org>
References: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B59A2261629
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:13:03 +0200 (CEST)
In-Reply-To: <1379977968-25982-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Rather than referencing the cache directly read back the values we are
going to restore, supporting refactoring to use regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic3x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 16fc74c..83e7d85 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1068,14 +1068,14 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 static int aic3x_init_3007(struct snd_soc_codec *codec)
 {
-	u8 tmp1, tmp2, *cache = codec->reg_cache;
+	unsigned int tmp1, tmp2;
 
 	/*
 	 * There is no need to cache writes to undocumented page 0xD but
 	 * respective page 0 register cache entries must be preserved
 	 */
-	tmp1 = cache[0xD];
-	tmp2 = cache[0x8];
+	tmp1 = snd_soc_read(codec, 0xD);
+	tmp2 = snd_soc_read(codec, 0x8);
 	/* Class-D speaker driver init; datasheet p. 46 */
 	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x0D);
 	snd_soc_write(codec, 0xD, 0x0D);
@@ -1083,8 +1083,9 @@ static int aic3x_init_3007(struct snd_soc_codec *codec)
 	snd_soc_write(codec, 0x8, 0x5D);
 	snd_soc_write(codec, 0x8, 0x5C);
 	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x00);
-	cache[0xD] = tmp1;
-	cache[0x8] = tmp2;
+
+	snd_soc_write(codec, 0xD, tmp1);
+	snd_soc_write(codec, 0x8, tmp2);
 
 	return 0;
 }
-- 
1.8.4.rc3
