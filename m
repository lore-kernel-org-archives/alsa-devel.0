From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] ASoC: max9860: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:42:37 +0200
Message-ID: <20180411124238.9385-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0132.outbound.protection.outlook.com [104.47.0.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 5208D2673F2
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 14:42:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index a2dc6a47f466..376bd48e4790 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -599,8 +599,7 @@ static const struct dev_pm_ops max9860_pm_ops = {
 	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
 };
 
-static int max9860_probe(struct i2c_client *i2c,
-			 const struct i2c_device_id *id)
+static int max9860_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct max9860_priv *max9860;
@@ -738,7 +737,7 @@ static const struct of_device_id max9860_of_match[] = {
 MODULE_DEVICE_TABLE(of, max9860_of_match);
 
 static struct i2c_driver max9860_i2c_driver = {
-	.probe	        = max9860_probe,
+	.probe_new      = max9860_probe,
 	.remove         = max9860_remove,
 	.id_table       = max9860_i2c_id,
 	.driver         = {
-- 
2.11.0
