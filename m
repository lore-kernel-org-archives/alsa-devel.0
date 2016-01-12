From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v3 2/7] ASoC: mediatek: address dai link array entries by enum
Date: Tue, 12 Jan 2016 16:38:11 +0100
Message-ID: <1452613096-8116-3-git-send-email-p.zabel@pengutronix.de>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1452613096-8116-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This should be more robust to future changes than adressing
array entries by index number.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
2.6.4
