From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: txx9: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:13 +0100
Message-ID: <1420203373-1844-7-git-send-email-lars@metafoo.de>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 7858F260504
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:37 +0100 (CET)
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
 sound/soc/txx9/txx9aclc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 070e44e..88eacfd 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -282,11 +282,6 @@ static struct snd_pcm_ops txx9aclc_pcm_ops = {
 	.pointer	= txx9aclc_pcm_pointer,
 };
 
-static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
@@ -412,7 +407,6 @@ static struct snd_soc_platform_driver txx9aclc_soc_platform = {
 	.remove		= txx9aclc_pcm_remove,
 	.ops		= &txx9aclc_pcm_ops,
 	.pcm_new	= txx9aclc_pcm_new,
-	.pcm_free	= txx9aclc_pcm_free_dma_buffers,
 };
 
 static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
-- 
1.8.0
