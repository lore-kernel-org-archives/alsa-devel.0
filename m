From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: Revert "ASoC: soc-generic-dmaengine-pcm:
	Fix error handling"
Date: Mon, 26 Feb 2018 15:55:25 -0300
Message-ID: <1519671325-15822-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A1732675FF
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 19:55:18 +0100 (CET)
Received: by mail-vk0-f65.google.com with SMTP id z130so3506873vkd.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 10:55:18 -0800 (PST)
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

This reverts commit f91b1e73ccde71d4bc69ae10d475196df38844ab.

As explained by Lars-Peter Clausen:

"This creates a resource leak. dmaengine_pcm_request_chan_of() requests
bothtransmit and receive channels. It might return with an error if one
of them fails, but the other one succeeded. In this case we need to call
dmaengine_pcm_release_chan() to free the requested channel"

So revert the commit.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 32ea16d..768247f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -450,7 +450,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
-		goto err_free_pcm;
+		goto err_free_dma;
 
 	ret = snd_soc_add_component(dev, &pcm->component,
 				    &dmaengine_pcm_component, NULL, 0);
@@ -461,7 +461,6 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 err_free_dma:
 	dmaengine_pcm_release_chan(pcm);
-err_free_pcm:
 	kfree(pcm);
 	return ret;
 }
-- 
2.7.4
