From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 2/4] ASoC: sst_platform: add support for
	capture stream on headset dai
Date: Wed, 19 Jan 2011 18:16:42 +0530
Message-ID: <1295441202-32103-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 691F71039A3
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:32:38 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index a4e3fa3..0d8c430 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -73,6 +73,12 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S24_LE,
 	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 5,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	},
 },
 {
 	.name = "Speaker-cpu-dai",
-- 
1.7.2.3
