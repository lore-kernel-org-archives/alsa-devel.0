From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/9] ASoC: am3517evm: Let core to deal with
	the DAPM widgets
Date: Mon, 10 Oct 2011 15:34:09 +0300
Message-ID: <1318250056-26437-3-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id C018724516
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:34:55 +0200 (CEST)
Received: by mail-gy0-f181.google.com with SMTP id 10so6262708gyd.12
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:34:54 -0700 (PDT)
In-Reply-To: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes via the snd_soc_card struct
to core. With this change we do not need the init function
since the remaining snd_soc_dapm_enable_pin calls are
not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/am3517evm.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index f5a4d65..8da55e9 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -90,26 +90,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
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
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link am3517evm_dai = {
 	.name = "TLV320AIC23",
@@ -120,7 +100,6 @@ static struct snd_soc_dai_link am3517evm_dai = {
 	.codec_name = "tlv320aic23-codec.2-001a",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-	.init = am3517evm_aic23_init,
 	.ops = &am3517evm_ops,
 };
 
@@ -129,6 +108,11 @@ static struct snd_soc_card snd_soc_am3517evm = {
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
