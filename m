From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Ensure consistent cache naming
Date: Mon, 29 Nov 2010 10:54:28 +0000
Message-ID: <1291028068-25461-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F7762451D
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 11:54:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    2 +-
 sound/soc/soc-cache.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3eb92ef..9e593cf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -256,7 +256,7 @@ enum snd_soc_control_type {
 };
 
 enum snd_soc_compress_type {
-	SND_SOC_NO_COMPRESSION,
+	SND_SOC_FLAT_COMPRESSION,
 	SND_SOC_LZO_COMPRESSION,
 	SND_SOC_RBTREE_COMPRESSION
 };
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index e5b1888..9b1ba33 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1520,7 +1520,7 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 /* an array of all supported compression types */
 static const struct snd_soc_cache_ops cache_types[] = {
 	{
-		.id = SND_SOC_NO_COMPRESSION,
+		.id = SND_SOC_FLAT_COMPRESSION,
 		.init = snd_soc_flat_cache_init,
 		.exit = snd_soc_flat_cache_exit,
 		.read = snd_soc_flat_cache_read,
-- 
1.7.3.2
