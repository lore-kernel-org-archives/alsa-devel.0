From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l35: Fix display revision id
Date: Sat, 11 Mar 2017 20:57:07 +0800
Message-ID: <20170311125707.14309-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 95F41265142
 for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2017 13:57:24 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id 77so13119062pgc.0
 for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2017 04:57:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 260ed42..9c82e5e 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1468,7 +1468,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS35L35 (%x), Revision: %02X\n", devid,
-		ret & 0xFF);
+		reg & 0xFF);
 
 	/* Set the INT Masks for critical errors */
 	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_1,
-- 
2.9.3
