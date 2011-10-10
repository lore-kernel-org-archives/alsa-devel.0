From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/9] ASoC: osk5912: Let core to deal with
	the DAPM widgets
Date: Mon, 10 Oct 2011 15:34:11 +0300
Message-ID: <1318250056-26437-5-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 6731D24516
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:34:58 +0200 (CEST)
Received: by mail-gy0-f176.google.com with SMTP id 15so6996975gyc.21
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:34:57 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes via the snd_soc_card struct
to core. With this change we do not need the init function
since the remaining snd_soc_dapm_enable_pin calls are
not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/osk5912.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 18f8a2d..db91cca 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -91,25 +91,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int osk_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* Add osk5912 specific widgets */
-	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-
-	/* Set up osk5912 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line In");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link osk_dai = {
 	.name = "TLV320AIC23",
@@ -120,7 +101,6 @@ static struct snd_soc_dai_link osk_dai = {
 	.codec_name = "tlv320aic23-codec",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-	.init = osk_tlv320aic23_init,
 	.ops = &osk_ops,
 };
 
@@ -129,6 +109,11 @@ static struct snd_soc_card snd_soc_card_osk = {
 	.name = "OSK5912",
 	.dai_link = &osk_dai,
 	.num_links = 1,
+
+	.dapm_widgets = tlv320aic23_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *osk_snd_device;
-- 
1.7.7
