From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix printk formatting
Date: Tue, 10 May 2016 09:08:57 +0300
Message-ID: <1462860537-5667-1-git-send-email-joonas.lahtinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A092651D3
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 08:07:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel mailing list for ALSA developers <alsa-devel@alsa-project.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Format number after 0x in hex.

Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 1aa819c..994256b 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -445,7 +445,7 @@ static int create_adsp_page_table(struct snd_pcm_substream *substream,
 
 	pages = snd_sgbuf_aligned_pages(size);
 
-	dev_dbg(rtd->dev, "generating page table for %p size 0x%zu pages %d\n",
+	dev_dbg(rtd->dev, "generating page table for %p size 0x%zx pages %d\n",
 		dma_area, size, pages);
 
 	for (i = 0; i < pages; i++) {
-- 
2.5.5
