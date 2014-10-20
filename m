From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/12] ASoC: max9850: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:35 +0200
Message-ID: <1413795399-29952-8-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id AF1062606E2
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:47 +0200 (CEST)
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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max9850.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 4fdf5aa..10f8e47 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -291,25 +291,6 @@ static struct snd_soc_dai_driver max9850_dai = {
 	.ops = &max9850_dai_ops,
 };
 
-#ifdef CONFIG_PM
-static int max9850_suspend(struct snd_soc_codec *codec)
-{
-	max9850_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int max9850_resume(struct snd_soc_codec *codec)
-{
-	max9850_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define max9850_suspend NULL
-#define max9850_resume NULL
-#endif
-
 static int max9850_probe(struct snd_soc_codec *codec)
 {
 	/* enable zero-detect */
@@ -324,9 +305,8 @@ static int max9850_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
 	.probe =	max9850_probe,
-	.suspend =	max9850_suspend,
-	.resume =	max9850_resume,
 	.set_bias_level = max9850_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = max9850_controls,
 	.num_controls = ARRAY_SIZE(max9850_controls),
-- 
1.8.0
