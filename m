From: Jesse Marroquin <jesse.marroquin@maxim-ic.com>
Subject: [PATCH] ASoC: Add support for MAX98089 CODEC
Date: Wed, 17 Nov 2010 14:26:40 -0600
Message-ID: <4CE43A80.4050209__47387.4788768173$1290025623$gmane$org@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id AFAE51038C8
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 21:26:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Hsiang <Peter.Hsiang@maxim>
List-Id: alsa-devel@alsa-project.org

This patch adds initial support for the MAX98089 CODEC.

Signed-off-by: Jesse Marroquin <jesse.marroquin@maxim-ic.com>
---
 sound/soc/codecs/max98088.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ef06007..9c32237 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -28,6 +28,11 @@
 #include <sound/max98088.h>
 #include "max98088.h"
 
+enum max98088_type {
+       MAX98088,
+       MAX98089,
+};
+
 struct max98088_cdata {
        unsigned int rate;
        unsigned int fmt;
@@ -36,6 +41,7 @@ struct max98088_cdata {
 
 struct max98088_priv {
        u8 reg_cache[M98088_REG_CNT];
+       enum max98088_type devtype;
        void *control_data;
        struct max98088_pdata *pdata;
        unsigned int sysclk;
@@ -2042,6 +2048,8 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
        if (max98088 == NULL)
                return -ENOMEM;
 
+       max98088->devtype = id->driver_data;
+
        i2c_set_clientdata(i2c, max98088);
        max98088->control_data = i2c;
        max98088->pdata = i2c->dev.platform_data;
@@ -2061,7 +2069,8 @@ static int __devexit max98088_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max98088_i2c_id[] = {
-       { "max98088", 0 },
+       { "max98088", MAX98088 },
+       { "max98089", MAX98089 },
        { }
 };
 MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
-- 
1.5.6.5
