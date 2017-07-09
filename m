From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ALSA: pcm: Protect call to dma_mmap_coherent()
	by check for HAS_DMA
Date: Sun,  9 Jul 2017 21:31:02 +0200
Message-ID: <1499628662-15490-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 444BF266B13
 for <alsa-devel@alsa-project.org>; Sun,  9 Jul 2017 21:31:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If NO_DMA=y:

    sound/core/pcm_native.o: In function `snd_pcm_lib_default_mmap':
    pcm_native.c:(.text+0x144c): undefined reference to `bad_dma_ops'
    pcm_native.c:(.text+0x1474): undefined reference to `dma_common_mmap'

Add a check for HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b3d5bed750297ec2..e540a22aa3d8988a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3502,7 +3502,7 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 	}
 #endif /* CONFIG_GENERIC_ALLOCATOR */
 #ifndef CONFIG_X86 /* for avoiding warnings arch/x86/mm/pat.c */
-	if (!substream->ops->page &&
+	if (IS_ENABLED(CONFIG_HAS_DMA) && !substream->ops->page &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
 					 area,
-- 
2.7.4
