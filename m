From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 1/2] ASoC: rt5616: add an of_match table
Date: Mon, 21 Dec 2015 21:18:13 +0800
Message-ID: <1450703894-32623-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, wxt@rock-chips.com, linux-kernel@vger.kernel.org, bardliao@realtek.com, alsa-devel@alsa-project.org, heiko@sntech.de
List-Id: alsa-devel@alsa-project.org

Add a device tree match table. This serves to make the driver's support
of device tree more explicit.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 sound/soc/codecs/rt5616.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f4005cb..e01a32d 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1287,6 +1287,14 @@ static const struct i2c_device_id rt5616_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5616_i2c_id);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5616_of_match[] = {
+	{ .compatible = "realtek,rt5616", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5616_of_match);
+#endif
+
 static int rt5616_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1359,6 +1367,7 @@ static void rt5616_i2c_shutdown(struct i2c_client *client)
 static struct i2c_driver rt5616_i2c_driver = {
 	.driver = {
 		.name = "rt5616",
+		.of_match_table = of_match_ptr(rt5616_of_match),
 	},
 	.probe = rt5616_i2c_probe,
 	.remove = rt5616_i2c_remove,
-- 
1.9.1
