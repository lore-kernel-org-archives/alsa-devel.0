From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Mark regmap CODEC register maps as
	dirty when suspending
Date: Wed, 12 Sep 2012 12:23:14 +0800
Message-ID: <1347423794-8606-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0F9D261657
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:23:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The core has for a long time had support for marking the register maps of
devices dirty when suspending so that they are resynced on resume. Also
implement this feature for CODECs using regmap.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0c7e477..b94ce32 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -635,6 +635,8 @@ int snd_soc_suspend(struct device *dev)
 				codec->driver->suspend(codec);
 				codec->suspended = 1;
 				codec->cache_sync = 1;
+				if (codec->using_regmap)
+					regcache_mark_dirty(codec->control_data);
 				break;
 			default:
 				dev_dbg(codec->dev, "CODEC is on over suspend\n");
-- 
1.7.10.4
