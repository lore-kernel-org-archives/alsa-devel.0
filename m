From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/8] ASoC: wm8804: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:07 -0300
Message-ID: <1500239473-14886-2-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D66266A74
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:30 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id v17so16284416qka.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:30 -0700 (PDT)
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
 sound/soc/codecs/wm8804.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index af95d648..fc69b87 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -623,8 +623,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
-	if (wm8804->reset)
-		gpiod_set_value_cansleep(wm8804->reset, 1);
+	gpiod_set_value_cansleep(wm8804->reset, 1);
 
 	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
 	if (ret < 0) {
-- 
2.7.4
