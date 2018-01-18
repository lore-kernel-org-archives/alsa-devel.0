From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: sgtl5000: Clarify a bit about the ER1
	meaning
Date: Thu, 18 Jan 2018 09:45:28 -0200
Message-ID: <1516275928-10318-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0078.outbound.protection.outlook.com [104.47.42.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B7477266A74
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 12:45:41 +0100 (CET)
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

The "check ER1" message is not very clear about its meaning.

Improve it a bit by referring to it as "ER1 erratum" so that it
becomes clearer that ER1 references to a SGTL5000 erratum.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 633cdcf..e1ab553 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1392,7 +1392,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
 		dev_info(&client->dev,
-			 "Using internal LDO instead of VDDD: check ER1\n");
+			 "Using internal LDO instead of VDDD: check ER1 erratum\n");
 	} else {
 		/* using external LDO for VDDD
 		 * Clear startup powerup and simple powerup
-- 
2.7.4
