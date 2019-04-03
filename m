From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] ASoC: sprd: Fix the smatch warning
Date: Wed,  3 Apr 2019 00:47:55 -0700
Message-ID: <811e491489b62624942dabd56f277b08784ef0f9.1554276741.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Remove the unnecessary validation of the 'cstream' variable to fix
below smatch warning:

sprd_platform_compr_drain_notify() warn: variable dereferenced
before check 'cstream' (see line 105)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index dc84257..424e983 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -107,8 +107,7 @@ static void sprd_platform_compr_drain_notify(void *arg)
 
 	memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
 
-	if (cstream)
-		snd_compr_drain_notify(cstream);
+	snd_compr_drain_notify(cstream);
 }
 
 static void sprd_platform_compr_dma_complete(void *data)
-- 
1.9.1
