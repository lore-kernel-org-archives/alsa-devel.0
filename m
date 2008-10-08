From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Implement WM8510 bias level control
Date: Wed,  8 Oct 2008 10:37:59 +0100
Message-ID: <1223458680-9506-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00D22244D2
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <1223458680-9506-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM8510 bias level configuration blindly overwrites the power
management registers, interfering with the operation of DAPM.
Only adjust the specific bits required, implementing use of the VMID
resistor string configuration control as we go.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 142c49b..94cab49 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -55,6 +55,9 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 	0x0001,
 };
 
+#define WM8510_POWER1_BIASEN  0x08
+#define WM8510_POWER1_BUFIOEN 0x10
+
 /*
  * read wm8510 register cache
  */
@@ -526,23 +529,35 @@ static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	u16 power1 = wm8510_read_reg_cache(codec, WM8510_POWER1) & ~0x3;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		wm8510_write(codec, WM8510_POWER1, 0x1ff);
-		wm8510_write(codec, WM8510_POWER2, 0x1ff);
-		wm8510_write(codec, WM8510_POWER3, 0x1ff);
-		break;
 	case SND_SOC_BIAS_PREPARE:
+		power1 |= 0x1;  /* VMID 50k */
+		wm8510_write(codec, WM8510_POWER1, power1);
+		break;
+
 	case SND_SOC_BIAS_STANDBY:
+		power1 |= WM8510_POWER1_BIASEN | WM8510_POWER1_BUFIOEN;
+
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* Initial cap charge at VMID 5k */
+			wm8510_write(codec, WM8510_POWER1, power1 | 0x3);
+			mdelay(100);
+		}
+
+		power1 |= 0x2;  /* VMID 500k */
+		wm8510_write(codec, WM8510_POWER1, power1);
 		break;
+
 	case SND_SOC_BIAS_OFF:
-		/* everything off, dac mute, inactive */
-		wm8510_write(codec, WM8510_POWER1, 0x0);
-		wm8510_write(codec, WM8510_POWER2, 0x0);
-		wm8510_write(codec, WM8510_POWER3, 0x0);
+		wm8510_write(codec, WM8510_POWER1, 0);
+		wm8510_write(codec, WM8510_POWER2, 0);
+		wm8510_write(codec, WM8510_POWER3, 0);
 		break;
 	}
+
 	codec->bias_level = level;
 	return 0;
 }
@@ -640,6 +655,7 @@ static int wm8510_init(struct snd_soc_device *socdev)
 	}
 
 	/* power on device */
+	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm8510_add_controls(codec);
 	wm8510_add_widgets(codec);
-- 
1.5.6.5
