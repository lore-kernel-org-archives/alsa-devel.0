From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 3/3] ASoC: max98090: add an of_match table
Date: Mon, 31 Mar 2014 12:38:18 -0600
Message-ID: <1396291098-13796-3-git-send-email-swarren@wwwdotorg.org>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 21EE12651F3
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:38:38 +0200 (CEST)
In-Reply-To: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
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
 sound/soc/codecs/max98090.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 98c6e104357c..f7b0b37aa858 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2399,11 +2399,18 @@ static const struct i2c_device_id max98090_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98090_i2c_id);
 
+static const struct of_device_id max98090_of_match[] = {
+	{ .compatible = "maxim,max98090", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max98090_of_match);
+
 static struct i2c_driver max98090_i2c_driver = {
 	.driver = {
 		.name = "max98090",
 		.owner = THIS_MODULE,
 		.pm = &max98090_pm,
+		.of_match_table = of_match_ptr(max98090_of_match),
 	},
 	.probe  = max98090_i2c_probe,
 	.remove = max98090_i2c_remove,
-- 
1.8.1.5
