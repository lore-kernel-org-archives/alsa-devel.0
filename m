From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] regmap: Add better support for devices
	without readback support
Date: Mon, 13 Jul 2015 12:26:44 +0200
Message-ID: <1436783208-1529-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E3726059E
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:26:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently regmap requires that a reg_read callback is supplied, otherwise a
warning is emitted each time regmap_read() is called. This means a device
or bus without readback support needs to supply dummy reg_read callback.
Apart from that regmap_read() will still work fine if a cache is used.

Remove the warning and let regmap_readable() return false if not reg_read
callback is supplied. This means a device no longer has to supply a dummy
callback if it does not support readback and it also doesn't have to have a
readable_reg callback that always returns false since this is now implicit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/base/regmap/regmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index dd63bcb..8acc837 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -93,6 +93,9 @@ bool regmap_writeable(struct regmap *map, unsigned int reg)
 
 bool regmap_readable(struct regmap *map, unsigned int reg)
 {
+	if (!map->reg_read)
+		return false;
+
 	if (map->max_register && reg > map->max_register)
 		return false;
 
@@ -2109,8 +2112,6 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	int ret;
 	void *context = _regmap_map_get_context(map);
 
-	WARN_ON(!map->reg_read);
-
 	if (!map->cache_bypass) {
 		ret = regcache_read(map, reg, val);
 		if (ret == 0)
-- 
2.1.4
