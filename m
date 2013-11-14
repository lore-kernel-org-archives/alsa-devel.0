From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: wm8962: Turn on regcache_cache_only
	before disabling regulator
Date: Thu, 14 Nov 2013 11:59:21 +0800
Message-ID: <1384401561-10539-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id ECB6F2610D0
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 04:59:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

It's safer to turn on regcache_cache_only before disabling regulator since
the driver will turn off the regcache_cache_only after enabling regulator.

If we remain cache_only false, some command like 'amixer cset' would get
failure if being run before wm8962_resume().

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2bf9ee7..1741493 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3720,6 +3720,8 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto err_enable;
 
+	regcache_cache_only(wm8962->regmap, true);
+
 	/* The drivers should power up as needed */
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 
-- 
1.8.4
