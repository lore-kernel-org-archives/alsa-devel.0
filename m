From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] ASoC: sgtl5000: Use i2c_get_clientdata()
Date: Mon, 10 Jun 2013 10:24:41 -0300
Message-ID: <1370870682-10243-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 by alsa0.perex.cz (Postfix) with ESMTP id B796E2615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:26:26 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

We should use i2c_get_clientdata() to get the codec private structure.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 2e0227b..d441559 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1571,11 +1571,7 @@ disable_clk:
 
 static int sgtl5000_i2c_remove(struct i2c_client *client)
 {
-	struct sgtl5000_priv *sgtl5000;
-	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
-								GFP_KERNEL);
-	if (!sgtl5000)
-		return -ENOMEM;
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
 	clk_disable_unprepare(sgtl5000->mclk);
-- 
1.8.1.2
