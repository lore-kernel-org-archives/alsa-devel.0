From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: at91sam9g20ek: Automatically disconnect
	non-connected pins
Date: Sat, 11 Apr 2015 11:18:43 +0200
Message-ID: <1428743923-26675-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B1A02612D3
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 11:19:00 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

According to the schematics the both LHPOUT and RHPOUT are connected to the
external connector. RHPOUT is missing from the DAPM routes, but otherwise
they seem to be complete.

This patch adds the missing route and then sets the fully_routed flag for
the card. This allows to remove all the manual calls to
snd_soc_dapm_nc_pin().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/sam9g20_wm8731.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 8de8361..d7469cd 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -95,8 +95,9 @@ static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route intercon[] = {
 
-	/* speaker connected to LHPOUT */
+	/* speaker connected to LHPOUT/RHPOUT */
 	{"Ext Spk", NULL, "LHPOUT"},
+	{"Ext Spk", NULL, "RHPOUT"},
 
 	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
 	{"MICIN", NULL, "Mic Bias"},
@@ -108,9 +109,7 @@ static const struct snd_soc_dapm_route intercon[] = {
  */
 static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	printk(KERN_DEBUG
@@ -124,10 +123,6 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	/* not connected */
-	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
-	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
-
 #ifndef ENABLE_MIC_INPUT
 	snd_soc_dapm_nc_pin(&rtd->card->dapm, "Int Mic");
 #endif
@@ -158,6 +153,7 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.num_dapm_widgets = ARRAY_SIZE(at91sam9g20ek_dapm_widgets),
 	.dapm_routes = intercon,
 	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.fully_routed = true,
 };
 
 static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
-- 
1.8.0
