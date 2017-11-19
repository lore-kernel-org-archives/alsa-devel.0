From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: wm8804: Use common error handling code
 in wm8804_probe()
Date: Sun, 19 Nov 2017 08:04:28 +0100
Message-ID: <0027af2f-e560-556c-e5af-effe5179a227@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id B9439266847
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 08:05:37 +0100 (CET)
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
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 07:55:49 +0100

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Replace two calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/wm8804.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index fc69b87443d8..a45812417909 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -626,16 +626,12 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 	gpiod_set_value_cansleep(wm8804->reset, 1);
 
 	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
-	if (ret < 0) {
-		dev_err(dev, "Failed to read device ID: %d\n", ret);
-		goto err_reg_enable;
-	}
+	if (ret < 0)
+		goto report_read_failure;
 
 	ret = regmap_read(regmap, WM8804_DEVID2, &id2);
-	if (ret < 0) {
-		dev_err(dev, "Failed to read device ID: %d\n", ret);
-		goto err_reg_enable;
-	}
+	if (ret < 0)
+		goto report_read_failure;
 
 	id2 = (id2 << 8) | id1;
 
@@ -674,6 +670,8 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 
 	return 0;
 
+report_read_failure:
+	dev_err(dev, "Failed to read device ID: %d\n", ret);
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
 	return ret;
-- 
2.15.0
