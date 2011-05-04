From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 02/19] ASoC: sst_platform: add cpu dai driver
 for moorestown platform
Date: Wed, 04 May 2011 21:45:04 +0800
Message-ID: <20110504134504.32443.60814.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 47DD3103937
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:42 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
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

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 139db15..ce0ac3c 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -110,6 +110,20 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "mrst-cpu-pcm2",
+	.id = 4,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_48000 |
+			  SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_8000),
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
+	},
+},
 };
 
 /* helper functions */
