From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] ALSA: pcm_dmaengine: correct the error handler
	of dmaengine_prep_dma_cyclic
Date: Thu, 25 Dec 2014 12:41:15 +0800
Message-ID: <1419482475-4911-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F99C261B02
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 05:41:29 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id lf10so11166608pab.19
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 20:41:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@ti.com, lars@metafoo.de, tiwai@suse.de, broonie@linaro.org
Cc: alsa-devel@alsa-project.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <Baohua.Song@csr.com>

preparing cyclic DMA description can fail either due to DMA desc list
is full(-ENOMEM), or due to the coming DMA configuration is illegal or
not supported by the acting DMA hardware(other ERR codes).

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/core/pcm_dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 6542c40..5cac7e4 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -163,6 +163,8 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 
 	if (!desc)
 		return -ENOMEM;
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
 
 	desc->callback = dmaengine_pcm_dma_complete;
 	desc->callback_param = substream;
-- 
2.2.0
