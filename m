From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 12:38:16 -0600
Message-ID: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B718265176
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:38:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Add a device tree match table. This serves to make the driver's support
of device tree more explicit. Perhaps the fallback for DT matching to
using the i2c_device_id table will go away one day, since it fails in
face of devices from different vendors with the same name.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/alc5632.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 3ee8d4e41a99..85942ca36cbf 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1190,11 +1190,18 @@ static const struct i2c_device_id alc5632_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
 
+static const struct of_device_id alc5632_of_match[] = {
+	{ .compatible = "realtek,alc5632", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, alc5632_of_match);
+
 /* i2c codec control layer */
 static struct i2c_driver alc5632_i2c_driver = {
 	.driver = {
 		.name = "alc5632",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(alc5632_of_match),
 	},
 	.probe = alc5632_i2c_probe,
 	.remove =  alc5632_i2c_remove,
-- 
1.8.1.5
