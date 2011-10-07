From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: am3517evm: Let core to deal with the
	DAPM widgets
Date: Fri,  7 Oct 2011 11:46:59 +0300
Message-ID: <1317977219-14792-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA29103B35
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 10:46:47 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so7517760bkb.27
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 01:46:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes via the snd_soc_card struct
to core. With this change we do not need the init function
since the remaining snd_soc_dapm_enable_pin calls are
not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/am3517evm.c |   28 +++++-----------------------
 1 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index f9b995f..8da55e9 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -90,28 +90,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic In"},
 };
 
-static int am3517evm_aic23_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* Add am3517-evm specific widgets */
-	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-
-	/* Set up davinci-evm specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Line Out");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
-	snd_soc_dapm_enable_pin(dapm, "Mic In");
-
-	snd_soc_dapm_new_widgets(dapm);
-
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link am3517evm_dai = {
 	.name = "TLV320AIC23",
@@ -122,7 +100,6 @@ static struct snd_soc_dai_link am3517evm_dai = {
 	.codec_name = "tlv320aic23-codec.2-001a",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-	.init = am3517evm_aic23_init,
 	.ops = &am3517evm_ops,
 };
 
@@ -131,6 +108,11 @@ static struct snd_soc_card snd_soc_am3517evm = {
 	.name = "am3517evm",
 	.dai_link = &am3517evm_dai,
 	.num_links = 1,
+
+	.dapm_widgets = tlv320aic23_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *am3517evm_snd_device;
-- 
1.7.7
