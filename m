From: Peng Donglin <pengdonglin137@163.com>
Subject: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon,  7 Aug 2017 20:56:31 +0800
Message-ID: <1502110591-7783-1-git-send-email-pengdonglin137@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-132.163.com (m50-132.163.com [123.125.50.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 064ED26721A
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 14:56:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Peng Donglin <pengdonglin137@163.com>
List-Id: alsa-devel@alsa-project.org

The value of the variable new_name is assigned repeatedly.

Signed-off-by: Peng Donglin <pengdonglin137@163.com>
---
 sound/soc/soc-compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36b..2c16f42 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	/* check client and interface hw capabilities */
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-			rtd->dai_link->stream_name, codec_dai->name, num);
-
 	if (codec_dai->driver->playback.channels_min)
 		playback = 1;
 	if (codec_dai->driver->capture.channels_min)
-- 
1.9.1
