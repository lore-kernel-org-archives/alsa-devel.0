From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on
	qcom/apq8016_sbc" to the asoc tree
Date: Tue,  5 Dec 2017 12:46:17 +0000 (GMT)
Message-ID: <20171205124617.8D29C44006B@finisterre.ee.mobilebroadband>
References: <87zi6xu7y3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B84266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:46:19 +0100 (CET)
In-Reply-To: <87zi6xu7y3.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use rtd->codec on qcom/apq8016_sbc

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 96e1b9eef4e53a1fea2b889881ca293d153fe0d1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:24:13 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on qcom/apq8016_sbc

rtd->codec will be removed soon.
rtd->codec = rtd->codec_dai->codec, thus,
we can use rtd->codec_dai->component instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 03851fedd1e2..704428735e3c 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -43,7 +43,7 @@ struct apq8016_sbc_data {
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
@@ -102,15 +102,15 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 	for (i = 0 ; i < dai_link->num_codecs; i++) {
 		struct snd_soc_dai *dai = rtd->codec_dais[i];
 
-		codec = dai->codec;
+		component = dai->component;
 		/* Set default mclk for internal codec */
-		rval = snd_soc_codec_set_sysclk(codec, 0, 0, DEFAULT_MCLK_RATE,
+		rval = snd_soc_component_set_sysclk(component, 0, 0, DEFAULT_MCLK_RATE,
 				       SND_SOC_CLOCK_IN);
 		if (rval != 0 && rval != -ENOTSUPP) {
 			dev_warn(card->dev, "Failed to set mclk: %d\n", rval);
 			return rval;
 		}
-		rval = snd_soc_codec_set_jack(codec, &pdata->jack, NULL);
+		rval = snd_soc_component_set_jack(component, &pdata->jack, NULL);
 		if (rval != 0 && rval != -ENOTSUPP) {
 			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
 			return rval;
-- 
2.15.0
