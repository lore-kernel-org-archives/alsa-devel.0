From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Fix invalid memory access
	during snd_soc_lzo_cache_sync()
Date: Tue, 11 Jan 2011 11:24:02 +0000
Message-ID: <1294745042-23352-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D988245CF
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:24:05 +0100 (CET)
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

The size of the lzo syncing bitmap was incorrectly set to the size
of the cache times the word size, however, the correct size is the
size of the cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a9ebc07..8c2a21a 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1361,7 +1361,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 			goto err;
 		}
 		lzo_blocks[i]->sync_bmp = sync_bmp;
-		lzo_blocks[i]->sync_bmp_nbits = reg_size;
+		lzo_blocks[i]->sync_bmp_nbits = bmp_size;
 		/* alloc the working space for the compressed block */
 		ret = snd_soc_lzo_prepare(lzo_blocks[i]);
 		if (ret < 0)
-- 
1.7.3.5
