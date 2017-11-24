From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ASoC: wm8903: Delete an error message for
 a failed memory allocation in wm8903_i2c_probe()
Date: Fri, 24 Nov 2017 10:53:33 +0100
Message-ID: <52cba9de-be47-1518-20fc-897967686bf8@users.sourceforge.net>
References: <d4ce14fa-42a4-c911-3e0a-f2dd5cde6c14@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id D008A266DE5
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 10:54:35 +0100 (CET)
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
Date: Fri, 24 Nov 2017 10:05:43 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/wm8903.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 237eeb9a8b97..51eb7d61d446 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2020,10 +2020,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 		wm8903->pdata = devm_kzalloc(&i2c->dev,
 					sizeof(struct wm8903_platform_data),
 					GFP_KERNEL);
-		if (wm8903->pdata == NULL) {
-			dev_err(&i2c->dev, "Failed to allocate pdata\n");
+		if (!wm8903->pdata)
 			return -ENOMEM;
-		}
 
 		if (i2c->irq) {
 			ret = wm8903_set_pdata_irq_trigger(i2c, wm8903->pdata);
-- 
2.15.0
