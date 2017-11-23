From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ASoC: da7213: Improve a size determination in
 da7213_i2c_probe()
Date: Thu, 23 Nov 2017 18:33:53 +0100
Message-ID: <0ec34e2a-8e18-bc1d-b07f-a606499b3682@users.sourceforge.net>
References: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, support.opensource@diasemi.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 18:15:30 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/da7213.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index d1b77a0e3b74..b2b4e90fc02a 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1853,8 +1853,7 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	struct da7213_priv *da7213;
 	int ret;
 
-	da7213 = devm_kzalloc(&i2c->dev, sizeof(struct da7213_priv),
-			      GFP_KERNEL);
+	da7213 = devm_kzalloc(&i2c->dev, sizeof(*da7213), GFP_KERNEL);
 	if (!da7213)
 		return -ENOMEM;
 
-- 
2.15.0

