From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ASoC: wm8903: Improve two size
 determinations in wm8903_i2c_probe()
Date: Fri, 24 Nov 2017 10:55:31 +0100
Message-ID: <013d9ad7-a8ff-6fad-ba82-40e68cf0a601@users.sourceforge.net>
References: <d4ce14fa-42a4-c911-3e0a-f2dd5cde6c14@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A02D266DE5
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 10:55:44 +0100 (CET)
In-Reply-To: <d4ce14fa-42a4-c911-3e0a-f2dd5cde6c14@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 10:40:43 +0100

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/wm8903.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 51eb7d61d446..cba90f21161f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1995,8 +1995,7 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 	unsigned int val, irq_pol;
 	int ret, i;
 
-	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
-			      GFP_KERNEL);
+	wm8903 = devm_kzalloc(&i2c->dev, sizeof(*wm8903), GFP_KERNEL);
 	if (wm8903 == NULL)
 		return -ENOMEM;
 
@@ -2017,9 +2016,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 	if (pdata) {
 		wm8903->pdata = pdata;
 	} else {
-		wm8903->pdata = devm_kzalloc(&i2c->dev,
-					sizeof(struct wm8903_platform_data),
-					GFP_KERNEL);
+		wm8903->pdata = devm_kzalloc(&i2c->dev, sizeof(*wm8903->pdata),
+					     GFP_KERNEL);
 		if (!wm8903->pdata)
 			return -ENOMEM;
 
-- 
2.15.0
