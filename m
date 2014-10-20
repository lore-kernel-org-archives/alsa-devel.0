From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/12] ASoC: sta350: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:37 +0200
Message-ID: <1413795399-29952-10-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A89D260567
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:50 +0200 (CEST)
In-Reply-To: <1413795399-29952-1-git-send-email-lars@metafoo.de>
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
Cc: Johannes Stezenbach <js@sig21.net>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Sven Brandau <brandau@gmx.de>, alsa-devel@alsa-project.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sta350.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index cc97dd5..bda2ee1 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -912,23 +912,6 @@ static struct snd_soc_dai_driver sta350_dai = {
 	.ops = &sta350_dai_ops,
 };
 
-#ifdef CONFIG_PM
-static int sta350_suspend(struct snd_soc_codec *codec)
-{
-	sta350_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int sta350_resume(struct snd_soc_codec *codec)
-{
-	sta350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define sta350_suspend NULL
-#define sta350_resume NULL
-#endif
-
 static int sta350_probe(struct snd_soc_codec *codec)
 {
 	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
@@ -1065,7 +1048,6 @@ static int sta350_remove(struct snd_soc_codec *codec)
 {
 	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
 
-	sta350_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
 
 	return 0;
@@ -1074,9 +1056,8 @@ static int sta350_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver sta350_codec = {
 	.probe =		sta350_probe,
 	.remove =		sta350_remove,
-	.suspend =		sta350_suspend,
-	.resume =		sta350_resume,
 	.set_bias_level =	sta350_set_bias_level,
+	.suspend_bias_off =	true,
 	.controls =		sta350_snd_controls,
 	.num_controls =		ARRAY_SIZE(sta350_snd_controls),
 	.dapm_widgets =		sta350_dapm_widgets,
-- 
1.8.0
