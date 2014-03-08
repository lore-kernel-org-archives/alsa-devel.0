From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: sam9g20_wm8731: Convert to table based
	DAPM setup
Date: Sat,  8 Mar 2014 15:47:22 +0100
Message-ID: <1394290042-30883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D342654FD
 for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2014 15:46:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes. This on one hand
makes the code a bit shorter and cleaner and on the other hand the board level
DAPM elements get registered in the card's DAPM context rather than in the
CODEC's DAPM context.

While we are at it also remove the snd_soc_dapm_enable_pin() in the init
callback. Pins are enabled by default.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/sam9g20_wm8731.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index f15bff1..174bd54 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -155,25 +155,14 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	/* Add specific widgets */
-	snd_soc_dapm_new_controls(dapm, at91sam9g20ek_dapm_widgets,
-				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
-	/* Set up specific audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
 	/* not connected */
 	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
 	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
 
-#ifdef ENABLE_MIC_INPUT
-	snd_soc_dapm_enable_pin(dapm, "Int Mic");
-#else
-	snd_soc_dapm_nc_pin(dapm, "Int Mic");
+#ifndef ENABLE_MIC_INPUT
+	snd_soc_dapm_nc_pin(&rtd->card->dapm, "Int Mic");
 #endif
 
-	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-
 	return 0;
 }
 
@@ -194,6 +183,11 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
 	.set_bias_level = at91sam9g20ek_set_bias_level,
+
+	.dapm_widgets = at91sam9g20ek_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(at91sam9g20ek_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
-- 
1.8.0
