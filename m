From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Allow codec->cache_bypass to
	be used with snd_soc_hw_bulk_write_raw()
Date: Thu,  5 May 2011 14:18:11 +0100
Message-ID: <1304601491-22751-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9492103810
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 15:18:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

If we specifically want to write a block of data to the hw bypassing the
cache, then allow this to happen inside snd_soc_hw_bulk_write_raw().

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a217db2..687beec 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -404,12 +404,13 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 {
 	int ret;
 
-	/* Ensure that the base register is volatile.  Subsequently
-	 * any other register that is touched by this routine should be
-	 * volatile as well to ensure that we don't get out of sync with
-	 * the cache.
+	/* To ensure that we don't get out of sync with the cache, check
+	 * whether the base register is volatile or if we've directly asked
+	 * to bypass the cache.  Out of bounds registers are considered
+	 * volatile.
 	 */
-	if (!snd_soc_codec_volatile_register(codec, reg)
+	if (!codec->cache_bypass
+	    && !snd_soc_codec_volatile_register(codec, reg)
 	    && reg < codec->driver->reg_cache_size)
 		return -EINVAL;
 
-- 
1.7.5
