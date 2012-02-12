From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8988: Remove unneded -codec from
	driver name
Date: Sun, 12 Feb 2012 18:24:10 +0000
Message-ID: <1329071050-11498-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329071050-11498-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DD7C2415A
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:07:05 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [108.60.121.130])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id A70FD110565
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:07:03 +0000 (GMT)
In-Reply-To: <1329071050-11498-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8988.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 2470321..6cdf6a2 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -963,7 +963,7 @@ MODULE_DEVICE_TABLE(i2c, wm8988_i2c_id);
 
 static struct i2c_driver wm8988_i2c_driver = {
 	.driver = {
-		.name = "wm8988-codec",
+		.name = "wm8988",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8988_i2c_probe,
-- 
1.7.9.rc1
