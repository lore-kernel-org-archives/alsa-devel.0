From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ASoC: msm8916-wcd-digital: Select
	REGMAP_MMIO to fix build error
Date: Fri, 11 Jan 2019 18:20:40 +0800
Message-ID: <20190111102040.11596-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DCCD2668B2
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 11:20:55 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id h3so6775067pfg.1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 02:20:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix below build error:
ERROR: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-msm8916-digital.ko] undefined!

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: select REGMAP_MMIO is for SND_SOC_MSM8916_WCD_DIGITAL, not SND_SOC_MSM8916_WCD_ANALOG.
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 87cb9c51e6f5..17049b9bc178 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -706,6 +706,7 @@ config SND_SOC_MSM8916_WCD_ANALOG
 
 config SND_SOC_MSM8916_WCD_DIGITAL
 	tristate "Qualcomm MSM8916 WCD DIGITAL Codec"
+	select REGMAP_MMIO
 
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
-- 
2.17.1
