From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 8/8] ASoC: sta32x: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:13 -0300
Message-ID: <1500239473-14886-8-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC66266DB3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:44 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id z22so9781qka.2
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:44 -0700 (PDT)
In-Reply-To: <1500239473-14886-1-git-send-email-festevam@gmail.com>
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
 sound/soc/codecs/sta32x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 0790ae8..5b88847 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -847,8 +847,7 @@ static int sta32x_set_bias_level(struct snd_soc_codec *codec,
 		msleep(300);
 		sta32x_watchdog_stop(sta32x);
 
-		if (sta32x->gpiod_nreset)
-			gpiod_set_value(sta32x->gpiod_nreset, 0);
+		gpiod_set_value(sta32x->gpiod_nreset, 0);
 
 		regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies),
 				       sta32x->supplies);
-- 
2.7.4
