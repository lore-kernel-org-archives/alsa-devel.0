From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: WM8903: Add of_match_table
Date: Tue,  6 Dec 2011 14:15:41 -0700
Message-ID: <1323206141-3065-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A210A103BD5
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 22:15:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

This allows the device to be matched against the device tree using the
compatible flag directly, as is standard, rather than falling back to
matching .id_table against the non-vendor portion of the first compatible
property value.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/wm8903.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index adfbefa..7a14210 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2205,6 +2205,12 @@ static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id wm8903_of_match[] = {
+	{ .compatible = "wlf,wm8903", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wm8903_of_match);
+
 static const struct i2c_device_id wm8903_i2c_id[] = {
 	{ "wm8903", 0 },
 	{ }
@@ -2215,6 +2221,7 @@ static struct i2c_driver wm8903_i2c_driver = {
 	.driver = {
 		.name = "wm8903",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8903_of_match,
 	},
 	.probe =    wm8903_i2c_probe,
 	.remove =   __devexit_p(wm8903_i2c_remove),
-- 
1.7.0.4
