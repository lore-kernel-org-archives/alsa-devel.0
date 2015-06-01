From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 29/47] ASoC: wm8960: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:48 +0200
Message-ID: <1433146266-1599-29-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B0D261585
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:25 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8960.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 6fa832b..edd34db 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -445,7 +445,7 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	struct wm8960_data *pdata = &wm8960->pdata;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_dapm_widget *w;
 
 	snd_soc_dapm_new_controls(dapm, wm8960_dapm_widgets,
@@ -476,7 +476,7 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	 * and save the result.
 	 */
 	list_for_each_entry(w, &codec->component.card->widgets, list) {
-		if (w->dapm != &codec->dapm)
+		if (w->dapm != dapm)
 			continue;
 		if (strcmp(w->name, "LOUT1 PGA") == 0)
 			wm8960->lout1 = w;
@@ -627,7 +627,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		switch (codec->dapm.bias_level) {
+		switch (snd_soc_codec_get_bias_level(codec)) {
 		case SND_SOC_BIAS_STANDBY:
 			if (!IS_ERR(wm8960->mclk)) {
 				ret = clk_prepare_enable(wm8960->mclk);
@@ -655,7 +655,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			regcache_sync(wm8960->regmap);
 
 			/* Enable anti-pop features */
@@ -705,7 +705,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		switch (codec->dapm.bias_level) {
+		switch (snd_soc_codec_get_bias_level(codec)) {
 		case SND_SOC_BIAS_STANDBY:
 			/* Enable anti pop mode */
 			snd_soc_update_bits(codec, WM8960_APOP1,
@@ -776,7 +776,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		switch (codec->dapm.bias_level) {
+		switch (snd_soc_codec_get_bias_level(codec)) {
 		case SND_SOC_BIAS_PREPARE:
 			/* Disable HP discharge */
 			snd_soc_update_bits(codec, WM8960_APOP2,
-- 
2.1.4
