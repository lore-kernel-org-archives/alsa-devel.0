From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unused mutex from WM9090 driver
Date: Tue, 30 Aug 2011 15:50:07 +0100
Message-ID: <1314715807-20289-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61734243C8
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 16:50:12 +0200 (CEST)
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
 sound/soc/codecs/wm9090.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 4de1220..f2f3077 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -139,7 +139,6 @@ static const u16 wm9090_reg_defaults[] = {
 
 /* This struct is used to save the context */
 struct wm9090_priv {
-	struct mutex mutex;
 	struct wm9090_platform_data pdata;
 	void *control_data;
 };
@@ -663,7 +662,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm9090);
 	wm9090->control_data = i2c;
-	mutex_init(&wm9090->mutex);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9090,  NULL, 0);
-- 
1.7.5.4
