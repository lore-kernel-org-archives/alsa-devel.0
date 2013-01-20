From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5100: Implement DRC,
	EQ and LHPF coefficient configuration
Date: Sun, 20 Jan 2013 22:03:55 +0900
Message-ID: <1358687035-27226-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1358687035-27226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20A5F2616EF
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2013 14:04:02 +0100 (CET)
In-Reply-To: <1358687035-27226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 54397a5..ac1745d 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -563,6 +563,19 @@ SOC_DOUBLE_R("IN3 Switch", WM5100_ADC_DIGITAL_VOLUME_3L,
 SOC_DOUBLE_R("IN4 Switch", WM5100_ADC_DIGITAL_VOLUME_4L,
 	     WM5100_ADC_DIGITAL_VOLUME_4R, WM5100_IN4L_MUTE_SHIFT, 1, 1),
 
+SND_SOC_BYTES_MASK("EQ1 Coefficients", WM5100_EQ1_1, 20, WM5100_EQ1_ENA),
+SND_SOC_BYTES_MASK("EQ2 Coefficients", WM5100_EQ2_1, 20, WM5100_EQ2_ENA),
+SND_SOC_BYTES_MASK("EQ3 Coefficients", WM5100_EQ3_1, 20, WM5100_EQ3_ENA),
+SND_SOC_BYTES_MASK("EQ4 Coefficients", WM5100_EQ4_1, 20, WM5100_EQ4_ENA),
+
+SND_SOC_BYTES_MASK("DRC Coefficients", WM5100_DRC1_CTRL1, 5,
+		   WM5100_DRCL_ENA | WM5100_DRCR_ENA),
+
+SND_SOC_BYTES("LHPF1 Coefficeints", WM5100_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficeints", WM5100_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF3 Coefficeints", WM5100_HPLPF3_2, 1),
+SND_SOC_BYTES("LHPF4 Coefficeints", WM5100_HPLPF4_2, 1),
+
 SOC_SINGLE("HPOUT1 High Performance Switch", WM5100_OUT_VOLUME_1L,
 	   WM5100_OUT1_OSR_SHIFT, 1, 0),
 SOC_SINGLE("HPOUT2 High Performance Switch", WM5100_OUT_VOLUME_2L,
-- 
1.7.10.4
