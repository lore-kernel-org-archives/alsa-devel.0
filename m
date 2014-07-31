From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_asrc: Fix sparse warnings in FSL_ASRC_FORMATS due to typo
Date: Thu, 31 Jul 2014 12:07:40 +0800
Message-ID: <1406779660-17177-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

reproduce: make C=1 CF=-D__CHECK_ENDIAN__

sparse warnings: (new ones prefixed by >>)

>> sound/soc/fsl/fsl_asrc.c:563:28: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/fsl/fsl_asrc.c:570:28: sparse: restricted snd_pcm_format_t degrades to integer

vim +563 sound/soc/fsl/fsl_asrc.c

  557          .probe = fsl_asrc_dai_probe,
  558          .playback = {
  559                  .stream_name = "ASRC-Playback",
  560                  .channels_min = 1,
  561                  .channels_max = 10,
  562                  .rates = FSL_ASRC_RATES,
> 563                  .formats = FSL_ASRC_FORMATS,
  564          },
  565          .capture = {
  566                  .stream_name = "ASRC-Capture",
  567                  .channels_min = 1,
  568                  .channels_max = 10,
  569                  .rates = FSL_ASRC_RATES,
> 570                  .formats = FSL_ASRC_FORMATS,
  571          },
  572          .ops = &fsl_asrc_dai_ops,
  573  };

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 41699f7..cdb5779 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -551,7 +551,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 #define FSL_ASRC_RATES		 SNDRV_PCM_RATE_8000_192000
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
-				 SNDRV_PCM_FORMAT_S20_3LE)
+				 SNDRV_PCM_FMTBIT_S20_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
 	.probe = fsl_asrc_dai_probe,
-- 
1.8.4
