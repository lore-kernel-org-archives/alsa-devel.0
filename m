From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/17] ASoC: Manage VMID mode for WM8990
Date: Tue, 18 Nov 2008 12:38:12 +0000
Message-ID: <1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D2351037F0
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:27 +0100 (CET)
In-Reply-To: <1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A small additional power saving can be achieved for the WM8990 by
maintaining VMID using a 2*250k divider when in standby mode.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 938e154..2d7b009 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1222,8 +1222,14 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
+
 	case SND_SOC_BIAS_PREPARE:
+		/* VMID=2*50k */
+		val = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_1) &
+			~WM8990_VMID_MODE_MASK;
+		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x2);
 		break;
+
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable all output discharge bits */
@@ -1278,6 +1284,11 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 			wm8990_write(codec, WM8990_EXT_CTL1, 0xa003);
 			wm8990_write(codec, WM8990_EXT_ACCESS_ENA, 0);
 		}
+
+		/* VMID=2*250k */
+		val = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_1) &
+			~WM8990_VMID_MODE_MASK;
+		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x4);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
1.5.6.5
