From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: rx51: Automatically disconnect
	non-connected pins
Date: Thu,  4 Jun 2015 16:13:51 +0200
Message-ID: <1433427231-21756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EC452665A3
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 16:14:03 +0200 (CEST)
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

According to the schematics the external speaker is differential, so the
HPLCOM and HPRCOM pins of the CODEC should be connected to it.

Otherwise the routing looks complete, so add the missing routes and set the
fully_routed flag of the card instead of manually marking the unused inputs
and outputs as not connected. This makes the code a bit shorter and
cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/rx51.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index fded993..3bebfb1 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -245,6 +245,8 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPLOUT"},
 	{"Ext Spk", NULL, "HPROUT"},
+	{"Ext Spk", NULL, "HPLCOM"},
+	{"Ext Spk", NULL, "HPRCOM"},
 	{"Headphone Jack", NULL, "LLOUT"},
 	{"Headphone Jack", NULL, "RLOUT"},
 	{"FM Transmitter", NULL, "LLOUT"},
@@ -288,15 +290,8 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = rtd->card;
 	struct rx51_audio_pdata *pdata = snd_soc_card_get_drvdata(card);
-
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* Set up NC codec pins */
-	snd_soc_dapm_nc_pin(dapm, "MIC3L");
-	snd_soc_dapm_nc_pin(dapm, "MIC3R");
-	snd_soc_dapm_nc_pin(dapm, "LINE1R");
-
 	err = tpa6130a2_add_controls(codec);
 	if (err < 0) {
 		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
@@ -383,6 +378,7 @@ static struct snd_soc_card rx51_sound_card = {
 	.num_aux_devs = ARRAY_SIZE(rx51_aux_dev),
 	.codec_conf = rx51_codec_conf,
 	.num_configs = ARRAY_SIZE(rx51_codec_conf),
+	.fully_routed = true,
 
 	.controls = aic34_rx51_controls,
 	.num_controls = ARRAY_SIZE(aic34_rx51_controls),
-- 
2.1.4
