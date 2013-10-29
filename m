From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: memalloc: NULL-initialize in
	snd_malloc_dev_iram()
Date: Tue, 29 Oct 2013 12:04:29 +0100
Message-ID: <1383044669-16999-2-git-send-email-tiwai@suse.de>
References: <1383044669-16999-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 763132608D8
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:01:43 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EF4D7A5E9A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:01:39 +0100 (CET)
In-Reply-To: <1383044669-16999-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

dmab->area and addr fields should be cleared at the head of
snd_malloc_dev_iram() as especially dmab->area is used to indicate the
allocation failure / fallback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 278248b8f22a..9d93f02c6285 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -172,6 +172,9 @@ static void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
 	struct device *dev = dmab->dev.dev;
 	struct gen_pool *pool = NULL;
 
+	dmab->area = NULL;
+	dmab->addr = 0;
+
 	if (dev->of_node)
 		pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
 
-- 
1.8.4.1
