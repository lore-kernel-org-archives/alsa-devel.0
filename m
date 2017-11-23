From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ASoC: da7218: Improve a size determination
 in da7218_i2c_probe()
Date: Thu, 23 Nov 2017 21:07:51 +0100
Message-ID: <8f6b7c8c-f1eb-47c7-c11f-731aa8051863@users.sourceforge.net>
References: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6024F266F1C
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 21:07:57 +0100 (CET)
In-Reply-To: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, support.opensource@diasemi.com, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 20:50:44 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/da7218.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 93a0cb741751..0c1933a98995 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3269,8 +3269,7 @@ static int da7218_i2c_probe(struct i2c_client *i2c,
 	struct da7218_priv *da7218;
 	int ret;
 
-	da7218 = devm_kzalloc(&i2c->dev, sizeof(struct da7218_priv),
-			      GFP_KERNEL);
+	da7218 = devm_kzalloc(&i2c->dev, sizeof(*da7218), GFP_KERNEL);
 	if (!da7218)
 		return -ENOMEM;
 
-- 
2.15.0
