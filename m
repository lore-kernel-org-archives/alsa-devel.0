From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Staticise sst_pcm_new and
	sst_soc_platform_drv
Date: Tue, 13 Dec 2011 17:13:45 +0800
Message-ID: <1323767625.2436.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AD5E7103B06
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 10:13:53 +0100 (CET)
Received: by yhjj56 with SMTP id j56so196581yhj.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 01:13:52 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lu Guanqun <guanqun.lu@intel.com>, Vinod Koul <vinod.koul@intel.com>, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/sst_platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 24f9471..5b936d5 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -443,7 +443,7 @@ static void sst_pcm_free(struct snd_pcm *pcm)
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
+static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
@@ -463,7 +463,7 @@ int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	}
 	return retval;
 }
-struct snd_soc_platform_driver sst_soc_platform_drv = {
+static struct snd_soc_platform_driver sst_soc_platform_drv = {
 	.ops		= &sst_platform_ops,
 	.pcm_new	= sst_pcm_new,
 	.pcm_free	= sst_pcm_free,
-- 
1.7.5.4
