From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: tlv320aic26: Remove noisy print
Date: Fri, 16 Aug 2013 12:32:04 +0100
Message-ID: <1376652725-26857-2-git-send-email-broonie@kernel.org>
References: <1376652725-26857-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BD8D261694
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 13:32:18 +0200 (CEST)
In-Reply-To: <1376652725-26857-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index a4f9360..93cf692 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -365,8 +365,6 @@ static int aic26_probe(struct snd_soc_codec *codec)
 
 	aic26->codec = codec;
 
-	dev_info(codec->dev, "Probing AIC26 SoC CODEC driver\n");
-
 	/* Reset the codec to power on defaults */
 	snd_soc_write(codec, AIC26_REG_RESET, 0xBB00);
 
-- 
1.8.4.rc2
