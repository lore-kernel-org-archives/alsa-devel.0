From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix wm_hubs input PGA ZC bits
Date: Fri, 27 May 2011 21:56:44 +0800
Message-ID: <1306504604-4723-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00123103828
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 15:56:52 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index e55b298..9e370d1 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -215,23 +215,23 @@ static const struct snd_kcontrol_new analogue_snd_controls[] = {
 SOC_SINGLE_TLV("IN1L Volume", WM8993_LEFT_LINE_INPUT_1_2_VOLUME, 0, 31, 0,
 	       inpga_tlv),
 SOC_SINGLE("IN1L Switch", WM8993_LEFT_LINE_INPUT_1_2_VOLUME, 7, 1, 1),
-SOC_SINGLE("IN1L ZC Switch", WM8993_LEFT_LINE_INPUT_1_2_VOLUME, 7, 1, 0),
+SOC_SINGLE("IN1L ZC Switch", WM8993_LEFT_LINE_INPUT_1_2_VOLUME, 6, 1, 0),
 
 SOC_SINGLE_TLV("IN1R Volume", WM8993_RIGHT_LINE_INPUT_1_2_VOLUME, 0, 31, 0,
 	       inpga_tlv),
 SOC_SINGLE("IN1R Switch", WM8993_RIGHT_LINE_INPUT_1_2_VOLUME, 7, 1, 1),
-SOC_SINGLE("IN1R ZC Switch", WM8993_RIGHT_LINE_INPUT_1_2_VOLUME, 7, 1, 0),
+SOC_SINGLE("IN1R ZC Switch", WM8993_RIGHT_LINE_INPUT_1_2_VOLUME, 6, 1, 0),
 
 
 SOC_SINGLE_TLV("IN2L Volume", WM8993_LEFT_LINE_INPUT_3_4_VOLUME, 0, 31, 0,
 	       inpga_tlv),
 SOC_SINGLE("IN2L Switch", WM8993_LEFT_LINE_INPUT_3_4_VOLUME, 7, 1, 1),
-SOC_SINGLE("IN2L ZC Switch", WM8993_LEFT_LINE_INPUT_3_4_VOLUME, 7, 1, 0),
+SOC_SINGLE("IN2L ZC Switch", WM8993_LEFT_LINE_INPUT_3_4_VOLUME, 6, 1, 0),
 
 SOC_SINGLE_TLV("IN2R Volume", WM8993_RIGHT_LINE_INPUT_3_4_VOLUME, 0, 31, 0,
 	       inpga_tlv),
 SOC_SINGLE("IN2R Switch", WM8993_RIGHT_LINE_INPUT_3_4_VOLUME, 7, 1, 1),
-SOC_SINGLE("IN2R ZC Switch", WM8993_RIGHT_LINE_INPUT_3_4_VOLUME, 7, 1, 0),
+SOC_SINGLE("IN2R ZC Switch", WM8993_RIGHT_LINE_INPUT_3_4_VOLUME, 6, 1, 0),
 
 SOC_SINGLE_TLV("MIXINL IN2L Volume", WM8993_INPUT_MIXER3, 7, 1, 0,
 	       inmix_sw_tlv),
-- 
1.7.5.1
