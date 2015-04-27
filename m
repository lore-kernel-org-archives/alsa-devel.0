From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: omap-twl4030: Use card DAPM context to
	access widgets
Date: Mon, 27 Apr 2015 12:15:02 +0200
Message-ID: <1430129702-16408-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6FC26057B
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:15:02 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Use the card DAPM context instead of the CODEC DAPM context since only card
level widgets are accessed here.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-twl4030.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 3673ada..7431314 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -159,9 +159,8 @@ static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *dapm,
 
 static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	struct omap_tw4030_pdata *pdata = dev_get_platdata(card->dev);
 	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
 	int ret = 0;
-- 
1.8.0
