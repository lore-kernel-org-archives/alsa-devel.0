From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: refactor soc_link_dai_widgets()"
	to the asoc tree
Date: Wed, 18 Nov 2015 13:13:36 +0000
Message-ID: <E1Zz2YK-0006CJ-62@debutante>
References: <1447091401-24298-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA67260A5D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:13:49 +0100 (CET)
In-Reply-To: <1447091401-24298-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: refactor soc_link_dai_widgets()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3de7c420a2b1737844d893cbfc689a9b2b5528cd Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 9 Nov 2015 23:19:58 +0530
Subject: [PATCH] ASoC: core: refactor soc_link_dai_widgets()

In soc_link_dai_widgets() we refer to local widget variables as
playback/capture_widget, but they are really sink/source widgets,
so change the names accordingly

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24b096066a07..d5e0bcbafb70 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1283,35 +1283,35 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dapm_widget *play_w, *capture_w;
+	struct snd_soc_dapm_widget *sink, *source;
 	int ret;
 
 	if (rtd->num_codecs > 1)
 		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
 
 	/* link the DAI widgets */
-	play_w = codec_dai->playback_widget;
-	capture_w = cpu_dai->capture_widget;
-	if (play_w && capture_w) {
+	sink = codec_dai->playback_widget;
+	source = cpu_dai->capture_widget;
+	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-					   dai_link->num_params, capture_w,
-					   play_w);
+					   dai_link->num_params,
+					   source, sink);
 		if (ret != 0) {
 			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
+				sink->name, source->name, ret);
 			return ret;
 		}
 	}
 
-	play_w = cpu_dai->playback_widget;
-	capture_w = codec_dai->capture_widget;
-	if (play_w && capture_w) {
+	sink = cpu_dai->playback_widget;
+	source = codec_dai->capture_widget;
+	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-					   dai_link->num_params, capture_w,
-					   play_w);
+					   dai_link->num_params,
+					   source, sink);
 		if (ret != 0) {
 			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
+				sink->name, source->name, ret);
 			return ret;
 		}
 	}
-- 
2.6.2
