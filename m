From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: adav80x: Replace w->codec with
	snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 09:37:34 +0100
Message-ID: <1416213456-5987-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 418C3261522
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:37:38 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adav80x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index ce3cdca..b67480f 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -212,7 +212,7 @@ static const struct snd_soc_dapm_widget adav80x_dapm_widgets[] = {
 static int adav80x_dapm_sysclk_check(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = source->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	const char *clk;
 
@@ -236,7 +236,7 @@ static int adav80x_dapm_sysclk_check(struct snd_soc_dapm_widget *source,
 static int adav80x_dapm_pll_check(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = source->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
 	return adav80x->pll_src == ADAV80X_PLL_SRC_XTAL;
-- 
1.8.0
