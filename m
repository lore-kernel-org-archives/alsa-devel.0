From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add DRC control for WM8996
Date: Tue, 27 Sep 2011 19:03:17 +0100
Message-ID: <1317146597-29669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A804244F5
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 20:03:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Karl Tsou <karl@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Karl Tsou <karl@opensource.wolfsonmicro.com>

Signed-off-by: Karl Tsou <karl@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 833df74..b98a8f8 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -641,6 +641,14 @@ SOC_DOUBLE_R("Speaker ZC Switch", WM8996_LEFT_PDM_SPEAKER,
 
 SOC_SINGLE("DSP1 EQ Switch", WM8996_DSP1_RX_EQ_GAINS_1, 0, 1, 0),
 SOC_SINGLE("DSP2 EQ Switch", WM8996_DSP2_RX_EQ_GAINS_1, 0, 1, 0),
+
+SOC_SINGLE("DSP1 DRC TXL Switch", WM8996_DSP1_DRC_1, 0, 1, 0),
+SOC_SINGLE("DSP1 DRC TXR Switch", WM8996_DSP1_DRC_1, 1, 1, 0),
+SOC_SINGLE("DSP1 DRC RX Switch", WM8996_DSP1_DRC_1, 2, 1, 0),
+
+SOC_SINGLE("DSP2 DRC TXL Switch", WM8996_DSP2_DRC_1, 0, 1, 0),
+SOC_SINGLE("DSP2 DRC TXR Switch", WM8996_DSP2_DRC_1, 1, 1, 0),
+SOC_SINGLE("DSP2 DRC RX Switch", WM8996_DSP2_DRC_1, 2, 1, 0),
 };
 
 static const struct snd_kcontrol_new wm8996_eq_controls[] = {
-- 
1.7.6.3
