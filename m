From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: address dai link array
	entries by enum" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:45 +0900
Message-ID: <E1acBGH-0003F4-L5@finisterre>
References: <1451934551-21333-3-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F24E261469
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:58 +0100 (CET)
In-Reply-To: <1451934551-21333-3-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: address dai link array entries by enum

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

>From 05f5afd3f0d915537b67d3cfcb464e6836a65caf Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 2 Mar 2016 15:49:06 +0100
Subject: [PATCH] ASoC: mediatek: address dai link array entries by enum

This should be more robust to future changes than adressing
array entries by index number.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 50ba538eccb3..5c4c58c69c51 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -131,10 +131,17 @@ static struct snd_soc_dai_link_component mt8173_rt5650_rt5676_codecs[] = {
 	},
 };
 
+enum {
+	DAI_LINK_PLAYBACK,
+	DAI_LINK_CAPTURE,
+	DAI_LINK_CODEC_I2S,
+	DAI_LINK_INTERCODEC
+};
+
 /* Digital audio interface glue - connects codec <---> CPU */
 static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 	/* Front End DAI links */
-	{
+	[DAI_LINK_PLAYBACK] = {
 		.name = "rt5650_rt5676 Playback",
 		.stream_name = "rt5650_rt5676 Playback",
 		.cpu_dai_name = "DL1",
@@ -144,7 +151,7 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.dynamic = 1,
 		.dpcm_playback = 1,
 	},
-	{
+	[DAI_LINK_CAPTURE] = {
 		.name = "rt5650_rt5676 Capture",
 		.stream_name = "rt5650_rt5676 Capture",
 		.cpu_dai_name = "VUL",
@@ -156,7 +163,7 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 	},
 
 	/* Back End DAI links */
-	{
+	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
 		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
@@ -170,7 +177,8 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
-	{ /* rt5676 <-> rt5650 intercodec link: Sets rt5676 I2S2 as master */
+	/* rt5676 <-> rt5650 intercodec link: Sets rt5676 I2S2 as master */
+	[DAI_LINK_INTERCODEC] = {
 		.name = "rt5650_rt5676 intercodec",
 		.stream_name = "rt5650_rt5676 intercodec",
 		.cpu_dai_name = "snd-soc-dummy-dai",
@@ -240,7 +248,7 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	mt8173_rt5650_rt5676_codec_conf[0].of_node =
 		mt8173_rt5650_rt5676_codecs[1].of_node;
 
-	mt8173_rt5650_rt5676_dais[3].codec_of_node =
+	mt8173_rt5650_rt5676_dais[DAI_LINK_INTERCODEC].codec_of_node =
 		mt8173_rt5650_rt5676_codecs[1].of_node;
 
 	card->dev = &pdev->dev;
-- 
2.7.0
