From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/3] ASoC: tlv320aic23: add an of_match table
Date: Mon, 31 Mar 2014 12:38:17 -0600
Message-ID: <1396291098-13796-2-git-send-email-swarren@wwwdotorg.org>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 246DF2651D6
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:38:37 +0200 (CEST)
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
 sound/soc/codecs/tlv320aic23-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic23-i2c.c b/sound/soc/codecs/tlv320aic23-i2c.c
index 20fc46092c2c..b73c94ebcc2a 100644
--- a/sound/soc/codecs/tlv320aic23-i2c.c
+++ b/sound/soc/codecs/tlv320aic23-i2c.c
@@ -43,9 +43,16 @@ static const struct i2c_device_id tlv320aic23_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, tlv320aic23_id);
 
+static const struct of_device_id tlv320aic23_of_match[] = {
+	{ .compatible = "ti,tlv320aic23", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tlv320aic23_of_match);
+
 static struct i2c_driver tlv320aic23_i2c_driver = {
 	.driver = {
 		   .name = "tlv320aic23-codec",
+		   .of_match_table = of_match_ptr(tlv320aic23_of_match),
 		   },
 	.probe = tlv320aic23_i2c_probe,
 	.remove = __exit_p(tlv320aic23_i2c_remove),
-- 
1.8.1.5
