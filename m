From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: snappercl15: Convert to table based DAPM
	setup
Date: Mon,  3 Mar 2014 08:10:35 +0100
Message-ID: <1393830635-17279-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B5E5265470
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:10:10 +0100 (CET)
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
Cc: Ryan Mallon <ryan@bluewatersys.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes.  This on one hand
makes the code a bit shorter and cleaner and on the other hand the board level
DAPM elements get registered in the card's DAPM context rather than in the
CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/cirrus/snappercl15.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 29238a7..bdc88e5 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -65,18 +65,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	return 0;
-}
-
 static struct snd_soc_dai_link snappercl15_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "AIC23",
@@ -84,7 +72,6 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.codec_dai_name	= "tlv320aic23-hifi",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	= "ep93xx-i2s",
-	.init		= snappercl15_tlv320aic23_init,
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
@@ -95,6 +82,11 @@ static struct snd_soc_card snd_soc_snappercl15 = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &snappercl15_dai,
 	.num_links	= 1,
+
+	.dapm_widgets = tlv320aic23_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int snappercl15_probe(struct platform_device *pdev)
-- 
1.8.0
