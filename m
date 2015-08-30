From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: spear_pcm: Use
 devm_snd_dmaengine_pcm_register to fix resource leak
Date: Sun, 30 Aug 2015 08:08:15 +0800
Message-ID: <1440893295.19750.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 61BBF2606C2
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 02:08:21 +0200 (CEST)
Received: by paczk9 with SMTP id zk9so4165715pac.0
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 17:08:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

All the callers assume devm_spear_pcm_platform_register is a devm_ API, so
use devm_snd_dmaengine_pcm_register in devm_spear_pcm_platform_register.

Fixes: e1771bcf99b0 ("ASoC: SPEAr: remove custom DMA alloc compat function")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/spear/spear_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index a7dc3c5..e8476da 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -44,7 +44,7 @@ int devm_spear_pcm_platform_register(struct device *dev,
 	*config = spear_dmaengine_pcm_config;
 	config->compat_filter_fn = filter;
 
-	return snd_dmaengine_pcm_register(dev, config,
+	return devm_snd_dmaengine_pcm_register(dev, config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
-- 
2.1.0
