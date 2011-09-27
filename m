From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Staticise sst_platform_dai
Date: Tue, 27 Sep 2011 10:38:50 +0800
Message-ID: <1317091130.315.2.camel@phoenix>
References: <1317091087.315.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317091087.315.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is not used outside this driver so no need to make the symbol global.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/sst_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 9925d20..7df8c58 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -63,7 +63,7 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 };
 
 /* MFLD - MSIC */
-struct snd_soc_dai_driver sst_platform_dai[] = {
+static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
 	.name = "Headset-cpu-dai",
 	.id = 0,
-- 
1.7.4.1
