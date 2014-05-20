From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: neo1973_wm8753: Automatically
	disconnected non-connected pins
Date: Tue, 20 May 2014 11:13:28 +0200
Message-ID: <1400577208-1473-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-128.synserver.de
 [212.40.185.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 06BF8264EAA
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 11:13:40 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAPM routes for this board are complete, hence we can let the core take care
of disconnecting non-connected pins rather than doing it manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/neo1973_wm8753.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index b080033..9b4a09f 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -271,15 +271,8 @@ static const struct snd_kcontrol_new neo1973_wm8753_controls[] = {
 
 static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = rtd->card;
 
-	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(&codec->dapm, "OUT3");
-	snd_soc_dapm_nc_pin(&codec->dapm, "OUT4");
-	snd_soc_dapm_nc_pin(&codec->dapm, "LINE1");
-	snd_soc_dapm_nc_pin(&codec->dapm, "LINE2");
-
 	/* set endpoints to default off mode */
 	snd_soc_dapm_disable_pin(&card->dapm, "GSM Line Out");
 	snd_soc_dapm_disable_pin(&card->dapm, "GSM Line In");
@@ -355,6 +348,7 @@ static struct snd_soc_card neo1973 = {
 	.num_dapm_widgets = ARRAY_SIZE(neo1973_wm8753_dapm_widgets),
 	.dapm_routes = neo1973_wm8753_routes,
 	.num_dapm_routes = ARRAY_SIZE(neo1973_wm8753_routes),
+	.fully_routed = true,
 };
 
 static struct platform_device *neo1973_snd_device;
-- 
1.8.0
