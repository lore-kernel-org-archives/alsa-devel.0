From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] regmap: Add support for 24 bit wide
	register addresses
Date: Thu, 10 Jan 2013 17:06:10 +0100
Message-ID: <1357833977-3682-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-052.synserver.de (smtp-out-052.synserver.de
 [212.40.185.52])
 by alsa0.perex.cz (Postfix) with ESMTP id DD1F5261658
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 17:05:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since regmap already has support for formatting 24 bit wide values, so adding
support for 24 bit wide registers is pretty much straight forward.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/base/regmap/regmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 42d5cb0..26af93a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -500,6 +500,12 @@ struct regmap *regmap_init(struct device *dev,
 		}
 		break;
 
+	case 24:
+		if (reg_endian != REGMAP_ENDIAN_BIG)
+			goto err_map;
+		map->format.format_reg = regmap_format_24;
+		break;
+
 	case 32:
 		switch (reg_endian) {
 		case REGMAP_ENDIAN_BIG:
-- 
1.8.0
