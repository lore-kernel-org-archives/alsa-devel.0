From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: intel: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:09 +0100
Message-ID: <1420203373-1844-3-git-send-email-lars@metafoo.de>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D7D02604CF
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:33 +0100 (CET)
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
 sound/soc/intel/sst-baytrail-pcm.c      | 6 ------
 sound/soc/intel/sst-haswell-pcm.c       | 6 ------
 sound/soc/intel/sst-mfld-platform-pcm.c | 7 -------
 3 files changed, 19 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 3bb6288..224c49c 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -320,11 +320,6 @@ static struct snd_pcm_ops sst_byt_pcm_ops = {
 	.mmap		= sst_byt_pcm_mmap,
 };
 
-static void sst_byt_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int sst_byt_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
@@ -403,7 +398,6 @@ static struct snd_soc_platform_driver byt_soc_platform = {
 	.remove		= sst_byt_pcm_remove,
 	.ops		= &sst_byt_pcm_ops,
 	.pcm_new	= sst_byt_pcm_new,
-	.pcm_free	= sst_byt_pcm_free,
 };
 
 static const struct snd_soc_component_driver byt_dai_component = {
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 6195252..13f156b 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -735,11 +735,6 @@ static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
 	}
 }
 
-static void hsw_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
@@ -936,7 +931,6 @@ static struct snd_soc_platform_driver hsw_soc_platform = {
 	.remove		= hsw_pcm_remove,
 	.ops		= &hsw_pcm_ops,
 	.pcm_new	= hsw_pcm_new,
-	.pcm_free	= hsw_pcm_free,
 };
 
 static const struct snd_soc_component_driver hsw_dai_component = {
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index a1a8d9d..7523cbe 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -643,12 +643,6 @@ static struct snd_pcm_ops sst_platform_ops = {
 	.pointer = sst_platform_pcm_pointer,
 };
 
-static void sst_pcm_free(struct snd_pcm *pcm)
-{
-	dev_dbg(pcm->dev, "sst_pcm_free called\n");
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
@@ -679,7 +673,6 @@ static struct snd_soc_platform_driver sst_soc_platform_drv  = {
 	.ops		= &sst_platform_ops,
 	.compr_ops	= &sst_platform_compr_ops,
 	.pcm_new	= sst_pcm_new,
-	.pcm_free	= sst_pcm_free,
 };
 
 static const struct snd_soc_component_driver sst_component = {
-- 
1.8.0
