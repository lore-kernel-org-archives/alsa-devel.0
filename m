From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Mark WM8958 DSP2 registers readable
Date: Wed, 16 Mar 2011 22:45:17 +0000
Message-ID: <1300315517-25458-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49B3A10383C
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 23:45:20 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 328f328..bdd1ac7 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -55,6 +55,9 @@ static int wm8994_retune_mobile_base[] = {
 
 static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->control_data;
+
 	switch (reg) {
 	case WM8994_GPIO_1:
 	case WM8994_GPIO_2:
@@ -71,6 +74,15 @@ static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 	case WM8994_INTERRUPT_STATUS_2:
 	case WM8994_INTERRUPT_RAW_STATUS_2:
 		return 1;
+
+	case WM8958_DSP2_PROGRAM:
+	case WM8958_DSP2_CONFIG:
+	case WM8958_DSP2_EXECCONTROL:
+		if (control->type == WM8958)
+			return 1;
+		else
+			return 0;
+
 	default:
 		break;
 	}
-- 
1.7.4.1
