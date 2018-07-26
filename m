From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: memalloc: declare
	snd_sgbuf_aligned_pages() unconditionally" to the asoc tree
Date: Thu, 26 Jul 2018 17:12:04 +0100 (BST)
Message-ID: <20180726161204.F366244008F@finisterre.ee.mobilebroadband>
References: <20180725201556.21136-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F57E2677BB
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:51 +0200 (CEST)
In-Reply-To: <20180725201556.21136-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4cae99d9b5305ab8cccc839fccceb81ec9e5abda Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 25 Jul 2018 15:15:56 -0500
Subject: [PATCH] ALSA: memalloc: declare snd_sgbuf_aligned_pages()
 unconditionally

Make this helper inline function available for all platforms. This
helps solve 0-day compilation issues when CONFIG_SND_DMA_SGBUF is not
defined.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/memalloc.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 9c3db3dce32b..c669900e6cbe 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -67,6 +67,14 @@ struct snd_dma_buffer {
 	void *private_data;	/* private for allocator; don't touch */
 };
 
+/*
+ * return the pages matching with the given byte size
+ */
+static inline unsigned int snd_sgbuf_aligned_pages(size_t size)
+{
+	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
 #ifdef CONFIG_SND_DMA_SGBUF
 /*
  * Scatter-Gather generic device pages
@@ -90,14 +98,6 @@ struct snd_sg_buf {
 	struct device *dev;
 };
 
-/*
- * return the pages matching with the given byte size
- */
-static inline unsigned int snd_sgbuf_aligned_pages(size_t size)
-{
-	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-}
-
 /*
  * return the physical address at the corresponding offset
  */
-- 
2.18.0
