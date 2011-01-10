From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Add support for NULL default
	register caches
Date: Mon, 10 Jan 2011 10:10:56 +0000
Message-ID: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAD10243D4
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 11:10:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The infrastructure for handling NULL default register maps is already
included in the soc-cache code, just ensure that we don't try to dereference
a NULL pointer while accessing a NULL register cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bac7291..a9f19c1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3503,11 +3503,13 @@ int snd_soc_register_codec(struct device *dev,
 		 * kernel might have freed the array by the time we initialize
 		 * the cache.
 		 */
-		codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
-					      reg_size, GFP_KERNEL);
-		if (!codec->reg_def_copy) {
-			ret = -ENOMEM;
-			goto fail;
+		if (codec_drv->reg_cache_default) {
+			codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
+						      reg_size, GFP_KERNEL);
+			if (!codec->reg_def_copy) {
+				ret = -ENOMEM;
+				goto fail;
+			}
 		}
 	}
 
-- 
1.7.3.5
