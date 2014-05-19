From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: cache: Fix possible ZERO_SIZE_PTR
	pointer dereferencing error.
Date: Mon, 19 May 2014 16:32:09 +0800
Message-ID: <1400488329-31702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5D8260864
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 11:19:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Since we cannot make sure the 'reg_size' will always be none zero here,
and then if 'reg_size' equals to zero, the kzalloc() will return ZERO_SIZE_PTR,
which equals to ((void *)16).

So this patch fix this with just doing the 'reg_size' zero check before calling
kzalloc().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 3fa77d5..8fff5b6 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -72,6 +72,9 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 
 	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
+	if (!reg_size)
+		return -EINVAL;
+
 	mutex_init(&codec->cache_rw_mutex);
 
 	dev_dbg(codec->dev, "ASoC: Initializing cache for %s codec\n",
-- 
1.8.4
