From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 2/9] ASoC: mediatek: address dai link array
	entries by enum
Date: Wed,  2 Mar 2016 15:49:06 +0100
Message-ID: <1456930153-11853-3-git-send-email-p.zabel@pengutronix.de>
References: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9F5DA265055
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 15:49:23 +0100 (CET)
In-Reply-To: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

This should be more robust to future changes than adressing
array entries by index number.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 50ba538..5c4c58c 100644
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
