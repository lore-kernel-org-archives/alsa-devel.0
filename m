From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] ALSA: pcm: Fix trailing semicolon
Date: Mon, 15 Jan 2018 18:18:57 +0000
Message-ID: <20180115181857.32105-1-luisbg@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ubuntu <luisbg@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Ubuntu <luisbg@kernel.org>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---


Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

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
