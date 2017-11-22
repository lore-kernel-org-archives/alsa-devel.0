From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ASoC: cs35l32: Improve two size
 determinations in cs35l32_i2c_probe()
Date: Wed, 22 Nov 2017 20:58:28 +0100
Message-ID: <521550ca-c13e-e647-5bbe-d8b172a6445b@users.sourceforge.net>
References: <caf22f25-6c27-b869-89e8-ef2904a2baf2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F14266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 20:59:10 +0100 (CET)
In-Reply-To: <caf22f25-6c27-b869-89e8-ef2904a2baf2@users.sourceforge.net>
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
Date: Wed, 22 Nov 2017 20:40:47 +0100

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/cs35l32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index e41d8ebe6eea..bc3a72e4c4ed 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -355,9 +355,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int devid = 0;
 	unsigned int reg;
 
-
-	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs35l32_private),
-			       GFP_KERNEL);
+	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(*cs35l32), GFP_KERNEL);
 	if (!cs35l32)
 		return -ENOMEM;
 
@@ -373,9 +371,8 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs35l32->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs35l32_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
2.15.0
