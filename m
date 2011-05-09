From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: WM8903: Fix Digital Capture Volume range
Date: Mon,  9 May 2011 16:32:03 -0600
Message-ID: <1304980323-18857-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 414E1103806
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 00:32:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Increase the range of the Digital Capture Volume control to be 120 steps.
Each step is 0.75dB, and the range starts at -72dB, giving a max setting
of 18dB, which matches the latest datasheet, to the precision of the step
size.

Tested-on: Seaboard non-clamshell.
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/wm8903.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index f3cab84..957cd66 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -699,7 +699,7 @@ SOC_ENUM("DRC Smoothing Threshold", drc_smoothing),
 SOC_SINGLE_TLV("DRC Startup Volume", WM8903_DRC_0, 6, 18, 0, drc_tlv_startup),
 
 SOC_DOUBLE_R_TLV("Digital Capture Volume", WM8903_ADC_DIGITAL_VOLUME_LEFT,
-		 WM8903_ADC_DIGITAL_VOLUME_RIGHT, 1, 96, 0, digital_tlv),
+		 WM8903_ADC_DIGITAL_VOLUME_RIGHT, 1, 120, 0, digital_tlv),
 SOC_ENUM("ADC Companding Mode", adc_companding),
 SOC_SINGLE("ADC Companding Switch", WM8903_AUDIO_INTERFACE_0, 3, 1, 0),
 
-- 
1.7.0.4
