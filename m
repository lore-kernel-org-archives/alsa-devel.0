From: <20080924115907.GA12401@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Fix build of GTA01 audio driver
Date: Wed, 24 Sep 2008 13:01:08 +0100
Message-ID: <1222257670-12527-2-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
References: <1222257670-12527-1-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 663142417B
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 14:01:11 +0200 (CEST)
In-Reply-To: <1222257670-12527-1-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Fix a couple of thinkos introduced during the I2C API update.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 47ddcde..48c6756 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -649,7 +649,7 @@ static void lm4857_shutdown(struct i2c_client *dev)
 }
 
 static const struct i2c_device_id lm4857_i2c_id[] = {
-	{ "neo1973_lm4857", 0 }
+	{ "neo1973_lm4857", 0 },
 	{ }
 };
 
@@ -730,7 +730,7 @@ static int __init neo1973_init(void)
 	}
 
 	ret = neo1973_add_lm4857_device(neo1973_snd_device,
-					neo1973_wm8753_setup, 0x7C);
+					0, 0x7C);
 	if (ret != 0)
 		platform_device_unregister(neo1973_snd_device);
 
-- 
1.5.6.5
