From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: adau1373: Replace w->codec with
	snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 09:37:35 +0100
Message-ID: <1416213456-5987-2-git-send-email-lars@metafoo.de>
References: <1416213456-5987-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CCDF26153F
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:37:41 +0100 (CET)
In-Reply-To: <1416213456-5987-1-git-send-email-lars@metafoo.de>
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
 sound/soc/codecs/adau1373.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 7c784ad..783dcb5 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -551,7 +551,7 @@ static const struct snd_kcontrol_new adau1373_drc_controls[] = {
 static int adau1373_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int pll_id = w->name[3] - '1';
 	unsigned int val;
@@ -823,7 +823,7 @@ static const struct snd_soc_dapm_widget adau1373_dapm_widgets[] = {
 static int adau1373_check_aif_clk(struct snd_soc_dapm_widget *source,
 	struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = source->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int dai;
 	const char *clk;
@@ -844,7 +844,7 @@ static int adau1373_check_aif_clk(struct snd_soc_dapm_widget *source,
 static int adau1373_check_src(struct snd_soc_dapm_widget *source,
 	struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = source->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int dai;
 
-- 
1.8.0
