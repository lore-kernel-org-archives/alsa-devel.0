From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] regmap: Return an error if a caller attempts to do an unsupported raw read
Date: Mon,  1 Feb 2016 21:38:14 +0000
Message-ID: <1454362695-10682-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mail@maciej.szmigiero.name, Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

regmaps without raw I/O access can't implement raw I/O operations,
return an error if someone tries to do that rather than crashing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 343263449aff..e2f68807d970 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2255,6 +2255,9 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	WARN_ON(!map->bus);
 
+	if (!map->bus || !map->bus->read)
+		return -EINVAL;
+
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
 		ret = _regmap_select_page(map, &reg, range,
-- 
2.7.0.rc3
