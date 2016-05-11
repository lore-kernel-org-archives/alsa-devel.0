From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix printk formatting" to the
	asoc tree
Date: Wed, 11 May 2016 17:13:53 +0100
Message-ID: <E1b0Wll-0006W2-Rf@debutante>
References: <1462860537-5667-1-git-send-email-joonas.lahtinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EF662667EA
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 18:16:08 +0200 (CEST)
In-Reply-To: <1462860537-5667-1-git-send-email-joonas.lahtinen@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Alsa-devel mailing list for ALSA developers <alsa-devel@alsa-project.org>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix printk formatting

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 396cbebeeb9734aee8efe39431d3b96655bf1e94 Mon Sep 17 00:00:00 2001
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Date: Tue, 10 May 2016 09:08:57 +0300
Subject: [PATCH] ASoC: Intel: Fix printk formatting

Format number after 0x in hex.

Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 1aa819c7e09b..994256b39b9c 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -445,7 +445,7 @@ static int create_adsp_page_table(struct snd_pcm_substream *substream,
 
 	pages = snd_sgbuf_aligned_pages(size);
 
-	dev_dbg(rtd->dev, "generating page table for %p size 0x%zu pages %d\n",
+	dev_dbg(rtd->dev, "generating page table for %p size 0x%zx pages %d\n",
 		dma_area, size, pages);
 
 	for (i = 0; i < pages; i++) {
-- 
2.8.1
