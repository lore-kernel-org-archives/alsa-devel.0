From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Convert WM8903 bias management to
	use snd_soc_update_bits()
Date: Thu, 10 Feb 2011 14:44:46 +0000
Message-ID: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F1FA24522
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:44:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ff1371f..9156086 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1144,15 +1144,13 @@ static int wm8903_add_widgets(struct snd_soc_codec *codec)
 static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		break;
 	case SND_SOC_BIAS_PREPARE:
-		reg = snd_soc_read(codec, WM8903_VMID_CONTROL_0);
-		reg &= ~(WM8903_VMID_RES_MASK);
-		reg |= WM8903_VMID_RES_50K;
-		snd_soc_write(codec, WM8903_VMID_CONTROL_0, reg);
+		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+				    WM8903_VMID_RES_MASK,
+				    WM8903_VMID_RES_50K);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -1179,10 +1177,9 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 					    WM8903_CP_DYN_V);
 		}
 
-		reg = snd_soc_read(codec, WM8903_VMID_CONTROL_0);
-		reg &= ~(WM8903_VMID_RES_MASK);
-		reg |= WM8903_VMID_RES_250K;
-		snd_soc_write(codec, WM8903_VMID_CONTROL_0, reg);
+		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+				    WM8903_VMID_RES_MASK,
+				    WM8903_VMID_RES_250K);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
1.7.2.3
