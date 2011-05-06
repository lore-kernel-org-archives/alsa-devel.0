From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 02/10] ASoC: sst_platform: modify current
 cpu dai driver to suit the needs for moorestown platform
Date: Fri, 06 May 2011 13:46:08 +0800
Message-ID: <20110506054608.26312.61645.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 28ED6103A7E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:44:48 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Wang Xingchao <xingchao.wang@intel.com>

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Acked-by: Koul Vinod <vinod.koul@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 139db15..afa5eab 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -68,16 +68,21 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 	.name = "Headset-cpu-dai",
 	.id = 0,
 	.playback = {
-		.channels_min = SST_STEREO,
+		.channels_min = SST_MONO,
 		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+		.rates = (SNDRV_PCM_RATE_48000 |
+			  SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_8000),
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 5,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			    SNDRV_PCM_FMTBIT_S24_LE),
 	},
 },
 {
