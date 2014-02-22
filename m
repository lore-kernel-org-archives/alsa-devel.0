From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: sta32x: Fix cache sync
Date: Sat, 22 Feb 2014 18:27:17 +0100
Message-ID: <1393090037-8824-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-129.synserver.de
 [212.40.185.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B38261B0C
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:27:21 +0100 (CET)
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
Cc: Johannes Stezenbach <js@sig21.net>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

codec->control_data contains a pointer to the regmap struct of the device, not
to the device private data. Use snd_soc_codec_get_drvdata() instead.

The issue was introduced in commit 29fdf4fbbe ("ASoC: sta32x: Convert to
regmap").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sta32x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 42c5b45..ea78c17 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -331,7 +331,7 @@ static int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
 
 static int sta32x_cache_sync(struct snd_soc_codec *codec)
 {
-	struct sta32x_priv *sta32x = codec->control_data;
+	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	unsigned int mute;
 	int rc;
 
-- 
1.8.0
