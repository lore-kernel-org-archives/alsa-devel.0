From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] ASoC: max98090: Replace direct
	snd_soc_codec dapm field access
Date: Thu, 14 May 2015 11:20:01 +0200
Message-ID: <1431595203-12851-9-git-send-email-lars@metafoo.de>
References: <1431595203-12851-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-163.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id BB61C2606EB
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 11:20:22 +0200 (CEST)
In-Reply-To: <1431595203-12851-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, Sven Brandau <brandau@gmx.de>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jerry Wong <jerry.wong@maximintegrated.com>, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and all other
manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 5a0bd8a..c230626 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1500,7 +1500,7 @@ static const struct snd_soc_dapm_route max98091_dapm_routes[] = {
 static int max98090_add_widgets(struct snd_soc_codec *codec)
 {
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	snd_soc_add_codec_controls(codec, max98090_snd_controls,
 		ARRAY_SIZE(max98090_snd_controls));
@@ -1798,16 +1798,17 @@ static int max98090_set_bias_level(struct snd_soc_codec *codec,
 		 * away from ON. Disable the clock in that case, otherwise
 		 * enable it.
 		 */
-		if (!IS_ERR(max98090->mclk)) {
-			if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
-				clk_disable_unprepare(max98090->mclk);
-			else
-				clk_prepare_enable(max98090->mclk);
-		}
+		if (IS_ERR(max98090->mclk))
+			break;
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON)
+			clk_disable_unprepare(max98090->mclk);
+		else
+			clk_prepare_enable(max98090->mclk);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			ret = regcache_sync(max98090->regmap);
 			if (ret != 0) {
 				dev_err(codec->dev,
-- 
1.8.0
