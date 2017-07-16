From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/8] ASoC: sun4i-codec: Remove unneeded gpiod
	NULL check
Date: Sun, 16 Jul 2017 18:11:06 -0300
Message-ID: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC8E266A74
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:28 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id v31so16255811qtb.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/sunxi/sun4i-codec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 1500699..4c37231 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1171,9 +1171,8 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
 {
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
 
-	if (scodec->gpio_pa)
-		gpiod_set_value_cansleep(scodec->gpio_pa,
-					 !!SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value_cansleep(scodec->gpio_pa,
+				 !!SND_SOC_DAPM_EVENT_ON(event));
 
 	return 0;
 }
-- 
2.7.4
