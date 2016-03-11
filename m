From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: qcom: fix build error
Date: Fri, 11 Mar 2016 23:42:52 +0530
Message-ID: <1457719972-9416-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 65CAA261A73
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 19:13:08 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id fl4so104762042pad.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 10:13:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

While building m32r allmodconfig the build failed with:
ERROR: "bad_dma_ops" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!
ERROR: "dma_common_mmap" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!

To satisfy the dependency CONFIG_SND_SOC_LPASS_PLATFORM should depend
on HAS_DMA.
Some other configs also needs the dependency on HAS_DMA as they are
directly or indirectly selecting SND_SOC_LPASS_PLATFORM.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

m32r build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/115245240

 sound/soc/qcom/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 3cc252e..8ec9a07 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -11,21 +11,24 @@ config SND_SOC_LPASS_CPU
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
+	depends on HAS_DMA
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_IPQ806X
 	tristate
+	depends on HAS_DMA
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_APQ8016
 	tristate
+	depends on HAS_DMA
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on SND_SOC_QCOM
+	depends on SND_SOC_QCOM && HAS_DMA
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
@@ -34,7 +37,7 @@ config SND_SOC_STORM
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
-	depends on SND_SOC_QCOM
+	depends on SND_SOC_QCOM && HAS_DMA
 	select SND_SOC_LPASS_APQ8016
 	help
           Support for Qualcomm Technologies LPASS audio block in
-- 
1.9.1
