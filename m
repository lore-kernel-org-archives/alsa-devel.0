From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/8] ASoC: adau1977: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:08 -0300
Message-ID: <1500239473-14886-3-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A444266D49
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:32 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id w12so16264386qta.2
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:32 -0700 (PDT)
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
 sound/soc/codecs/adau1977.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index b319db6..ccc5cf0 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -388,8 +388,7 @@ static int adau1977_power_disable(struct adau1977 *adau1977)
 
 	regcache_mark_dirty(adau1977->regmap);
 
-	if (adau1977->reset_gpio)
-		gpiod_set_value_cansleep(adau1977->reset_gpio, 0);
+	gpiod_set_value_cansleep(adau1977->reset_gpio, 0);
 
 	regcache_cache_only(adau1977->regmap, true);
 
@@ -420,8 +419,7 @@ static int adau1977_power_enable(struct adau1977 *adau1977)
 			goto err_disable_avdd;
 	}
 
-	if (adau1977->reset_gpio)
-		gpiod_set_value_cansleep(adau1977->reset_gpio, 1);
+	gpiod_set_value_cansleep(adau1977->reset_gpio, 1);
 
 	regcache_cache_only(adau1977->regmap, false);
 
-- 
2.7.4
