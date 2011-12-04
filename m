From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: uda1380: Return proper error in
 uda1380_modinit failure path
Date: Sun, 04 Dec 2011 19:35:20 +0800
Message-ID: <1322998520.12391.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F2A3246C7
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 12:35:32 +0100 (CET)
Received: by iakr3 with SMTP id r3so2681743iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 03:35:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Return proper error for uda1380_modinit if i2c_add_driver() fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/uda1380.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 6b933ef..3a238cb 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -863,13 +863,13 @@ static struct i2c_driver uda1380_i2c_driver = {
 
 static int __init uda1380_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&uda1380_i2c_driver);
 	if (ret != 0)
 		pr_err("Failed to register UDA1380 I2C driver: %d\n", ret);
 #endif
-	return 0;
+	return ret;
 }
 module_init(uda1380_modinit);
 
-- 
1.7.5.4
