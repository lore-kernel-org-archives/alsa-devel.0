From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add basic WM8918 support
Date: Wed, 22 Jun 2011 20:07:54 +0100
Message-ID: <1308769674-19579-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26969103A45
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 21:07:59 +0200 (CEST)
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

The WM8918 is register compatible with the WM8904 with a subset of the
functionality. Add the device ID, a subsequent patch will ensure that only
the relevant functionality is exported to userspace.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 9b3bba4..b085575 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2560,6 +2560,7 @@ static __devexit int wm8904_i2c_remove(struct i2c_client *client)
 static const struct i2c_device_id wm8904_i2c_id[] = {
 	{ "wm8904", WM8904 },
 	{ "wm8912", WM8912 },
+	{ "wm8918", WM8904 },   /* Actually a subset, updates to follow */
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
-- 
1.7.5.4
