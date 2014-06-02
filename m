From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: cache: Fix error code when not using
	ASoC level cache
Date: Mon,  2 Jun 2014 16:11:03 +0100
Message-ID: <1401721863-3364-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1560B265091
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 18:18:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

It is not an error to have no cache so we shouldn't return an error code
and cause our callers to fail, just silently do nothing instead.  Thanks
to Jarkko for identify the problematic commit.

Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
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
2.0.0.rc2
