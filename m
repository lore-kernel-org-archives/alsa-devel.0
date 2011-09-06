From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 4/4] ASoC: sst_platform: fix memory leak
Date: Tue, 06 Sep 2011 15:21:43 +0800
Message-ID: <20110906072142.7310.25845.stgit@localhost>
References: <20110906072129.7310.6960.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C08E1039F0
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 09:19:12 +0200 (CEST)
In-Reply-To: <20110906072129.7310.6960.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

snd_pcm_hw_constraint_integer() could return -1, in this case, sst platform is
not opened successfully.  However the corresponding close callback isn't able
to be called later on to release these two allocated memories, thus resulting
in memory leak.

This patch moves the check for hardware contraints earlier, thus resolving this
issue.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index af666ae..9925d20 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -233,6 +233,10 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 	pr_debug("sst_platform_open called\n");
 
 	snd_soc_set_runtime_hwparams(substream, &sst_platform_pcm_hw);
+	ret_val = snd_pcm_hw_constraint_integer(runtime,
+						SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret_val < 0)
+		return ret_val;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
@@ -260,8 +264,8 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 		return ret_val;
 	}
 	runtime->private_data = stream;
-	return snd_pcm_hw_constraint_integer(runtime,
-			 SNDRV_PCM_HW_PARAM_PERIODS);
+
+	return 0;
 }
 
 static int sst_platform_close(struct snd_pcm_substream *substream)
