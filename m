From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: soc-generic-dmaengine-pcm: Fix error
	handling
Date: Thu, 22 Feb 2018 16:02:21 -0300
Message-ID: <1519326142-26421-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8EF2677F6
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 20:02:37 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id d8so7656536qtm.0
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:02:37 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

When dmaengine_pcm_request_chan_of() fails it should release
the previously acquired resources, which in this case is to
call kfree(pcm), so jump to the correct point in the error
path.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 768247f..32ea16d 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -450,7 +450,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
-		goto err_free_dma;
+		goto err_free_pcm;
 
 	ret = snd_soc_add_component(dev, &pcm->component,
 				    &dmaengine_pcm_component, NULL, 0);
@@ -461,6 +461,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 err_free_dma:
 	dmaengine_pcm_release_chan(pcm);
+err_free_pcm:
 	kfree(pcm);
 	return ret;
 }
-- 
2.7.4
