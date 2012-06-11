From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: wm8996: Remove spurious
	regulator_bulk_free()
Date: Mon, 11 Jun 2012 19:55:34 +0800
Message-ID: <1339415740-2376-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0125C24350
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:01 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're using demv_regulator_bulk_get() so don't need to manually free and
this is in the CODEC driver not the I2C driver anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index f24989f..e0bbe646 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2873,7 +2873,6 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
 		regulator_unregister_notifier(wm8996->supplies[i].consumer,
 					      &wm8996->disable_nb[i]);
-	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
 	return 0;
 }
-- 
1.7.10
