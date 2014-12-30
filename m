From: Fabio Estevam <festevam@gmail.com>
Subject: [RFC] ASoC: wm8962: Allow codec to work when
	CONFIG_PM=n
Date: Tue, 30 Dec 2014 13:58:16 -0200
Message-ID: <1419955096-18810-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id B31BC260672
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 16:58:32 +0100 (CET)
Received: by mail-vc0-f175.google.com with SMTP id hy10so5670896vcb.6
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 07:58:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b50113@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently the codec does not work in the CONFIG_PM=n case because the regulators
and clock are kept disabled.

Allow the codec to be functional by calling wm8962_runtime_resume() when 
CONFIG_PM=n.

Tested on a imx6sl-evk in the CONFIG_PM=y and CONFIG_PM=n cases.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---

Probably there is a better solution, hence I am sending it as RFC.

Thanks

 sound/soc/codecs/wm8962.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d32d554..0b041c9 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3546,6 +3546,9 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
 	return 0;
 }
 
+static int wm8962_runtime_resume(struct device *dev);
+static int wm8962_runtime_suspend(struct device *dev);
+
 static int wm8962_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -3771,6 +3774,9 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	/* The drivers should power up as needed */
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 
+	if (!IS_ENABLED(CONFIG_PM))
+		wm8962_runtime_resume(&i2c->dev);
+
 	return 0;
 
 err_enable:
@@ -3781,11 +3787,12 @@ err:
 
 static int wm8962_i2c_remove(struct i2c_client *client)
 {
+	if (!IS_ENABLED(CONFIG_PM))
+		wm8962_runtime_suspend(&client->dev);
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int wm8962_runtime_resume(struct device *dev)
 {
 	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
@@ -3860,7 +3867,6 @@ static int wm8962_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static struct dev_pm_ops wm8962_pm = {
 	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
-- 
1.9.1
