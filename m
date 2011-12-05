From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Rely on core enabling the wm8994
	with runtime PM
Date: Mon,  5 Dec 2011 15:18:04 +0000
Message-ID: <1323098284-26961-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323098284-26961-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EAC6103A77
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 16:18:08 +0100 (CET)
In-Reply-To: <1323098284-26961-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

No need to do this in the driver now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e3168be..a993690 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2089,8 +2089,6 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			pm_runtime_get_sync(codec->dev);
-
 			switch (control->type) {
 			case WM8994:
 				if (wm8994->revision < 4) {
@@ -2157,11 +2155,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
 			wm8994->cur_fw = NULL;
-
-			pm_runtime_put(codec->dev);
-		}
 		break;
 	}
 	codec->dapm.bias_level = level;
-- 
1.7.7.3
