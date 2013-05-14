From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] ASoC: mmp-pcm: Staticize non exported
	structs and functions
Date: Tue, 14 May 2013 22:19:51 +0200
Message-ID: <1368562797-10440-5-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FCFA260818
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:26 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Zhangfei Gao <zhangfei.gao@marvell.com>
List-Id: alsa-devel@alsa-project.org

The mmp_pcm_ops and mmp_soc_platform struct as well as the mmp_pcm_new()
function are only used in mmp-pcm.c, so make them static.

Cc: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/mmp-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 3499300..5d57e07 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -147,7 +147,7 @@ static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
 		vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-struct snd_pcm_ops mmp_pcm_ops = {
+static struct snd_pcm_ops mmp_pcm_ops = {
 	.open		= mmp_pcm_open,
 	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -208,7 +208,7 @@ static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
+static int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_pcm *pcm = rtd->pcm;
@@ -229,7 +229,7 @@ err:
 	return ret;
 }
 
-struct snd_soc_platform_driver mmp_soc_platform = {
+static struct snd_soc_platform_driver mmp_soc_platform = {
 	.ops		= &mmp_pcm_ops,
 	.pcm_new	= mmp_pcm_new,
 	.pcm_free	= mmp_pcm_free_dma_buffers,
-- 
1.8.0
