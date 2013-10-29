From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: memalloc: Make
	snd_{malloc|free}_dev_iram() static
Date: Tue, 29 Oct 2013 12:04:28 +0100
Message-ID: <1383044669-16999-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C65260376
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:01:43 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EF425A5E71
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:01:39 +0100 (CET)
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

These are used only locally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 809fd79ecad6..278248b8f22a 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -167,7 +167,7 @@ static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
  *
  * This function requires iram phandle provided via of_node
  */
-void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
+static void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
 {
 	struct device *dev = dmab->dev.dev;
 	struct gen_pool *pool = NULL;
@@ -192,7 +192,7 @@ void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
  * snd_free_dev_iram - free allocated specific memory from on-chip internal ram
  * @dmab: buffer allocation record to store the allocated data
  */
-void snd_free_dev_iram(struct snd_dma_buffer *dmab)
+static void snd_free_dev_iram(struct snd_dma_buffer *dmab)
 {
 	struct gen_pool *pool = dmab->private_data;
 
-- 
1.8.4.1
