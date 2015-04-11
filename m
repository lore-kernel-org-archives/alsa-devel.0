From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: n810: Automatically disconnect
	non-connected pins
Date: Sat, 11 Apr 2015 10:47:58 +0200
Message-ID: <1428742078-9704-2-git-send-email-lars@metafoo.de>
References: <1428742078-9704-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BA5F32612C7
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 10:48:02 +0200 (CEST)
In-Reply-To: <1428742078-9704-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

All CODEC input and output widgets are either in the DAPM routing table or
manually marked as non-connected. This means the card is fully routed and we
can let the core take care of disconnecting non-connected pins.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/n810.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 617eae3..dcb5336 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -254,24 +254,6 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 		     n810_get_input, n810_set_input),
 };
 
-static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* Not connected */
-	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(dapm, "HPLCOM");
-	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
-	snd_soc_dapm_nc_pin(dapm, "MIC3L");
-	snd_soc_dapm_nc_pin(dapm, "MIC3R");
-	snd_soc_dapm_nc_pin(dapm, "LINE1R");
-	snd_soc_dapm_nc_pin(dapm, "LINE2L");
-	snd_soc_dapm_nc_pin(dapm, "LINE2R");
-
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link n810_dai = {
 	.name = "TLV320AIC33",
@@ -282,7 +264,6 @@ static struct snd_soc_dai_link n810_dai = {
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-	.init = n810_aic33_init,
 	.ops = &n810_ops,
 };
 
@@ -299,6 +280,7 @@ static struct snd_soc_card snd_soc_n810 = {
 	.num_dapm_widgets = ARRAY_SIZE(aic33_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static struct platform_device *n810_snd_device;
-- 
1.8.0
