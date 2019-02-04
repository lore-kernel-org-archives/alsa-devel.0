From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: core: Don't allow NULL device for
	memory allocation
Date: Mon,  4 Feb 2019 14:42:22 +0100
Message-ID: <20190204134222.9560-6-tiwai@suse.de>
References: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9720C26752C
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 14:42:28 +0100 (CET)
In-Reply-To: <20190204134222.9560-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

Since we covered all callers with NULL device pointer, let's catch the
remaining calls with NULL and warn explicitly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 59a4adc286ed..eb974235c92b 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -182,6 +182,8 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		return -ENXIO;
 	if (WARN_ON(!dmab))
 		return -ENXIO;
+	if (WARN_ON(!device))
+		return -EINVAL;
 
 	dmab->dev.type = type;
 	dmab->dev.dev = device;
-- 
2.16.4
