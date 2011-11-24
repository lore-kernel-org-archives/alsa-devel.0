From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Staticise non-exported symbols in sta32x
Date: Thu, 24 Nov 2011 17:33:26 +0000
Message-ID: <1322156006-32065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 028AA103E65
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:33:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sta32x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index e2b1cde..edcbeef 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -265,7 +265,7 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
+static int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
 {
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	unsigned int cfud;
@@ -290,7 +290,7 @@ int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
 	return 0;
 }
 
-int sta32x_cache_sync(struct snd_soc_codec *codec)
+static int sta32x_cache_sync(struct snd_soc_codec *codec)
 {
 	unsigned int mute;
 	int rc;
-- 
1.7.7.3
