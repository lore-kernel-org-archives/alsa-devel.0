From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 07/19] ASoC: sst_platform: add capture
 capability for cpu dai driver
Date: Wed, 04 May 2011 21:45:30 +0800
Message-ID: <20110504134530.32443.17487.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 8258F10395E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:06 +0200 (CEST)
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

From: Wang Xingchao <xingchao.wang@intel.com>

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index ce0ac3c..7985cfe 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -123,6 +123,12 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
 			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
 	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16),
+	},
 },
 };
 
