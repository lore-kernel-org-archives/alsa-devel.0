From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2 1/2] ASoC: sgtl5000: Do not print error on
	probe deferral
Date: Wed, 17 Jan 2018 13:48:54 -0200
Message-ID: <1516204135-11200-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0069.outbound.protection.outlook.com [104.47.37.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 2329B266E7C
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 16:49:07 +0100 (CET)
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

When the MCLK is not yet available when the codec is probed, probe
deferral will happen and in this case we should not print an
error message.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Correcty mark this patch as 1/2

 sound/soc/codecs/sgtl5000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f2bb4fe..633cdcf 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1332,10 +1332,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	sgtl5000->mclk = devm_clk_get(&client->dev, NULL);
 	if (IS_ERR(sgtl5000->mclk)) {
 		ret = PTR_ERR(sgtl5000->mclk);
-		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
 		/* Defer the probe to see if the clk will be provided later */
 		if (ret == -ENOENT)
 			ret = -EPROBE_DEFER;
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev, "Failed to get mclock: %d\n",
+				ret);
 		goto disable_regs;
 	}
 
-- 
2.7.4
