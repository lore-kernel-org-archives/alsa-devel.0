From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs35l33: Fix display revision id
Date: Thu, 30 Jun 2016 08:14:30 +0800
Message-ID: <1467245670.7105.3.camel@ingics.com>
References: <1467245614.7105.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FA43266014
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 02:14:35 +0200 (CEST)
Received: by mail-pa0-f67.google.com with SMTP id av7so5610088pac.3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 17:14:35 -0700 (PDT)
In-Reply-To: <1467245614.7105.2.camel@ingics.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index aa5c0c5..640fe24 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1219,7 +1219,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	dev_info(&i2c_client->dev,
-		 "Cirrus Logic CS35L33, Revision: %02X\n", ret & 0xFF);
+		 "Cirrus Logic CS35L33, Revision: %02X\n", reg & 0xFF);
 
 	ret = regmap_register_patch(cs35l33->regmap,
 			cs35l33_patch, ARRAY_SIZE(cs35l33_patch));
-- 
2.5.0
