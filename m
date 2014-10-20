From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/12] ASoC: max98088: Cleanup manual bias
	level transitions
Date: Mon, 20 Oct 2014 10:56:33 +0200
Message-ID: <1413795399-29952-6-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id DAEF62606DE
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:45 +0200 (CEST)
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

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98088.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 2cd3e54..bb892b3 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1887,25 +1887,6 @@ static void max98088_handle_pdata(struct snd_soc_codec *codec)
                max98088_handle_eq_pdata(codec);
 }
 
-#ifdef CONFIG_PM
-static int max98088_suspend(struct snd_soc_codec *codec)
-{
-       max98088_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-       return 0;
-}
-
-static int max98088_resume(struct snd_soc_codec *codec)
-{
-       max98088_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-       return 0;
-}
-#else
-#define max98088_suspend NULL
-#define max98088_resume NULL
-#endif
-
 static int max98088_probe(struct snd_soc_codec *codec)
 {
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
@@ -1946,9 +1927,6 @@ static int max98088_probe(struct snd_soc_codec *codec)
 
        snd_soc_write(codec, M98088_REG_51_PWR_SYS, M98088_PWRSV);
 
-       /* initialize registers cache to hardware default */
-       max98088_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
        snd_soc_write(codec, M98088_REG_0F_IRQ_ENABLE, 0x00);
 
        snd_soc_write(codec, M98088_REG_22_MIX_DAC,
@@ -1974,7 +1952,6 @@ static int max98088_remove(struct snd_soc_codec *codec)
 {
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
 
-       max98088_set_bias_level(codec, SND_SOC_BIAS_OFF);
        kfree(max98088->eq_texts);
 
        return 0;
@@ -1983,9 +1960,9 @@ static int max98088_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
 	.probe   = max98088_probe,
 	.remove  = max98088_remove,
-	.suspend = max98088_suspend,
-	.resume  = max98088_resume,
 	.set_bias_level = max98088_set_bias_level,
+	.suspend_bias_off = true,
+
 	.controls = max98088_snd_controls,
 	.num_controls = ARRAY_SIZE(max98088_snd_controls),
 	.dapm_widgets = max98088_dapm_widgets,
-- 
1.8.0
