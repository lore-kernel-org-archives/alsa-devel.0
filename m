From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: au1x: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:08 +0100
Message-ID: <1420203373-1844-2-git-send-email-lars@metafoo.de>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E2582604BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:32 +0100 (CET)
In-Reply-To: <1420203373-1844-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed when the PCM
itself is freed. There is no need to do this manually in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/au1x/dbdma2.c | 6 ------
 sound/soc/au1x/dma.c    | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index b06b8d8..dd94fea 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -315,11 +315,6 @@ static struct snd_pcm_ops au1xpsc_pcm_ops = {
 	.pointer	= au1xpsc_pcm_pointer,
 };
 
-static void au1xpsc_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int au1xpsc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
@@ -335,7 +330,6 @@ static int au1xpsc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_platform_driver au1xpsc_soc_platform = {
 	.ops		= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
-	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
 };
 
 static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 6ffaaff..24cc7f4 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -287,11 +287,6 @@ static struct snd_pcm_ops alchemy_pcm_ops = {
 	.pointer		= alchemy_pcm_pointer,
 };
 
-static void alchemy_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int alchemy_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
@@ -305,7 +300,6 @@ static int alchemy_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
 	.ops		= &alchemy_pcm_ops,
 	.pcm_new	= alchemy_pcm_new,
-	.pcm_free	= alchemy_pcm_free_dma_buffers,
 };
 
 static int alchemy_pcm_drvprobe(struct platform_device *pdev)
-- 
1.8.0
