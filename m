From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/21] ASoC: Convert WM2000 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:12 +0000
Message-ID: <1322948009-27658-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 640A0243D1
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:38 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 01b1abe..2726f66 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -740,7 +740,8 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 		return -EINVAL;
 	}
 
-	wm2000 = kzalloc(sizeof(struct wm2000_priv), GFP_KERNEL);
+	wm2000 = devm_kzalloc(&i2c->dev, sizeof(struct wm2000_priv),
+			      GFP_KERNEL);
 	if (wm2000 == NULL) {
 		dev_err(&i2c->dev, "Unable to allocate private data\n");
 		return -ENOMEM;
@@ -779,7 +780,9 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 
 	/* Pre-cook the concatenation of the register address onto the image */
 	wm2000->anc_download_size = fw->size + 2;
-	wm2000->anc_download = kmalloc(wm2000->anc_download_size, GFP_KERNEL);
+	wm2000->anc_download = devm_kzalloc(&i2c->dev,
+					    wm2000->anc_download_size,
+					    GFP_KERNEL);
 	if (wm2000->anc_download == NULL) {
 		dev_err(&i2c->dev, "Out of memory\n");
 		ret = -ENOMEM;
@@ -810,7 +813,6 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 err_fw:
 	release_firmware(fw);
 err:
-	kfree(wm2000);
 	return ret;
 }
 
@@ -821,8 +823,6 @@ static __devexit int wm2000_i2c_remove(struct i2c_client *i2c)
 	wm2000_anc_transition(wm2000, ANC_OFF);
 
 	wm2000_i2c = NULL;
-	kfree(wm2000->anc_download);
-	kfree(wm2000);
 
 	return 0;
 }
-- 
1.7.7.3
