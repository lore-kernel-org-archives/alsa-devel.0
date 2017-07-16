From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 5/8] ASoC: cs35l34: Remove unneeded gpiod NULL
	check
Date: Sun, 16 Jul 2017 18:11:10 -0300
Message-ID: <1500239473-14886-5-git-send-email-festevam@gmail.com>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 42CC2266A74
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 23:11:36 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id v17so16284592qka.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 14:11:36 -0700 (PDT)
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
 sound/soc/codecs/cs35l34.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 0a747c6..dade899 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -1138,8 +1138,7 @@ static int cs35l34_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 
-	if (cs35l34->reset_gpio)
-		gpiod_set_value_cansleep(cs35l34->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l34->reset_gpio, 0);
 
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(cs35l34->num_core_supplies,
-- 
2.7.4
