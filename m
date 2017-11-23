From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ASoC: cs42l56: Improve two size
 determinations in cs42l56_i2c_probe()
Date: Thu, 23 Nov 2017 09:45:19 +0100
Message-ID: <8c36fc94-1f7d-5d22-7d3a-f2f6117199aa@users.sourceforge.net>
References: <d722241a-dca3-dac3-8288-ac2e283e8be8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EAA8267295
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 09:46:00 +0100 (CET)
In-Reply-To: <d722241a-dca3-dac3-8288-ac2e283e8be8@users.sourceforge.net>
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
Date: Thu, 23 Nov 2017 09:33:15 +0100

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/cs42l56.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 13ee46217d78..fd7b8d32c2b2 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1190,9 +1190,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int alpha_rev, metal_rev;
 	unsigned int reg;
 
-	cs42l56 = devm_kzalloc(&i2c_client->dev,
-			       sizeof(struct cs42l56_private),
-			       GFP_KERNEL);
+	cs42l56 = devm_kzalloc(&i2c_client->dev, sizeof(*cs42l56), GFP_KERNEL);
 	if (cs42l56 == NULL)
 		return -ENOMEM;
 	cs42l56->dev = &i2c_client->dev;
@@ -1207,8 +1205,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs42l56->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs42l56_platform_data),
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
 				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
-- 
2.15.0
