From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ASoC: cs35l34: Delete two error messages
 for a failed memory allocation in cs35l34_i2c_probe()
Date: Wed, 22 Nov 2017 21:29:15 +0100
Message-ID: <7e0b578a-e342-7c54-5eeb-f8dd427e59b5@users.sourceforge.net>
References: <f524230c-6dbd-cb66-4c61-570b5ef185c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE00266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 21:29:27 +0100 (CET)
In-Reply-To: <f524230c-6dbd-cb66-4c61-570b5ef185c1@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 21:13:29 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/cs35l34.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 1e05026bedca..6cbdbbe53940 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -1007,10 +1007,8 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
 	cs35l34 = devm_kzalloc(&i2c_client->dev,
 			       sizeof(struct cs35l34_private),
 			       GFP_KERNEL);
-	if (!cs35l34) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
+	if (!cs35l34)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(i2c_client, cs35l34);
 	cs35l34->regmap = devm_regmap_init_i2c(i2c_client, &cs35l34_regmap);
@@ -1047,11 +1045,9 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
 		pdata = devm_kzalloc(&i2c_client->dev,
 				sizeof(struct cs35l34_platform_data),
 				GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&i2c_client->dev,
-				"could not allocate pdata\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
+
 		if (i2c_client->dev.of_node) {
 			ret = cs35l34_handle_of_data(i2c_client, pdata);
 			if (ret != 0)
-- 
2.15.0
