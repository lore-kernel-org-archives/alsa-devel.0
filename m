From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: sh: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:12 +0100
Message-ID: <1420203373-1844-6-git-send-email-lars@metafoo.de>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 6521B2604E0
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:36 +0100 (CET)
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
 sound/soc/sh/dma-sh7760.c | 6 ------
 sound/soc/sh/fsi.c        | 6 ------
 sound/soc/sh/siu_pcm.c    | 1 -
 3 files changed, 13 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index a5b2c4e..fd11404 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -305,11 +305,6 @@ static struct snd_pcm_ops camelot_pcm_ops = {
 	.pointer	= camelot_pos,
 };
 
-static void camelot_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int camelot_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
@@ -328,7 +323,6 @@ static int camelot_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_platform_driver sh7760_soc_platform = {
 	.ops		= &camelot_pcm_ops,
 	.pcm_new	= camelot_pcm_new,
-	.pcm_free	= camelot_pcm_free,
 };
 
 static int sh7760_soc_platform_probe(struct platform_device *pdev)
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 8869971..422faa9 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1765,11 +1765,6 @@ static struct snd_pcm_ops fsi_pcm_ops = {
 #define PREALLOC_BUFFER		(32 * 1024)
 #define PREALLOC_BUFFER_MAX	(32 * 1024)
 
-static void fsi_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int fsi_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	return snd_pcm_lib_preallocate_pages_for_all(
@@ -1821,7 +1816,6 @@ static struct snd_soc_dai_driver fsi_soc_dai[] = {
 static struct snd_soc_platform_driver fsi_soc_platform = {
 	.ops		= &fsi_pcm_ops,
 	.pcm_new	= fsi_pcm_new,
-	.pcm_free	= fsi_pcm_free,
 };
 
 static const struct snd_soc_component_driver fsi_soc_component = {
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 32eb6da..82902f5 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -589,7 +589,6 @@ static void siu_pcm_free(struct snd_pcm *pcm)
 	tasklet_kill(&port_info->playback.tasklet);
 
 	siu_free_port(port_info);
-	snd_pcm_lib_preallocate_free_for_all(pcm);
 
 	dev_dbg(pcm->card->dev, "%s\n", __func__);
 }
-- 
1.8.0
