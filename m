From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: soc-cache: Fix the return value of
	snd_soc_cache_init when reg_size is 0
Date: Mon, 2 Jun 2014 11:23:54 -0300
Message-ID: <1401719034-17204-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA062652E7
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 16:24:19 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Li.Xiubo@freescale.com, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Commit b59dce53ef6 (ASoC: cache: Fix possible ZERO_SIZE_PTR pointer 
dereferencing error.) caused the following probe error:

wm8962 0-001a: customer id 0 revision D
wm8962 0-001a: ASoC: Failed to set cache compression type: -22
imx-wm8962 sound: snd_soc_register_card failed (-22)
imx-wm8962: probe of sound failed with error -22

If reg_size just return success instead.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/soc-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8fff5b6..00e70b6 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -73,7 +73,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
 	if (!reg_size)
-		return -EINVAL;
+		return 0;
 
 	mutex_init(&codec->cache_rw_mutex);
 
-- 
1.8.3.2
