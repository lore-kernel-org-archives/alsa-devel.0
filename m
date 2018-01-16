From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH v2] ALSA: pcm: Fix trailing semicolon
Date: Tue, 16 Jan 2018 13:26:26 +0000
Message-ID: <20180116132626.13156-1-luisbg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by alsa0.perex.cz (Postfix) with ESMTP id B8CDF266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:26:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Luis de Bethencourt <luisbg@kernel.org>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Joe Perches <joe@perches.com>
List-Id: alsa-devel@alsa-project.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---
Changes from v1:
 - Fix commit message


 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3f13e8da0812..51104df924e1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3446,7 +3446,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_lib_default_mmap);
 int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
 			   struct vm_area_struct *area)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
 	return vm_iomap_memory(area, runtime->dma_addr, runtime->dma_bytes);
-- 
2.15.1
